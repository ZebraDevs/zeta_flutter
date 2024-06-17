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

/// A stepper input, also called numeric stepper, is a common UI element that allows users to input a number or value simply by clicking the plus and minus buttons.
class ZetaStepperInput extends ZetaStatefulWidget {
  /// Creates a new [ZetaStepperInput]
  const ZetaStepperInput({
    super.key,
    super.rounded,
    this.size = ZetaStepperInputSize.medium,
    this.initialValue,
    this.min,
    this.max,
    this.onChange,
  }) : assert(
          (min == null || (initialValue ?? 0) >= min) && (max == null || (initialValue ?? 0) <= max),
          'Initial value must be inside given min and max values',
        );

  /// The size of the stepper input.
  final ZetaStepperInputSize size;

  /// The initial value of the stepper input.
  ///
  /// Must be in the bounds of [min] and [max] (if given).
  final int? initialValue;

  /// The minimum value of the stepper input.
  final int? min;

  /// The maximum value of the stepper input.
  final int? max;

  /// Called with the value of the stepper whenever it is changed.
  ///
  /// {@macro on-change-disable}
  final ValueChanged<int>? onChange;

  @override
  State<ZetaStepperInput> createState() => _ZetaStepperInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaStepperInputSize>('size', size))
      ..add(IntProperty('initialValue', initialValue))
      ..add(IntProperty('min', min))
      ..add(IntProperty('max', max))
      ..add(ObjectFlagProperty<ValueChanged<int>?>.has('onChange', onChange));
  }
}

class _ZetaStepperInputState extends State<ZetaStepperInput> {
  final TextEditingController _controller = TextEditingController();
  int _value = 0;
  bool get _disabled => widget.onChange == null;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _value = widget.initialValue!;
    }
    _controller.text = _value.toString();
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
        color: !_disabled ? colors.borderSubtle : colors.borderDisabled,
      ),
      borderRadius: context.rounded ? ZetaRadius.minimal : ZetaRadius.none,
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

  void _onChange(int value) {
    if (!(widget.max != null && value > widget.max! || widget.min != null && value < widget.min!)) {
      setState(() {
        _value = value;
      });
      _controller.text = value.toString();
      widget.onChange?.call(value);
    }
  }

  ZetaIconButton _getButton({bool increase = false}) {
    final bool rounded = context.rounded;

    return ZetaIconButton(
      icon: increase
          ? rounded
              ? ZetaIcons.add_round
              : ZetaIcons.add_sharp
          : rounded
              ? ZetaIcons.remove_round
              : ZetaIcons.remove_sharp,
      type: ZetaButtonType.outlineSubtle,
      size: widget.size == ZetaStepperInputSize.medium ? ZetaWidgetSize.medium : ZetaWidgetSize.large,
      onPressed: !_disabled && (increase ? _value != widget.max : _value != widget.min)
          ? () => _onChange(
                _value + (increase ? 1 : -1),
              )
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
              enabled: !_disabled,
              controller: _controller,
              onChanged: _onTextChange,
              textAlign: TextAlign.center,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _disabled ? colors.textDisabled : null,
                  ),
              onTapOutside: (_) {
                if (_controller.text.isEmpty) {
                  _controller.text = _value.toString();
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: _disabled ? colors.surfaceDisabled : null,
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
}
