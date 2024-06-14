import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/tokens.dart';
import '../../zeta.dart';

/// Slider component with customized styling
class ZetaSlider extends StatefulWidget {
  /// Default constructor for [ZetaSlider]
  const ZetaSlider({
    super.key,
    required this.value,
    this.onChange,
    this.rounded = false,
    this.divisions,
  });

  /// Double value to represent slider percentage
  final double value;

  /// Callback to handle changing of slider
  final ValueChanged<double>? onChange;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Number of divisions.
  final int? divisions;

  @override
  State<ZetaSlider> createState() => _ZetaSliderState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DoubleProperty('value', value))
      ..add(ObjectFlagProperty<ValueChanged<double>?>.has('onChange', onChange))
      ..add(IntProperty('divisions', divisions));
  }
}

class _ZetaSliderState extends State<ZetaSlider> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return SliderTheme(
      data: SliderThemeData(
        /** TODO: Match with new colors */

        /// Active Track
        activeTrackColor: _activeColor,
        disabledActiveTrackColor: colors.surfaceDisabled,

        /// Inactive Track
        inactiveTrackColor: colors.surfaceInfoSubtle,

        /// Ticks
        activeTickMarkColor: colors.surfaceDefault,
        inactiveTickMarkColor: colors.surfaceDefault,

        /// Thumb
        thumbColor: colors.surfaceDefaultInverse,
        disabledThumbColor: colors.surfaceDisabled,
        overlayShape: SliderThumb(size: ZetaSpacing.xl_1, rounded: widget.rounded, color: _activeColor),
        thumbShape: SliderThumb(
          size: ZetaSpacing.large,
          rounded: widget.rounded,
          color: _activeColor,
        ),
      ),
      child: Slider(
        value: widget.value,
        onChanged: widget.onChange,
        divisions: widget.divisions,
        onChangeStart: (_) {
          setState(() {
            _selected = true;
          });
        },
        onChangeEnd: (_) {
          setState(() {
            _selected = false;
          });
        },
      ),
    );
  }

  Color get _activeColor {
    final colors = Zeta.of(context).colors;
    if (widget.onChange == null) {
      return colors.surfaceDisabled;
    }
    return _selected ? colors.primary : colors.surfaceDefaultInverse;
  }
}

/// Custom slider thumb component
class SliderThumb extends SliderComponentShape {
  /// Constructor for [SliderThumb]
  const SliderThumb({required this.size, required this.rounded, required this.color});

  /// Radius or width/height for [SliderThumb] depending on shape
  final double size;

  /// If [SliderThumb] is circular or a square
  final bool rounded;

  /// Color of [SliderThumb]
  final Color color;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(size);
  }

  /// Paints thumb
  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    // draw icon with text painter
    rounded
        ? canvas.drawCircle(center, size, paint)
        : canvas.drawRect(Rect.fromCenter(center: center, width: size, height: size), paint);
  }
}
