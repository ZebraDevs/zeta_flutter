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
        return Material(
          color: (state.canRecord) && (state.duration == null || (state.duration! < state.maxRecordingDuration))
              ? null
              : zeta.colors.surfaceDisabled,
          borderRadius: BorderRadius.all(zeta.radius.full),
          child: InkWell(
            borderRadius: BorderRadius.all(zeta.radius.full),
            onTap: (!state.canRecord || (state.duration != null && state.duration! >= state.maxRecordingDuration))
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
              progress: state.canRecord && (state.duration == null || (state.duration! < state.maxRecordingDuration))
                  ? (state.duration != null
                      ? state.duration!.inMilliseconds / state.maxRecordingDuration.inMilliseconds
                      : 0)
                  : 0,
              child: IconTheme(
                data: IconThemeData(
                  color: state.canRecord && (state.duration == null || (state.duration! < state.maxRecordingDuration))
                      ? zeta.colors.mainDefault
                      : zeta.colors.mainDisabled,
                ),
                child: AnimatedCrossFade(
                  duration: ZetaAnimationLength.fast,
                  secondChild: const Icon(ZetaIcons.pause),
                  firstChild: const Icon(ZetaIcons.microphone),
                  crossFadeState: state.isRecording ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
