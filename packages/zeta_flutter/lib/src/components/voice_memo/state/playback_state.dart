import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';

import '../voice_memo.dart';
import 'wav_header.dart';

/// Enum to specify how to fetch the file: from assets or from a URL.
enum FileFetchMode {
  /// File saved as local asset in app.
  asset,

  /// File fetched from a URL.
  url
}

/// State class for managing audio playback in the [ZetaVoiceMemo] and [ZetaAudioVisualizer].
class PlaybackState extends ChangeNotifier {
  /// Constructs a [PlaybackState].
  PlaybackState({String? assetPath, String? deviceFilePath, String? url, Uint8List? bytes}) {
    unawaited(_init(assetPath, deviceFilePath, url, bytes));
    _audioPlayer.onPlayerComplete.listen((_) => resetPlayback());
    _positionSubscription = _audioPlayer.onPositionChanged.listen(_onPositionChanged);
  }

  Future<void> _init(String? assetPath, String? deviceFilePath, String? url, Uint8List?  bytes) async {
    await loadAudio(assetPath: assetPath, deviceFilePath: deviceFilePath, url: url,bytes: bytes);
    await resetPlayback();
  }

  void _onPositionChanged(Duration position) {
    final totalMs = duration?.inMilliseconds ?? 0;
    final newPercent = totalMs > 0 ? position.inMilliseconds / totalMs : 0.0;
    if (newPercent != _playbackPercent) {
      _playbackPercent = newPercent;
      notifyListeners();
    }
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  Uri? _localFile;
  Uint8List? _audioChunks;
  Duration? _duration;

  /// Duration of currently playing content.
  Duration? get duration => _duration;
  set duration(Duration? value) {
    if (value != _duration) {
      _duration = value;
      notifyListeners();
    }
  }

  StreamSubscription<Duration>? _positionSubscription;
  bool? _loadedAudio;
  double _playbackPercent = 0;
  bool _error = false;

  /// Whether there is an error fetching the audio.
  bool get error => _error;
  set error(bool value) {
    if (value != _error) {
      _error = value;
      notifyListeners();
    }
  }

  bool _playing = false;

  /// Whether the audio is currently playing.
  bool get playing => _playing;
  set playing(bool value) {
    if (value != _playing) {
      _playing = value;
      notifyListeners();
    }
  }

  /// Whether the audio has been loaded and is playable (null = unknown, true/false = known)
  bool? get loadedAudio => _loadedAudio;

  /// Local audio chunks for playback
  Uint8List? get audioChunks => _audioChunks;

  /// URI of the local audio file
  Uri? get localFile => _localFile;

  /// Playback progress as a percentage (0.0 to 1.0)
  double get playbackPercent => _playbackPercent;

  /// Loads audio from various sources to be played back
  Future<void> loadAudio({
    String? assetPath,
    String? url,
    String? deviceFilePath,
    Uint8List? bytes,
    List<Uint8List>? audioChunks,
    RecordConfig? recordConfig,
  }) async {
    if (assetPath != null) {
      _localFile = await handleFile(assetPath, FileFetchMode.asset);
    } else if (url != null) {
      _localFile = await handleFile(url, FileFetchMode.url);
    } else if (deviceFilePath != null) {
      _localFile = Uri.file(deviceFilePath);
    } else if (bytes != null){
      _audioChunks = bytes;
    
    } else if (audioChunks != null && audioChunks.isNotEmpty && recordConfig != null) {
      _audioChunks = Uint8List.fromList([
        ...generatePCMWavHeader(audioChunks, recordConfig),
        ...audioChunks.expand((x) => x),
      ]);
    }
  }

  /// Resets the playback state, clearing the current audio and resetting playback progress.
  Future<void> resetPlayback() async {
    _playbackPercent = 0;
    _playing = false;
    notifyListeners();
    try {
      if (_localFile != null) {
        await _audioPlayer.setSourceUrl(_localFile!.toString());
        _loadedAudio = true;
      } else if (_audioChunks != null) {
        await _audioPlayer.setSourceBytes(_audioChunks!, mimeType: 'audio/wav');
        _loadedAudio = true;
        _duration = null;
      } else {
        _loadedAudio = false;
      }
    } catch (e) {
      debugPrint('Error loading audio: $e');
      _loadedAudio = false;
    }
    if (_loadedAudio ?? false) {
      _duration ??= await _audioPlayer.getDuration();
    }
    notifyListeners();
  }

  /// Play audio from the current position
  Future<void> play() async {
    if (_playbackPercent >= 1.0) {
      await resetPlayback();
    }
    await _audioPlayer.resume();
    if (!playing) playing = true;
  }

  /// Pause audio
  Future<void> pause() async {
    await _audioPlayer.pause();
    if (playing) playing = false;
  }

  /// Seek to specific position
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  /// Seeks to a position based on a gesture in the visualizer
  Future<void> seekFromPosition(Offset gesturePosition, double visualizerWidth, Duration? totalDuration) async {
    if (totalDuration == null || visualizerWidth == 0) return;
    final percent = (gesturePosition.dx / visualizerWidth).clamp(0.0, 1.0);
    await seek(Duration(milliseconds: (totalDuration.inMilliseconds * percent).round()));
  }

  /// Resets state values.
  ///
  /// Currently only used when resetting a recorded voice memo.
  void reset() {
    _playbackPercent = 0;
    _playing = false;
    _audioChunks = null;
    _duration = null;
    unawaited(_audioPlayer.setSource(UrlSource('')));

    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_positionSubscription?.cancel());
    unawaited(_audioPlayer.dispose());
    super.dispose();
  }

  /// Creates a header for given PCM WAV audio data
  Uint8List generatePCMWavHeader(List<Uint8List> audioChunks, RecordConfig recordConfig) {
    if (audioChunks.isEmpty) return Uint8List(0);
    final totalAudioBytes = audioChunks.fold<int>(0, (sum, chunk) => sum + chunk.length);
    final bytesPerSample = 2 * recordConfig.numChannels;
    final samples = totalAudioBytes ~/ bytesPerSample;
    return PCMWavHeader(
      channels: recordConfig.numChannels,
      sampleRate: recordConfig.sampleRate,
      samples: samples,
    ).header;
  }

  Uri _sanitizeURLForWeb(String fileName) {
    final uri = Uri.tryParse(fileName);
    if (uri?.isAbsolute ?? false) return uri!;
    // URL-encode for relative asset paths
    return Uri.parse(Uri.decodeFull(fileName) != fileName ? fileName : Uri.encodeFull(fileName));
  }

  /// Handles file fetching for both assets and URLs to cache them locally.
  Future<Uri?> handleFile(String fileNameOrUrl, FileFetchMode mode) async {
    if (kIsWeb) {
      final uri = mode == FileFetchMode.asset
          ? (!fileNameOrUrl.startsWith('/assets/')
              ? _sanitizeURLForWeb('/assets/$fileNameOrUrl')
              : _sanitizeURLForWeb(fileNameOrUrl))
          : _sanitizeURLForWeb(fileNameOrUrl);
      try {
        await http.get(uri);
        return uri;
      } catch (e) {
        error = true;
        return null;
      }
    }
    final tempDir = Directory.systemTemp.path;
    final fileName = mode == FileFetchMode.url
        ? (Uri.decodeFull(fileNameOrUrl) != fileNameOrUrl ? fileNameOrUrl : Uri.encodeFull(fileNameOrUrl))
        : fileNameOrUrl;
    final filePath = mode == FileFetchMode.asset ? '$tempDir$fileNameOrUrl' : '$tempDir/$fileName';
    final file = File(filePath);
    if (file.existsSync()) return file.uri;
    if (mode == FileFetchMode.asset) {
      final byteData = await rootBundle.load(fileNameOrUrl);
      await file.create(recursive: true);
      await file.writeAsBytes(byteData.buffer.asUint8List());
    } else {
      final response = await http.get(Uri.parse(fileNameOrUrl));
      if (response.statusCode != 200) throw Exception('Failed to download audio file');
      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
    }
    return file.uri;
  }
}
