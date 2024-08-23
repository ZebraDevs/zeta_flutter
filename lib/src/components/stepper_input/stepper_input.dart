import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

/// Sizes for [ZetaStepperInput]
enum ZetaStepperInputSize {
  /// Medium
  medium,

  /// Large
  large,
}

/// A stepper input, also called numeric stepper, is a common UI element that
/// allows users to input a number or value simply by clicking the plus and
/// minus buttons.
/// {@category Components}
class ZetaStepperInput extends ZetaStatefulWidget {
  /// Creates a new [ZetaStepperInput]
  const ZetaStepperInput({
    super.key,
    super.rounded,
    this.size = ZetaStepperInputSize.medium,
    int? value,
    @Deprecated('Use value instead. ' 'Deprecated in 0.15.0') int? initialValue,
    this.min,
    this.max,
    this.onChange,
    this.semanticDecrement,
    this.semanticIncrement,
  })  : value = value ?? initialValue,
        assert(
          (min == null || (initialValue ?? 0) >= min) && (max == null || (initialValue ?? 0) <= max),
          'Initial value must be inside given min and max values',
        );

  /// The size of the stepper input.
  final ZetaStepperInputSize size;

  /// The initial value of the stepper input.
  ///
  /// Must be in the bounds of [min] and [max] (if given).
  final int? value;

  /// The minimum value of the stepper input.
  final int? min;

  /// The maximum value of the stepper input.
  final int? max;

  /// Called with the value of the stepper whenever it is changed.
  ///
  /// {@macro zeta-widget-change-disable}
  final ValueChanged<int>? onChange;

  /// Value used for the semantic label of the decrement button.
  ///
  /// If null, '-' will be used.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticDecrement;

  /// Value used for the semantic label of the increment button.
  ///
  /// If null, '+' will be used.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticIncrement;

  @override
  State<ZetaStepperInput> createState() => ZetaStepperInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaStepperInputSize>('size', size))
      ..add(IntProperty('value', value))
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max))
      ..add(ObjectFlagProperty<ValueChanged<int>?>.has('onChange', onChange))
      ..add(StringProperty('semanticDecrement', semanticDecrement))
      ..add(StringProperty('semanticIncrement', semanticIncrement));
  }
}

/// Internal state for [ZetaStepperInput].
///
/// Not to be used directly.
@visibleForTesting
class ZetaStepperInputState extends State<ZetaStepperInput> {
  final TextEditingController _controller = TextEditingController();

  /// Current value of the stepper input.
  int value = 0;

  /// Shortcut to check if the stepper input is disabled.
  bool get disabled => widget.onChange == null;

  @override
  void didUpdateWidget(covariant ZetaStepperInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      value = widget.value!;
      _controller.text = value.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      value = widget.value!;
    }
    _controller.text = value.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  InputBorder get _border {
    final colors = Zeta.of(context).colors;

    return OutlineInputBorder(
      borderSide: BorderSide(
        color: !disabled ? colors.borderSubtle : colors.borderDisabled,
      ),
      borderRadius: context.rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
    );
  }

  double get _height {
    if (widget.size != ZetaStepperInputSize.large) {
      return ZetaSpacing.xl_6;
    } else {
      return ZetaSpacing.xl_8;
    }
  }

  void _onTextChange(String value) {
    int? val = int.tryParse(value);
    if (val != null) {
      if (widget.max != null && val > widget.max!) {
        val = widget.max;
      }
      if (widget.min != null && val! < widget.min!) {
        val = widget.min;
      }
      _onChange(val!);
    }
  }

  void _onChange(int newValue) {
    if (!(widget.max != null && newValue > widget.max! || widget.min != null && newValue < widget.min!)) {
      setState(() {
        value = newValue;
      });
      _controller.text = value.toString();
      widget.onChange?.call(value);
    }
  }

  ZetaIconButton _getButton({bool increase = false}) {
    return ZetaIconButton(
      semanticLabel: increase ? (widget.semanticIncrement ?? '+') : (widget.semanticDecrement ?? '-'),
      icon: increase ? ZetaIcons.add : ZetaIcons.remove,
      type: ZetaButtonType.outlineSubtle,
      size: widget.size == ZetaStepperInputSize.medium ? ZetaWidgetSize.medium : ZetaWidgetSize.large,
      onPressed: !disabled && (increase ? value != widget.max : value != widget.min)
          ? () => _onChange(value + (increase ? 1 : -1))
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final bool rounded = context.rounded;
    return ZetaRoundedScope(
      rounded: rounded,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getButton(),
          SizedBox(
            width: ZetaSpacing.xl_9,
            child: TextFormField(
              keyboardType: TextInputType.number,
              enabled: !disabled,
              controller: _controller,
              onChanged: _onTextChange,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: disabled ? colors.textDisabled : null,
                  ),
              onTapOutside: (_) {
                if (_controller.text.isEmpty) {
                  _controller.text = value.toString();
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: disabled ? colors.surfaceDisabled : null,
                contentPadding: EdgeInsets.zero,
                constraints: BoxConstraints(maxHeight: _height),
                border: _border,
                focusedBorder: _border,
                enabledBorder: _border,
                disabledBorder: _border,
              ),
            ),
          ),
          _getButton(increase: true),
        ].divide(const SizedBox(width: ZetaSpacing.small)).toList(),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('value', value))
      ..add(DiagnosticsProperty<bool>('disabled', disabled));
  }
}
