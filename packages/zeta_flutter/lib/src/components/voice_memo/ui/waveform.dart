// Documentation not required as this is an internal file.
// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

class Waveform extends StatelessWidget {
  const Waveform({
    super.key,
    required this.foregroundColor,
    required this.tertiaryColor,
    required this.amplitudesNotifier,
    required this.playbackLocationVis,
    required this.rowKey,
    required this.onInteraction,
    required this.onLayoutChange,
    required this.mounted,
  });

  final Color foregroundColor;
  final Color tertiaryColor;
  final ValueNotifier<List<double>> amplitudesNotifier;
  final int? playbackLocationVis;
  final GlobalKey rowKey;
  final void Function(Offset) onInteraction;
  final void Function(BoxConstraints) onLayoutChange;
  final bool mounted;

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
            if (mounted) onLayoutChange(constraints);
          });

          return ValueListenableBuilder<List<double>>(
            valueListenable: amplitudesNotifier,
            builder: (context, amplitudes, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  key: rowKey,
                  children: List.generate(amplitudes.length, (index) {
                    final amplitude = amplitudes[index];
                    return AnimatedContainer(
                      key: ValueKey(index),
                      duration: ZetaAnimationLength.veryFast,
                      width: ZetaBorders.medium,
                      height: (amplitude * zeta.spacing.xl_4).clamp(ZetaBorders.small, zeta.spacing.xl_4),
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      decoration: BoxDecoration(
                        color: (playbackLocationVis ?? 0) > index ? foregroundColor : tertiaryColor,
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
      ..add(ColorProperty('foregroundColor', foregroundColor))
      ..add(ColorProperty('tertiaryColor', tertiaryColor))
      ..add(DiagnosticsProperty<ValueNotifier<List<double>>>('amplitudesNotifier', amplitudesNotifier))
      ..add(IntProperty('playbackLocationVis', playbackLocationVis))
      ..add(DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>('rowKey', rowKey))
      ..add(ObjectFlagProperty<void Function(Offset p1)>.has('onInteraction', onInteraction))
      ..add(ObjectFlagProperty<void Function(BoxConstraints p1)>.has('onLayoutChange', onLayoutChange))
      ..add(DiagnosticsProperty<bool>('mounted', mounted));
  }
}
