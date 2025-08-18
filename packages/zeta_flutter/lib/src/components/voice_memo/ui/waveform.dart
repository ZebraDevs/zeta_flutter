import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

/// The visual waveform used in [ZetaAudioVisualizer] and [ZetaVoiceMemo.
class Waveform extends StatelessWidget {
  /// Constructs a [Waveform].
  const Waveform({
    super.key,
    required this.playedColor,
    required this.unplayedColor,
    required this.amplitudesNotifier,
    required this.playbackLocationVis,
    required this.onInteraction,
    required this.onLayoutChange,
  });

  /// The color of the waveform's bar elements after they have been played.
  final Color playedColor;

  /// The color of the waveform's bar elements before they have been played.
  final Color unplayedColor;

  /// The amplitudes of the waveform's bar elements.
  final ValueNotifier<List<double>> amplitudesNotifier;

  /// The current playback location of the waveform.
  final int? playbackLocationVis;

  /// Callback for interaction events on the waveform.
  final void Function(Offset) onInteraction;

  /// Callback for layout changes of the waveform.
  final void Function(BoxConstraints) onLayoutChange;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragUpdate: (details) => onInteraction(details.localPosition),
      onTapDown: (details) => onInteraction(details.localPosition),
      child: LayoutBuilder(
        builder: (context, constraints) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) onLayoutChange(constraints);
          });

          return ValueListenableBuilder<List<double>>(
            valueListenable: amplitudesNotifier,
            builder: (context, amplitudes, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(amplitudes.length, (index) {
                    final amplitude = amplitudes[index];
                    return AnimatedContainer(
                      key: ValueKey(index),
                      duration: ZetaAnimationLength.veryFast,
                      width: ZetaBorders.medium,
                      height: (amplitude * zeta.spacing.xl_4).clamp(ZetaBorders.small, zeta.spacing.xl_4),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: (playbackLocationVis ?? 0) > index ? playedColor : unplayedColor,
                        borderRadius: BorderRadius.all(zeta.radius.full),
                      ),
                    );
                  }),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('foregroundColor', playedColor))
      ..add(ColorProperty('tertiaryColor', unplayedColor))
      ..add(DiagnosticsProperty<ValueNotifier<List<double>>>('amplitudesNotifier', amplitudesNotifier))
      ..add(IntProperty('playbackLocationVis', playbackLocationVis))
      ..add(ObjectFlagProperty<void Function(Offset p1)>.has('onInteraction', onInteraction))
      ..add(ObjectFlagProperty<void Function(BoxConstraints p1)>.has('onLayoutChange', onLayoutChange));
  }
}
