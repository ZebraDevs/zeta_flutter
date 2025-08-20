// ignore_for_file: public_member_api_docs
import 'dart:async';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

import 'audio_helpers.dart';
import 'file_helpers.dart';

class PlaybackState extends ChangeNotifier {
  PlaybackState({
    String? assetPath,
    String? deviceFilePath,
    String? url,
  }) : path = Uri(path: assetPath ?? deviceFilePath ?? url ?? '') {
    unawaited(
      loadAudio(
        assetPath: assetPath,
        deviceFilePath: deviceFilePath,
        url: url,
      ).then((_) => unawaited(resetPlayback())),
    );

    _audioPlayer.onPlayerComplete.listen((_) => unawaited(resetPlayback()));
    _positionSubscription = _audioPlayer.onPositionChanged.listen((position) {
      final newPlaybackPercent = _duration != null ? position.inMilliseconds / _duration!.inMilliseconds : 0.0;
      if (newPlaybackPercent != _playbackPercent) {
        _playbackPercent = newPlaybackPercent;
        notifyListeners();
      }
    });
    unawaited(resetPlayback());
  }

  final Uri? path;

  final AudioPlayer _audioPlayer = AudioPlayer();
  Uri? _localFile;
  Uint8List? _localChunks;
  Duration? _duration;
  StreamSubscription<Duration>? _positionSubscription;
  bool? _loadedAudio;
  double _playbackPercent = 0;
  bool playing = false;

  /// Whether the audio has been loaded and is playable (null = unknown, true/false = known)
  bool? get loadedAudio => _loadedAudio;

  /// Local audio chunks for playback
  Uint8List? get localChunks => _localChunks;

  /// Total duration of the loaded audio
  Duration? get duration => _duration;

  /// Current playback position
  // Duration get currentPosition => _currentPosition;

  /// URI of the local audio file
  Uri? get localFile => _localFile;

  /// Playback progress as a percentage (0.0 to 1.0)
  double get playbackPercent => _playbackPercent;

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
      _localChunks = Uint8List.fromList([
        ...generatePCMWavHeader(audioChunks, recordConfig),
        ...audioChunks.expand((x) => x),
      ]);
    }
  }

  /// Reset playback to beginning
  Future<void> resetPlayback() async {
    _playbackPercent = 0;
    playing = false;
    if (_localFile != null) {
      try {
        await _audioPlayer.setSourceUrl(_localFile!.toString());
        final duration = await _audioPlayer.getDuration();
        _duration = duration;
        _loadedAudio = true;
      } catch (_) {
        _loadedAudio = false;
      }
    } else if (localChunks != null) {
      await _audioPlayer.setSourceBytes(localChunks!, mimeType: 'audio/wav');
      _duration = await _audioPlayer.getDuration();
      _loadedAudio = true;
    } else {
      _loadedAudio = false;
    }

    notifyListeners();
  }

  /// Play audio
  Future<void> play() async {
    await _audioPlayer.resume();
    playing = true;
    notifyListeners();
  }

  /// Pause audio
  Future<void> pause() async {
    await _audioPlayer.pause();
    playing = false;
    notifyListeners();
  }

  /// Seek to specific position
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  Future<void> seekFromPosition(Offset gesturePosition, double visualizerWidth, Duration? totalDuration) async {
    if (totalDuration == null) return;

    final playbackLocation = gesturePosition.dx / visualizerWidth;
    await seek(Duration(milliseconds: (totalDuration.inMilliseconds * playbackLocation).round()));
  }

  @override
  void dispose() {
    unawaited(_positionSubscription?.cancel());
    unawaited(_audioPlayer.dispose());
    super.dispose();
  }
}
