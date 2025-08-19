import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

import 'audio_helpers.dart';
import 'file_helpers.dart';

/// Audio playback management helper class
class AudioPlaybackManager {
  AudioPlayer? _audioPlayer;
  Uri? _localFile;

  /// Local audio chunks for playback
  Uint8List? localChunks;
  Duration? _duration;
  // bool _playing = false;
  Duration _currentPosition = Duration.zero;
  StreamSubscription<Duration>? _positionSubscription;

  /// Whether the audio has been loaded and is playable (null = unknown, true/false = known)
  bool? loadedAudio;

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
      // _playing = false;
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
      localChunks = Uint8List.fromList([
        ...generatePCMWavHeader(audioChunks, recordConfig),
        ...audioChunks.expand((x) => x),
      ]);
    }
  }

  /// Reset playback to beginning
  Future<void> resetPlayback() async {
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
    } else if (localChunks != null && _audioPlayer != null) {
      await _audioPlayer!.setSourceBytes(localChunks!, mimeType: 'audio/wav');
      _duration = await _audioPlayer!.getDuration();
      loadedAudio = true;
    } else {
      loadedAudio = false;
    }
  }

  /// Play audio
  Future<void> play() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.resume();
    }
  }

  /// Pause audio
  Future<void> pause() async {
    if (_audioPlayer != null) {
      await _audioPlayer!.pause();
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
  }
}
