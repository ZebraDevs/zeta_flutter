import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

/// Used for selecting values in a numerical range.
///
/// The [ZetaRangeSelector] is a customizable range selector widget that
/// allows users to select a range of values within a specified minimum
/// and maximum range. It provides a visual representation of the selected
/// range and allows for precise adjustments through both dragging and direct input.
class ZetaRangeSelector extends ZetaStatefulWidget {
  /// Creates a new [ZetaRangeSelector]
  ZetaRangeSelector({
    super.key,
    super.rounded,
    required this.initialValues,
    this.min = 0.0,
    this.max = 100,
    this.label,
    this.onChange,
    this.divisions,
    this.semanticLabel,
    this.showValues = true,
  }) : assert(
          min <= initialValues.start && initialValues.start <= initialValues.end && initialValues.end <= max,
          'The start value must be less than or equal to the end value, and both must be within the range of min and max.',
        );

  /// The initial values of the range selector.
  final RangeValues initialValues;

  /// The minimum value of the range selector.
  /// Defaults to 0.
  final double min;

  /// The maximum value of the range selector.
  /// Defaults to 100.
  final double max;

  /// The label of the range selector.
  final String? label;

  /// Called with the values of the range selector whenever it is changed.
  final ValueChanged<RangeValues>? onChange;

  /// The number of divisions for the range selector.
  final int? divisions;

  /// Value passed to the wrapping [Semantics] widget.
  final String? semanticLabel;

  /// Whether to show the values of the range selector.
  final bool showValues;

  @override
  State<ZetaRangeSelector> createState() => _ZetaRangeSelectorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('min', min))
      ..add(DoubleProperty('max', max))
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<ValueChanged<RangeValues>?>.has('onChange', onChange))
      ..add(IntProperty('divisions', divisions))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty<bool>('showValues', showValues))
      ..add(DiagnosticsProperty<RangeValues>('initialValues', initialValues));
  }
}

class _ZetaRangeSelectorState extends State<ZetaRangeSelector> {
  bool _selected = false;

  late RangeValues _values;

  final TextEditingController _lowerController = TextEditingController();
  final TextEditingController _upperController = TextEditingController();

  bool get disabled => widget.onChange == null;

  @override
  void initState() {
    super.initState();
    _values = widget.initialValues;
    _lowerController.text = widget.initialValues.start.round().toString();
    _upperController.text = widget.initialValues.end.round().toString();
  }

  @override
  void didUpdateWidget(ZetaRangeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValues != oldWidget.initialValues) {
      _values = widget.initialValues;
      _lowerController.text = widget.initialValues.start.toString();
      _upperController.text = widget.initialValues.end.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _lowerController.dispose();
    _upperController.dispose();
  }

  Color get _activeColor {
    final colors = Zeta.of(context).colors;
    if (widget.onChange == null) {
      return colors.mainDisabled;
    }
    return _selected ? colors.mainPrimary : colors.mainDefault;
  }

  void _onSubmit(TextEditingController controller, {bool lower = true}) {
    if (controller.text.isNotEmpty) {
      double? val = double.tryParse(controller.text);
      if (val != null) {
        if (val < widget.min) {
          val = widget.min;
        }
        if (lower ? val >= _values.end : val <= _values.start) {
          val = lower ? _values.end : _values.start;
        }
        if (widget.onChange != null) {
          widget.onChange?.call(RangeValues(lower ? val : _values.start, lower ? _values.end : val));
          setState(() {
            _values = RangeValues(lower ? val! : _values.start, lower ? _values.end : val!);
            controller.text = val!.round().toString();
          });
        }
      }
    }
  }

  void _valueFieldOnChanged(String value, TextEditingController controller) {
    double? val = double.tryParse(value);
    if (val != null) {
      if (val > widget.max) {
        val = widget.max;
      }
      setState(() {
        controller.text = val!.round().toString();
      });
    }
  }

  void _rangeSliderOnChanged(RangeValues value) {
    if (widget.onChange != null) {
      widget.onChange?.call(RangeValues(value.start, value.end));
      setState(() {
        _values = RangeValues(value.start, value.end);
        _lowerController.text = value.start.round().toString();
        _upperController.text = value.end.round().toString();
      });
    }
  }

  void _setSelected(bool selected) {
    setState(() {
      _selected = selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final spacing = Zeta.of(context).spacing;
    final bool rounded = context.rounded;

    return ZetaRoundedScope(
      rounded: rounded,
      child: Semantics(
        label: widget.semanticLabel,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Text(
                widget.label!,
                style: Zeta.of(context).textStyles.bodySmall.copyWith(
                      color: disabled ? colors.mainDisabled : colors.mainDefault,
                    ),
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showValues)
                  _ValueField(
                    controller: _lowerController,
                    onEditingComplete: () => _onSubmit(_lowerController),
                    onTapOutside: (event) => _onSubmit(_lowerController),
                    onChanged: (value) => _valueFieldOnChanged(value, _lowerController),
                    disabled: disabled,
                    rounded: rounded,
                    context: context,
                  ),
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      /// Track
                      activeTrackColor: _activeColor,
                      inactiveTrackColor: colors.surfaceDisabled,
                      rangeTrackShape: rounded
                          ? const RoundedRectRangeSliderTrackShape() as RangeSliderTrackShape
                          : const RectangularRangeSliderTrackShape() as RangeSliderTrackShape,

                      /// Ticks
                      activeTickMarkColor: colors.surfaceDefault,
                      inactiveTickMarkColor: colors.surfaceDefault,
                      rangeTickMarkShape: const RoundRangeSliderTickMarkShape(tickMarkRadius: 1),

                      /// Thumbs
                      overlayShape: _DrawThumbOverlay(
                        size: spacing.xl / 2,
                        rounded: rounded,
                        color: _activeColor,
                      ),
                      rangeThumbShape: _DrawThumb(
                        size: spacing.large / 2,
                        rounded: rounded,
                        color: _activeColor,
                      ),
                    ),
                    child: RangeSlider(
                      values: _values,
                      onChanged: _rangeSliderOnChanged,
                      divisions: widget.divisions,
                      onChangeStart: (_) => _setSelected(true),
                      onChangeEnd: (_) => _setSelected(false),
                      min: widget.min,
                      max: widget.max,
                      mouseCursor: WidgetStatePropertyAll(
                        disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
                      ),
                      semanticFormatterCallback: (value) {
                        return '${value.round()}';
                      },
                    ),
                  ),
                ),
                if (widget.showValues)
                  _ValueField(
                    controller: _upperController,
                    onEditingComplete: () => _onSubmit(_upperController, lower: false),
                    onTapOutside: (event) => _onSubmit(_upperController, lower: false),
                    onChanged: (value) => _valueFieldOnChanged(value, _upperController),
                    disabled: disabled,
                    rounded: rounded,
                    context: context,
                  ),
              ].gap(spacing.xl_4),
            ),
          ].gap(spacing.small),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('disabled', disabled));
  }
}

class _ValueField extends StatelessWidget {
  const _ValueField({
    required this.controller,
    required this.onEditingComplete,
    required this.onChanged,
    required this.onTapOutside,
    required this.disabled,
    required this.rounded,
    required this.context,
  });

  final TextEditingController controller;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onChanged;
  final TapRegionCallback onTapOutside;
  final bool disabled;
  final bool rounded;
  final BuildContext context;

  ZetaColors get _colors {
    return Zeta.of(context).colors;
  }

  ZetaSpacing get _spacing {
    return Zeta.of(context).spacing;
  }

  InputBorder get _border {
    final radius = Zeta.of(context).radius;

    return OutlineInputBorder(
      borderSide: BorderSide(
        color: !disabled ? _colors.borderDefault : _colors.borderDisabled,
      ),
      borderRadius: BorderRadius.all(rounded ? radius.minimal : radius.none),
    );
  }

  InputDecoration get _inputDecoration {
    return InputDecoration(
      filled: true,
      fillColor: disabled ? _colors.surfaceDisabled : null,
      contentPadding: EdgeInsets.zero,
      constraints: BoxConstraints(maxHeight: _spacing.xl_6),
      border: _border,
      focusedBorder: _border,
      enabledBorder: _border,
      disabledBorder: _border,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _spacing.xl_9 - 8,
      height: _spacing.xl_8,
      child: TextFormField(
        keyboardType: TextInputType.number,
        enabled: !disabled,
        controller: controller,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTapOutside: onTapOutside.call,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: disabled ? _colors.mainDisabled : _colors.mainSubtle,
            ),
        decoration: _inputDecoration,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController>('controller', controller))
      ..add(ObjectFlagProperty<VoidCallback>.has('onEditingComplete', onEditingComplete))
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onChanged', onChanged))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<BuildContext>('context', context))
      ..add(ObjectFlagProperty<TapRegionCallback>.has('onTapOutside', onTapOutside));
  }
}

class _DrawThumb extends RangeSliderThumbShape {
  /// Constructor for [_DrawThumb]
  const _DrawThumb({required this.size, required this.rounded, required this.color});

  /// Radius or width/height for [_DrawThumb] depending on shape
  final double size;

  /// If [_DrawThumb] is circular or a square
  final bool rounded;

  /// Color of [_DrawThumb]
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
    bool? isDiscrete,
    bool? isEnabled,
    bool? isOnTop,
    bool? isPressed,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
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

/// Custom slider thumb component
class _DrawThumbOverlay extends SliderComponentShape {
  /// Constructor for [_DrawThumbOverlay]
  const _DrawThumbOverlay({required this.size, required this.rounded, required this.color});

  /// Radius or width/height for [_DrawThumbOverlay] depending on shape
  final double size;

  /// If [_DrawThumbOverlay] is circular or a square
  final bool rounded;

  /// Color of [_DrawThumbOverlay]
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
