import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';

import '../../../../zeta_flutter.dart';
import 'file_helpers.dart';
import 'wav_header.dart';

const int _defaultWavHeaderOffset = 44;
const int _wavHeaderSearchStart = 36;
const int _wavHeaderChunkSize = 8;
const List<int> _wavDataChunkMarker = [0x64, 0x61, 0x74, 0x61]; // "data" in ASCII
const int _minChunkDurationMs = 100;
const int _maxChunkDurationMs = 500;
const String _tempAudioFileName = 'temp_audio.wav';
const List<double> _fallbackAmps = [0, 0.375, 0.5, 1, 0.625, 1, 0.75, 0.75, 1, 1, 0.75, 1, 0.375, 0, 0, 0, 0, 0];

/// Extracts WAV amplitudes from a file URI, normalizing them for visualization.
///
/// This function is very basic, and does not handle all WAV formats, only PCM.
///
/// The extracted amplitudes are normalized to a range of 0.0 to 1.0, where 0.5 represents the average amplitude.
/// These values should not be considered accurate for audio playback, but rather for visual representation in a waveform.
///
/// If the presented file is not a WAV file, it will return null.
Future<List<double>?> extractWavAmplitudes(Uri fileUri, int linesNeeded, AudioPlaybackManager? manager) async {
  try {
    Uint8List bytes;
    if (kIsWeb) {
      // TODO(lu)e): This does not work for http assets?
      if (fileUri.isScheme('http') || fileUri.isScheme('https')) {
        final response = await http.get(fileUri);
        if (response.statusCode != 200) throw Exception('Failed to load WAV file from network');
        bytes = response.bodyBytes;
      } else if (fileUri.isScheme('asset') || fileUri.path.startsWith('assets/')) {
        final response = await http.get(fileUri);
        bytes = response.bodyBytes;
      } else {
        throw UnsupportedError('Unsupported URI scheme for web: ${fileUri.scheme}');
      }
    } else {
      bytes = await File(fileUri.toFilePath()).readAsBytes();
    }
    return await _parseWav(bytes, linesNeeded);
  } catch (e, _) {
    debugPrint('Error extracting WAV amplitudes: $e');
    if (manager != null && manager.loadedAudio == false) {
      return List<double>.filled(linesNeeded, 0);
    } else {
      return List<double>.generate(linesNeeded, (i) => _fallbackAmps[i % _fallbackAmps.length]);
    }
  }
}

List<double> _decodePCM(List<int> audioBytes, int bitsPerSample, int numChannels) {
  final bytesPerSample = bitsPerSample ~/ 8;
  return List.generate(audioBytes.length ~/ (bytesPerSample * numChannels), (i) {
    final sampleStart = i * bytesPerSample * numChannels;
    return List.generate(numChannels, (channel) {
          final channelStart = sampleStart + channel * bytesPerSample;
          return List.generate(bytesPerSample, (byteIndex) => audioBytes[channelStart + byteIndex] << (byteIndex * 8))
              .reduce((a, b) => a | b)
              .toSigned(bitsPerSample)
              .toDouble();
        }).reduce((a, b) => a + b) /
        numChannels;
  });
}

Future<List<double>> _parseWav(Uint8List bytes, int linesNeeded) async {
  final audioFormat = bytes[20] | (bytes[21] << 8);
  if (audioFormat != 1) throw UnsupportedError('Unsupported WAV format: Only PCM is supported');

  final numChannels = bytes[22] | (bytes[23] << 8);
  final bitsPerSample = bytes[34] | (bytes[35] << 8);
  final dataOffset = _findDataChunkOffset(bytes);
  final audioBytes = bytes.sublist(dataOffset);

  if (linesNeeded <= 0 || linesNeeded > audioBytes.length ~/ ((bitsPerSample ~/ 8) * numChannels)) {
    throw RangeError('Invalid linesNeeded value: $linesNeeded');
  }

  return _groupAndNormalizeSamples(
    _decodePCM(audioBytes, bitsPerSample, numChannels),
    linesNeeded,
  );
}

int _findDataChunkOffset(Uint8List bytes) {
  for (int i = _wavHeaderSearchStart; i < bytes.length - _wavHeaderChunkSize; i += 2) {
    if (bytes.sublist(i, i + 4).everyIndexed((index, value) => value == _wavDataChunkMarker[index])) {
      return i + _wavHeaderChunkSize;
    }
  }
  return _defaultWavHeaderOffset;
}

List<double> _groupAndNormalizeSamples(List<double> samples, int groupsCount) {
  final groupSize = samples.length ~/ groupsCount;
  final groups = List.generate(groupsCount, (i) => samples.skip(i * groupSize).take(groupSize).reduce(max));
  final maxAmplitude = groups.reduce(max);

  return maxAmplitude == 0 ? List.filled(groupsCount, 0) : groups.map((e) => e / maxAmplitude).toList();
}

Uint8List _generateWePCMWavHeader(List<Uint8List> audioChunks, RecordConfig recordConfig) {
  if (audioChunks.isNotEmpty) {
    final totalAudioBytes = audioChunks.fold<int>(0, (sum, chunk) => sum + chunk.length);
    final bytesPerSample = 2 * recordConfig.numChannels;
    final samples = totalAudioBytes ~/ bytesPerSample;
    return PCMWavHeader(
      channels: recordConfig.numChannels,
      sampleRate: recordConfig.sampleRate,
      samples: samples,
    ).header;
  }
  return Uint8List(0);
}

/// Audio recording state management helper class
class AudioRecordingManager {
  /// Creates an instance of [AudioRecordingManager] with the specified configuration.
  AudioRecordingManager({
    this.recordConfig = const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 16000,
      numChannels: 1,
      bitRate: 64000,
    ),
  });

  /// Configuration for audio recording
  final RecordConfig recordConfig;

  final AudioRecorder _record = AudioRecorder();
  final List<Uint8List> _audioChunks = [];

  bool _canRecord = false;
  bool _isRecording = false;
  Duration? _duration;
  Stream<Uint8List>? _stream;
  Timer? _recordingTimer;

  /// Whether recording is allowed (based on permissions)
  bool get canRecord => _canRecord;

  /// Whether currently recording
  bool get isRecording => _isRecording;

  /// Current recording duration
  Duration? get duration => _duration;

  /// Audio stream for the current recording
  Stream<Uint8List>? get stream => _stream;

  /// List of audio chunks recorded so far
  List<Uint8List> get audioChunks => List.unmodifiable(_audioChunks);

  /// Initialize the recording permissions
  Future<void> initialize() async {
    final hasPermission = await _record.hasPermission();
    _canRecord = hasPermission;
  }

  /// Start recording audio
  Future<void> startRecording() async {
    if (!_canRecord) return;

    _stream = await _record.startStream(recordConfig);
    _stream!.listen(_audioChunks.add);
    _duration = Duration.zero;
  }

  /// Start tracking recording duration
  void startTrackingDuration({
    required VoidCallback onDurationUpdate,
    required Duration maxDuration,
    required Duration warningDuration,
    required VoidCallback onWarning,
    required VoidCallback onMaxDurationReached,
  }) {
    _isRecording = true;
    _recordingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isRecording) {
        timer.cancel();
        return;
      }

      _duration = _duration! + const Duration(milliseconds: 100);

      if (_duration! >= maxDuration - warningDuration) {
        onWarning();
      }

      if (_duration! >= maxDuration) {
        unawaited(pauseRecording());
        onMaxDurationReached();
      }

      onDurationUpdate();
    });
  }

  /// Pause recording
  Future<void> pauseRecording() async {
    if (_isRecording) {
      await _record.pause();
      _isRecording = false;
      _recordingTimer?.cancel();
    }
  }

  /// Resume recording
  Future<void> resumeRecording({
    required VoidCallback onDurationUpdate,
    required Duration maxDuration,
    required Duration warningDuration,
    required VoidCallback onWarning,
    required VoidCallback onMaxDurationReached,
  }) async {
    if (!_isRecording && _canRecord) {
      await _record.resume();
      startTrackingDuration(
        onDurationUpdate: onDurationUpdate,
        maxDuration: maxDuration,
        warningDuration: warningDuration,
        onWarning: onWarning,
        onMaxDurationReached: onMaxDurationReached,
      );
    }
  }

  /// Reset recording state
  void resetRecording() {
    _stream = null;
    _duration = null;
    _isRecording = false;
    _recordingTimer?.cancel();
    _audioChunks.clear();
  }

  /// Dispose of resources
  Future<void> dispose() async {
    _recordingTimer?.cancel();
    await _record.dispose();
  }
}

/// Audio playback management helper class
class AudioPlaybackManager {
  AudioPlayer? _audioPlayer;
  Uri? _localFile;
  Duration? _duration;
  bool _playing = false;
  Duration _currentPosition = Duration.zero;
  StreamSubscription<Duration>? _positionSubscription;

  /// Whether the audio has been loaded and is playable (null = unknown, true/false = known)
  bool? loadedAudio;

  /// Whether audio is currently playing
  bool get isPlaying => _playing;

  /// Total duration of the loaded audio
  Duration? get duration => _duration;

  /// Current playback position
  Duration get currentPosition => _currentPosition;

  /// URI of the local audio file
  Uri? get localFile => _localFile;

  /// Initialize audio player
  Future<void> initialize({
    VoidCallback? onComplete,
    required ValueChanged<Duration> onPositionChanged,
  }) async {
    _audioPlayer ??= AudioPlayer();

    _audioPlayer!.onPlayerComplete.listen((_) {
      _playing = false;
      onComplete?.call();
      unawaited(resetPlayback());
    });

    _positionSubscription = _audioPlayer!.onPositionChanged.listen((position) {
      _currentPosition = position;
      onPositionChanged(position);
    });
  }

  /// Load audio from various sources
  Future<void> loadAudio({
    String? assetPath,
    String? url,
    String? deviceFilePath,
    List<Uint8List>? audioChunks,
    RecordConfig? recordConfig,
  }) async {
    if (assetPath != null) {
      _localFile = await handleFile(assetPath, FileFetchMode.asset);
    } else if (url != null) {
      _localFile = await handleFile(url, FileFetchMode.url);
    } else if (deviceFilePath != null) {
      _localFile = Uri.file(deviceFilePath);
    } else if (audioChunks != null && audioChunks.isNotEmpty && recordConfig != null) {
      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/$_tempAudioFileName');
      await tempFile.writeAsBytes(
        _generateWePCMWavHeader(audioChunks, recordConfig) + audioChunks.expand((x) => x).toList(),
      );
      _localFile = tempFile.uri;
    }
  }

  /// Reset playback to beginning
  Future<void> resetPlayback() async {
    _playing = false;
    _currentPosition = Duration.zero;

    if (_localFile != null && _audioPlayer != null) {
      try {
        await _audioPlayer!.setSourceUrl(_localFile!.toString());
        final duration = await _audioPlayer!.getDuration();
        _duration = duration;
        loadedAudio = true;
      } catch (_) {
        loadedAudio = false;
      }
    } else {
      loadedAudio = false;
    }
  }

  /// Play audio
  Future<void> play() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.resume();
      _playing = true;
    }
  }

  /// Pause audio
  Future<void> pause() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.pause();
      _playing = false;
    }
  }

  /// Seek to specific position
  Future<void> seek(Duration position) async {
    if (_audioPlayer != null) {
      await _audioPlayer!.seek(position);
    }
  }

  /// Dispose of resources
  Future<void> dispose() async {
    await _positionSubscription?.cancel();
    await _audioPlayer?.dispose();

    // Clean up temporary files
    if (_localFile != null) {
      try {
        final file = File.fromUri(_localFile!);
        if (file.existsSync() && file.path.contains(_tempAudioFileName)) {
          file.deleteSync();
        }
      } catch (_) {}
    }
  }
}

/// Audio waveform calculation helper
class AudioWaveformCalculator {
  /// Calculate waveform amplitudes for real-time recording
  static Future<List<double>> calculateRecordingWaveform({
    required List<Uint8List> audioChunks,
    required RecordConfig recordConfig,
    required int linesNeeded,
    required Duration audioDuration,
    required Duration maxRecordingDuration,
    required bool isRecording,
  }) async {
    if (audioChunks.isEmpty) {
      return List.filled(linesNeeded, 0);
    }

    final chunkDurationMs =
        (maxRecordingDuration.inMilliseconds ~/ linesNeeded).clamp(_minChunkDurationMs, _maxChunkDurationMs);

    final audioData = Uint8List.fromList([
      ..._generateWePCMWavHeader(audioChunks, recordConfig),
      ...audioChunks.expand((x) => x),
    ]);

    final linesNeededHere = isRecording ? (audioDuration.inMilliseconds / chunkDurationMs).ceil() : linesNeeded;

    final waveforms = await _parseWav(audioData, linesNeededHere);

    if (isRecording) {
      return [...List<double>.filled(linesNeeded - waveforms.length, 0), ...waveforms];
    } else {
      return waveforms;
    }
  }

  /// Generate default amplitudes for visualization
  static List<double> generateDefaultAmplitudes(int linesNeeded) {
    return List<double>.generate(linesNeeded, (i) => _fallbackAmps[i % _fallbackAmps.length]);
  }

  /// Calculate playback position for waveform visualization
  static int calculatePlaybackPosition({
    required Duration currentPosition,
    required Duration? totalDuration,
    required int linesNeeded,
  }) {
    if (totalDuration == null || totalDuration.inMilliseconds == 0) return 0;

    final localPosition = currentPosition.inMilliseconds / totalDuration.inMilliseconds;
    return (localPosition * linesNeeded).clamp(0, linesNeeded - 1).toInt();
  }

  /// Calculate position from gesture interaction
  static Duration calculateSeekPosition({
    required Offset gesturePosition,
    required double visualizerWidth,
    required Duration? totalDuration,
  }) {
    if (totalDuration == null) return Duration.zero;

    final playbackLocation = gesturePosition.dx / visualizerWidth;
    return Duration(milliseconds: (totalDuration.inMilliseconds * playbackLocation).round());
  }
}
