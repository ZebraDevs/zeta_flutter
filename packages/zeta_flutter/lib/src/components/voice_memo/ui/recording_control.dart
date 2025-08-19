import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../zeta_flutter.dart';
import '../state/recording_manager.dart';

/// Recording control widget for [ZetaVoiceMemo].
class RecordingControl extends StatelessWidget {
  /// Construct a [RecordingControl].
  const RecordingControl({
    required this.recordingManager,
    required this.maxRecordingDuration,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    super.key,
  });

  /// Manages the recording.
  final AudioRecordingManager recordingManager;

  /// Max duration that can be recorded before cutting off.
  final Duration maxRecordingDuration;

  /// Callback when recording is started.
  final AsyncCallback onStartRecording;

  /// Callback when recording is paused.
  final AsyncCallback onPauseRecording;

  /// Callback when recording is resumed.
  final AsyncCallback onResumeRecording;

  @override
  Widget build(BuildContext context) {
    final Zeta zeta = Zeta.of(context);
    return Material(
      color: recordingManager.canRecord &&
              (recordingManager.duration == null || (recordingManager.duration! < maxRecordingDuration))
          ? null
          : zeta.colors.surfaceDisabled,
      borderRadius: BorderRadius.all(zeta.radius.full),
      child: InkWell(
        borderRadius: BorderRadius.all(zeta.radius.full),
        onTap: recordingManager.canRecord &&
                (recordingManager.duration == null || (recordingManager.duration! < maxRecordingDuration))
            ? () {
                if (recordingManager.isRecording) {
                  unawaited(onPauseRecording());
                } else if (recordingManager.duration != null) {
                  unawaited(onResumeRecording());
                } else {
                  unawaited(onStartRecording());
                }
              }
            : null,
        child: ZetaProgressCircle(
          size: ZetaCircleSizes.l,
          progress: recordingManager.canRecord &&
                  (recordingManager.duration == null || (recordingManager.duration! < maxRecordingDuration))
              ? (recordingManager.duration != null
                  ? recordingManager.duration!.inMilliseconds / maxRecordingDuration.inMilliseconds
                  : 0)
              : 0,
          child: IconTheme(
            data: IconThemeData(
              color: recordingManager.canRecord &&
                      (recordingManager.duration == null || (recordingManager.duration! < maxRecordingDuration))
                  ? zeta.colors.mainDefault
                  : zeta.colors.mainDisabled,
            ),
            child: AnimatedCrossFade(
              duration: ZetaAnimationLength.fast,
              secondChild: const Icon(ZetaIcons.pause),
              firstChild: const Icon(ZetaIcons.microphone),
              crossFadeState: recordingManager.isRecording ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AudioRecordingManager>('recordingManager', recordingManager))
      ..add(DiagnosticsProperty<Duration>('maxRecordingDuration', maxRecordingDuration))
      ..add(ObjectFlagProperty<Future<void> Function()>.has('onStartRecording', onStartRecording))
      ..add(ObjectFlagProperty<Future<void> Function()>.has('onPauseRecording', onPauseRecording))
      ..add(ObjectFlagProperty<Future<void> Function()>.has('onResumeRecording', onResumeRecording));
  }
}
