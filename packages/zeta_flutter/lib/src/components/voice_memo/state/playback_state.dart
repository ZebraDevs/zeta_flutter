// ignore_for_file: public_member_api_docs
import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:record/record.dart';

import 'wav_header.dart';

/// Enum to specify how to fetch the file: from assets or from a URL.
enum FileFetchMode {
  /// File saved as local asset in app.
  asset,

  /// File fetched from a URL.
  url
}

class PlaybackState extends ChangeNotifier {
  PlaybackState({
    String? assetPath,
    String? deviceFilePath,
    String? url,
  }) {
    unawaited(
      loadAudio(
        assetPath: assetPath,
        deviceFilePath: deviceFilePath,
        url: url,
      ).then((_) => resetPlayback()),
    );
    _audioPlayer.onPlayerComplete.listen((_) => resetPlayback());
    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      final newPercent = _duration != null && _duration!.inMilliseconds > 0
          ? position.inMilliseconds / _duration!.inMilliseconds
          : 0.0;
      if (newPercent != _playbackPercent) {
        _playbackPercent = newPercent;
        notifyListeners();
      }
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  Uri? _localFile;
  Uint8List? _localChunks;
  Duration? _duration;
  StreamSubscription<Duration>? _positionSubscription;
  bool? _loadedAudio;
  double _playbackPercent = 0;
  bool _playing = false;

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
  Uint8List? get localChunks => _localChunks;

  /// Total duration of the loaded audio
  Duration? get duration => _duration;

  /// URI of the local audio file
  Uri? get localFile => _localFile;

  /// Playback progress as a percentage (0.0 to 1.0)
  double get playbackPercent => _playbackPercent;

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
      _localChunks = Uint8List.fromList([
        ...generatePCMWavHeader(audioChunks, recordConfig),
        ...audioChunks.expand((x) => x),
      ]);
    }
  }

  Future<void> resetPlayback() async {
    _playbackPercent = 0;
    _playing = false;
    notifyListeners();
    try {
      if (_localFile != null) {
        await _audioPlayer.setSourceUrl(_localFile!.toString());
        _duration = await _audioPlayer.getDuration();
        _loadedAudio = true;
      } else if (_localChunks != null) {
        await _audioPlayer.setSourceBytes(_localChunks!, mimeType: 'audio/wav');
        _duration = await _audioPlayer.getDuration();
        _loadedAudio = true;
      } else {
        _loadedAudio = false;
      }
    } catch (e) {
      debugPrint('Error loading audio: $e');
      _loadedAudio = false;
    }
    notifyListeners();
  }

  Future<void> play() async {
    // If playback is at the end, reset before playing again
    if (_playbackPercent >= 1.0 || _audioPlayer.state == PlayerState.completed) {
      await resetPlayback();
    }
    await _audioPlayer.resume();
    if (!playing) {
      playing = true;
      notifyListeners();
    }
  }

  /// Pause audio
  Future<void> pause() async {
    await _audioPlayer.pause();
    if (playing) {
      playing = false;
      notifyListeners();
    }
  }

  /// Seek to specific position
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  Future<void> seekFromPosition(Offset gesturePosition, double visualizerWidth, Duration? totalDuration) async {
    if (totalDuration == null || visualizerWidth == 0) return;
    final percent = (gesturePosition.dx / visualizerWidth).clamp(0.0, 1.0);
    await seek(Duration(milliseconds: (totalDuration.inMilliseconds * percent).round()));
  }

  @override
  void dispose() {
    unawaited(_positionSubscription?.cancel());
    unawaited(_audioPlayer.dispose());
    super.dispose();
  }

  /// Creates a header for given PCM WAV audio data
  Uint8List generatePCMWavHeader(List<Uint8List> audioChunks, RecordConfig recordConfig) {
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

  Uri _sanitizeURLForWeb(String fileName) {
    final uri = Uri.tryParse(fileName);
    if (uri?.isAbsolute ?? false) return uri!;

    // URL-encode for relative asset paths
    final encoded = Uri.decodeFull(fileName) != fileName ? fileName : Uri.encodeFull(fileName);
    return Uri.parse(encoded);
  }

  /// Handles file fetching for both assets and URLs to cache them locally.
  Future<Uri> handleFile(String fileNameOrUrl, FileFetchMode mode) async {
    if (kIsWeb && mode == FileFetchMode.asset) {
      late final Uri uri;
      if (!fileNameOrUrl.startsWith('/assets/')) {
        // For web, we need to ensure the asset path is correct
        uri = _sanitizeURLForWeb('/assets/$fileNameOrUrl');
      } else {
        uri = _sanitizeURLForWeb(fileNameOrUrl);
      }

      // We rely on browser caching here. Once the browser downloads this file,
      // the native side implementation should be able to access it from cache.
      await http.get(uri);

      return uri;
    }
    if (kIsWeb && mode == FileFetchMode.url) {
      final uri = _sanitizeURLForWeb(fileNameOrUrl);
      // We rely on browser caching here. Once the browser downloads this file,
      // the native side implementation should be able to access it from cache.
      await http.get(uri);
      return uri;
    }

    final tempDir = Directory.systemTemp.path;
    final fileName = mode == FileFetchMode.url
        ? Uri.decodeFull(fileNameOrUrl) != fileNameOrUrl
            ? fileNameOrUrl
            : Uri.encodeFull(fileNameOrUrl)
        : fileNameOrUrl;
    final filePath = mode == FileFetchMode.asset ? '$tempDir$fileNameOrUrl' : '$tempDir/$fileName';
    final file = File(filePath);

    // Check if the file already exists
    if (file.existsSync()) {
      return file.uri;
    }

    if (mode == FileFetchMode.asset) {
      // Read local asset from rootBundle and store it
      final byteData = await rootBundle.load(fileNameOrUrl);
      await file.create(recursive: true);
      await file.writeAsBytes(byteData.buffer.asUint8List());
    } else {
      // Download the file if it doesn't exist
      final response = await http.get(Uri.parse(fileNameOrUrl));
      if (response.statusCode != 200) {
        throw Exception('Failed to download audio file');
      }

      await file.create(recursive: true);
      await file.writeAsBytes(response.bodyBytes);
    }

    return file.uri;
  }
}
