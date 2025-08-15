// Documentation not required as this is an internal file.
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'audio_helpers.dart';

class VoiceMemoController {
  const VoiceMemoController({
    required this.recordingManager,
    required this.maxRecordingDuration,
    required this.warningDuration,
    required this.onWarningChanged,
  });
  final AudioRecordingManager recordingManager;
  final Duration maxRecordingDuration;
  final Duration warningDuration;
  final VoidCallback onWarningChanged;

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

  Future<void> pauseRecording(VoidCallback setWarning) async {
    await recordingManager.pauseRecording();
    setWarning();
  }

  Future<void> resumeRecording(VoidCallback setWarning) async {
    await recordingManager.resumeRecording(
      onDurationUpdate: onWarningChanged,
      maxDuration: maxRecordingDuration,
      warningDuration: warningDuration,
      onWarning: () => setWarning(),
      onMaxDurationReached: () => setWarning(),
    );
  }

  void restartRecording(VoidCallback setWarning, AudioPlaybackManager playbackManager) {
    recordingManager.resetRecording(playbackManager);
    setWarning();
  }
}

String getVoiceMemoLabel({
  required bool showWarning,
  required bool playing,
  required Duration? duration,
  required Duration maxRecordingDuration,
  required String maxLimitLabel,
  required String playingLabel,
  required String sendMessageLabel,
  required String recordingLabel,
}) {
  if (showWarning) {
    final secondsLeft = maxRecordingDuration.inSeconds - (duration?.inSeconds ?? 0);
    return maxLimitLabel.replaceAll('{timer}', secondsLeft.toString());
  } else if (playing) {
    return playingLabel;
  } else if (duration != null && duration.inMilliseconds > 0) {
    return sendMessageLabel;
  } else {
    return recordingLabel;
  }
}
