import 'package:flutter/material.dart';
import 'audio_helpers.dart';

/// Controller for managing voice memo recordings.
class VoiceMemoController {
  /// Constructs a [VoiceMemoController].
  const VoiceMemoController({
    required this.recordingManager,
    required this.maxRecordingDuration,
    required this.warningDuration,
    required this.onWarningChanged,
  });

  /// The audio recording manager.
  final AudioRecordingManager recordingManager;

  /// The maximum recording duration.
  final Duration maxRecordingDuration;

  /// The duration after which a warning should be shown.
  final Duration warningDuration;

  /// Callback for when a warning is triggered.
  final VoidCallback onWarningChanged;

  /// Starts the audio recording.
  Future<void> startRecording(VoidCallback setWarning) async {
    await recordingManager.startRecording();
    recordingManager.startTrackingDuration(
      onDurationUpdate: onWarningChanged,
      maxDuration: maxRecordingDuration,
      warningDuration: warningDuration,
      onWarning: () => setWarning(),
      onMaxDurationReached: () => setWarning(),
    );
  }

  /// Pauses the audio recording.
  Future<void> pauseRecording(VoidCallback setWarning) async {
    await recordingManager.pauseRecording();
    setWarning();
  }

  /// Resumes the audio recording.
  Future<void> resumeRecording(VoidCallback setWarning) async {
    await recordingManager.resumeRecording(
      onDurationUpdate: onWarningChanged,
      maxDuration: maxRecordingDuration,
      warningDuration: warningDuration,
      onWarning: () => setWarning(),
      onMaxDurationReached: () => setWarning(),
    );
  }

  /// Resets and restarts the audio recording.
  void restartRecording(VoidCallback setWarning, AudioPlaybackManager playbackManager) {
    recordingManager.resetRecording(playbackManager);
    setWarning();
  }
}
