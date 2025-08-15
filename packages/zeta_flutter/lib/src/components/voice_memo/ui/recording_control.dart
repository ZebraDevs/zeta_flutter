// Documentation not required as this is an internal file.
// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../zeta_flutter.dart';
import '../state/audio_helpers.dart';

/// Recording control widget for [ZetaVoiceMemo].
class RecordingControl extends StatelessWidget {
  const RecordingControl({
    required this.recordingManager,
    required this.maxRecordingDuration,
    required this.onStartRecording,
    required this.onPauseRecording,
    required this.onResumeRecording,
    super.key,
  });

  final AudioRecordingManager recordingManager;
  final Duration maxRecordingDuration;
  final Future<void> Function() onStartRecording;
  final Future<void> Function() onPauseRecording;
  final Future<void> Function() onResumeRecording;

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
