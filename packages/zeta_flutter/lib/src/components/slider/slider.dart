import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

/// Sliders allow users to make selections from a range of values.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-11860&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/slider/zetaslider/slider
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
    this.max = 100.0,
    this.inputField = false,
  });

  /// Double value to represent slider percentage.
  ///
  /// Default [min] / [max] are 0.0 and 100.0 respectively; this value should be between [min] and [max].
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

  /// Whether to show an input field to the right of the slider.
  /// The input field will change the slider value when updated.
  ///
  /// This also adds the min and max values below the slider.
  /// This will default to 0 - 100 if min and max are not changed.
  final bool inputField;

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
      ..add(DoubleProperty('min', min))
      ..add(DiagnosticsProperty<bool>('inputField', inputField));
  }
}

class _ZetaSliderState extends State<ZetaSlider> {
  bool _selected = false;
  final _inputController = TextEditingController();
  Debounce? _debounce;

  @override
  void initState() {
    super.initState();
    _inputController.text = widget.value.toString();
    _inputController.addListener(_updateTextField);
  }

  //Called when slider is updated, changes text field value
  void _updateTextFieldFromSlider(double sliderValue) {
    _inputController.text = sliderValue.toInt().toString();
  }

  // Called when text field is updated, changes slider value
  void _updateTextField() {
    _debounce?.cancel();
    _debounce = Debounce(
      () {
        final number = int.tryParse(_inputController.text);
        if (number != null) {
          final num newValue;
          if (widget.divisions != null) {
            final divisionSize = (widget.max - widget.min) / widget.divisions!;
            final snappedValue = ((number - widget.min) / divisionSize).round() * divisionSize + widget.min;
            newValue = snappedValue.round().clamp(widget.min, widget.max);
            if (number != newValue) {
              _inputController.text = newValue.toString();
            }
          } else {
            newValue = number.clamp(widget.min, widget.max).toInt();
            if (number != newValue) {
              _inputController.text = newValue.toInt().toString();
            }
          }
          widget.onChange?.call(newValue.toDouble());
        }
      },
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;

    final activeColor = widget.onChange == null
        ? colors.mainDisabled
        : _selected
            ? colors.mainPrimary
            : colors.mainDefault;

    return MergeSemantics(
      child: Semantics(
        label: widget.semanticLabel,
        child: SliderTheme(
          data: SliderThemeData(
            /// Active Track
            activeTrackColor: activeColor,
            disabledActiveTrackColor: colors.mainDisabled,

            /// Inactive Track
            inactiveTrackColor: colors.mainLight,

            /// Ticks
            activeTickMarkColor: colors.mainInverse,
            inactiveTickMarkColor: colors.mainInverse,
            disabledActiveTickMarkColor: colors.mainInverse,
            disabledInactiveTickMarkColor: colors.mainInverse,

            /// Thumb
            thumbColor: colors.mainDefault,
            disabledThumbColor: colors.mainDisabled,
            overlayShape: _SliderThumb(
              size: zeta.spacing.xl / 2,
              rounded: context.rounded,
              color: activeColor,
            ),
            thumbShape: _SliderThumb(
              size: zeta.spacing.large / 2,
              rounded: context.rounded,
              color: activeColor,
            ),
            trackShape: context.rounded ? _RoundedRectangleTrackShape() : const RectangularSliderTrackShape(),
          ),
          child: _generateSlider(),
        ),
      ),
    );
  }

  Widget _generateCoreSlider() {
    return Slider(
      value: widget.value,
      onChanged: widget.inputField
          ? widget.onChange != null
              ? (value) {
                  // Update text field when slider changes
                  _updateTextFieldFromSlider(value);
                  widget.onChange?.call(value);
                }
              : null
          : widget.onChange,
      divisions: widget.divisions,
      onChangeStart: (_) => setState(() => _selected = true),
      onChangeEnd: (_) => setState(() => _selected = false),
      min: widget.min,
      max: widget.max,
    );
  }

  //private function to generate slider depending on input field boolean
  Widget _generateSlider() {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;

    // If input field is true, return slider with input field.
    if (widget.inputField) {
      return Row(
        spacing: zeta.spacing.large,
        children: [
          Expanded(
            child: Column(
              spacing: zeta.spacing.small,
              children: [
                //Slider
                _generateCoreSlider(),
                //Numbers
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.min.toInt().toString(),
                      style: zeta.textStyles.bodyMedium.apply(
                        color: widget.onChange == null ? colors.mainDisabled : colors.mainDefault,
                      ),
                    ),
                    Text(
                      widget.max.toInt().toString(),
                      style: zeta.textStyles.bodyMedium.apply(
                        color: widget.onChange == null ? colors.mainDisabled : colors.mainDefault,
                      ),
                    ),
                  ],
                ).paddingHorizontal(zeta.spacing.minimum),
              ],
            ),
          ),
          //Text Input
          SizedBox(
            width: zeta.spacing.xl_8 + zeta.spacing.small,
            child: ZetaTextInput(
              keyboardType: TextInputType.number,
              disabled: widget.onChange == null,
              size: ZetaWidgetSize.large,
              textAlign: TextAlign.center,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              controller: _inputController,
            ),
          ),
        ],
      );
    }

    // If input field is false, return just the slider.
    return _generateCoreSlider();
  }
}

/// Custom slider thumb component
class _SliderThumb extends SliderComponentShape {
  /// Constructor for [_SliderThumb]
  const _SliderThumb({required this.size, required this.rounded, required this.color});

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
        : canvas.drawRect(Rect.fromCenter(center: center, width: size * 2, height: size * 2), paint);
  }
}

class _RoundedRectangleTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    Offset? secondaryOffset,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    super.paint(
      context,
      offset,
      parentBox: parentBox,
      secondaryOffset: secondaryOffset,
      sliderTheme: sliderTheme,
      enableAnimation: enableAnimation,
      textDirection: textDirection,
      thumbCenter: thumbCenter,
      isDiscrete: isDiscrete,
      isEnabled: isEnabled,
      additionalActiveTrackHeight: additionalActiveTrackHeight,
    );
  }
}
