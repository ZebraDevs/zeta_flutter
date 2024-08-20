import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Slider component with customized styling.
/// {@category Components}
class ZetaSlider extends ZetaStatefulWidget {
  /// Default constructor for [ZetaSlider]
  const ZetaSlider({
    super.key,
    super.rounded,
    required this.value,
    this.onChange,
    this.divisions,
    this.semanticLabel,
    this.min = 0.0,
    this.max = 1.0,
  });

  /// Double value to represent slider percentage.
  ///
  /// Default [min] / [max] are 0.0 and 1.0 respectively; this value should be between [min] and [max].
  final double value;

  /// Callback to handle changing of slider
  final ValueChanged<double>? onChange;

  /// Number of divisions.
  final int? divisions;

  /// Value passed to the wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  /// Minimum value of the slider.
  final double min;

  /// Maximum value of the slider.
  final double max;

  @override
  State<ZetaSlider> createState() => _ZetaSliderState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DoubleProperty('value', value))
      ..add(ObjectFlagProperty<ValueChanged<double>?>.has('onChange', onChange))
      ..add(IntProperty('divisions', divisions))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DoubleProperty('max', max))
      ..add(DoubleProperty('min', min));
  }
}

class _ZetaSliderState extends State<ZetaSlider> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return MergeSemantics(
      child: Semantics(
        label: widget.semanticLabel,
        child: SliderTheme(
          data: SliderThemeData(
            // TODO(UX-1136): Match with new colors

            /// Active Track
            activeTrackColor: _activeColor,
            disabledActiveTrackColor: colors.surface.disabled,

            /// Inactive Track
            inactiveTrackColor: colors.surface.infoSubtle,

            /// Ticks
            activeTickMarkColor: colors.surface.defaultColor,
            inactiveTickMarkColor: colors.surface.defaultColor,

            /// Thumb
            thumbColor: colors.surface.defaultInverse,
            disabledThumbColor: colors.surface.disabled,
            overlayShape: _SliderThumb(
              size: Zeta.of(context).spacing.xl / 2,
              rounded: context.rounded,
              color: _activeColor,
            ),
            thumbShape: _SliderThumb(
              size: Zeta.of(context).spacing.large / 2,
              rounded: context.rounded,
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
            min: widget.min,
            max: widget.max,
          ),
        ),
      ),
    );
  }

  Color get _activeColor {
    final colors = Zeta.of(context).colors;
    if (widget.onChange == null) {
      return colors.surface.disabled;
    }
    return _selected ? colors.main.primary : colors.surface.defaultInverse;
  }
}

/// Custom slider thumb component
@Deprecated('Deprecated in 0.14.1')
typedef SliderThumb = _SliderThumb;

/// Custom slider thumb component
class _SliderThumb extends SliderComponentShape {
  /// Constructor for [_SliderThumb]
  _SliderThumb({required this.size, required this.rounded, required this.color});

  /// Radius or width/height for [_SliderThumb] depending on shape
  final double size;

  /// If [_SliderThumb] is circular or a square
  final bool rounded;

  /// Color of [_SliderThumb]
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
