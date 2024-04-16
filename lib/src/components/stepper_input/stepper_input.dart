import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

class ZetaStepperInput extends StatefulWidget {
  const ZetaStepperInput({
    this.rounded = true,
    this.disabled = false,
    this.size = ZetaWidgetSize.medium,
    this.min,
    this.max,
    this.onChange,
    super.key,
  });

  final bool rounded;

  final bool disabled;

  final ZetaWidgetSize size;

  final int? min;

  final int? max;

  final ValueChanged<int>? onChange;

  @override
  State<ZetaStepperInput> createState() => _ZetaStepperInputState();
}

class _ZetaStepperInputState extends State<ZetaStepperInput> {
  final TextEditingController _controller = TextEditingController();
  int _value = 0;

  @override
  void initState() {
    super.initState();

    _controller
      ..text = _value.toString()
      ..addListener(() {
        final val = int.tryParse(_controller.text);
        if (val != null) {
          setState(() {
            _value = val;
          });
        }
      });
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
        color: !widget.disabled ? colors.borderSubtle : colors.borderDisabled,
      ),
      borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
    );
  }

  double get _height {
    if (widget.size != ZetaWidgetSize.large) {
      return ZetaSpacing.x10;
    } else {
      return ZetaSpacing.x12;
    }
  }

  void _onChange(int value) {
    // TODO make it work with min and max
    if (!(widget.max != null && value > widget.max! || widget.min != null && value < widget.min!)) {
      setState(() {
        _value = value;
      });
      _controller.text = value.toString();
      widget.onChange?.call(value);
    }
  }

  ZetaIconButton _getButton({bool increase = false}) {
    return ZetaIconButton(
      icon: increase
          ? widget.rounded
              ? ZetaIcons.add_round
              : ZetaIcons.add_sharp
          : widget.rounded
              ? ZetaIcons.remove_round
              : ZetaIcons.remove_sharp,
      type: ZetaButtonType.outlineSubtle,
      size: widget.size,
      borderType: widget.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
      onPressed: !widget.disabled
          ? () => _onChange(
                _value + (increase ? 1 : -1),
              )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _getButton(),
        SizedBox(
          width: ZetaSpacing.xl,
          child: TextFormField(
            keyboardType: TextInputType.number,
            enabled: !widget.disabled,
            controller: _controller,
            textAlign: TextAlign.center,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: widget.disabled ? colors.textDisabled : null,
                ),
            onTapOutside: (_) {
              if (_controller.text.isEmpty) {
                _controller.text = _value.toString();
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.disabled ? colors.surfaceDisabled : null,
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
      ].divide(const SizedBox(width: ZetaSpacing.x2)).toList(),
    );
  }
}
