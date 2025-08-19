import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:record/record.dart';

import 'playback_manager.dart';

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

  /// Initialize the recording permissions
  Future<void> initialize() async {
    final hasPermission = await _record.hasPermission();
    _canRecord = hasPermission;
  }

  /// Start recording audio
  Future<void> startRecording() async {
    if (!_canRecord) return;
    _stream = await _record.startStream(recordConfig);
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
  void resetRecording(AudioPlaybackManager playManager) {
    unawaited(_stream?.drain());
    _stream = null;

    _duration = null;
    _isRecording = false;
    _recordingTimer?.cancel();
    playManager.localChunks = null;

    unawaited(_record.cancel());
  }

  /// Dispose of resources
  Future<void> dispose() async {
    _recordingTimer?.cancel();
    await _record.dispose();
  }
}
