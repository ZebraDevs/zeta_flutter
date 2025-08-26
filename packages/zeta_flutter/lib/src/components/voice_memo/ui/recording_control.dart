import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../zeta_flutter.dart';
import '../state/recording_state.dart';

/// Recording control widget for [ZetaVoiceMemo].
class RecordingControl extends StatelessWidget {
  /// Construct a [RecordingControl].
  const RecordingControl({super.key});

  @override
  Widget build(BuildContext context) {
    final Zeta zeta = Zeta.of(context);
    return Consumer<RecordingState>(
      builder: (context, state, child) {
        final bool canRecordNow =
            state.canRecord && (state.duration == null || (state.duration! < state.maxRecordingDuration));
        final double progress =
            canRecordNow ? (state.duration?.inMilliseconds ?? 0) / state.maxRecordingDuration.inMilliseconds : 0;

        return Material(
          color: canRecordNow ? null : zeta.colors.surfaceDisabled,
          borderRadius: BorderRadius.all(zeta.radius.full),
          child: InkWell(
            borderRadius: BorderRadius.all(zeta.radius.full),
            onTap: (!state.canRecord || state.duration != null && state.duration! >= state.maxRecordingDuration)
                ? null
                : () async {
                    if (state.isRecording) {
                      await state.pauseRecording();
                    } else if (state.duration != null) {
                      await state.resumeRecording();
                    } else {
                      await state.startRecording();
                    }
                  },
            child: ZetaProgressCircle(
              size: ZetaCircleSizes.l,
              progress: progress,
              showTrack: true,
              child: Center(
                child: IconTheme(
                  data: IconThemeData(color: canRecordNow ? zeta.colors.mainDefault : zeta.colors.mainDisabled),
                  child: AnimatedCrossFade(
                    duration: ZetaAnimationLength.fast,
                    secondChild: Container(
                      width: zeta.spacing.xl_4,
                      height: zeta.spacing.xl_4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
                      ),
                      child: const Icon(ZetaIcons.pause),
                    ),
                    firstChild: Container(
                      width: zeta.spacing.xl_4,
                      height: zeta.spacing.xl_4,
                      decoration: BoxDecoration(
                        color: zeta.colors.surfaceHover,
                        borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
                      ),
                      child: const Icon(ZetaIcons.microphone),
                    ),
                    crossFadeState: state.isRecording ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
