import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../zeta_flutter.dart';
import '../../assets/icons.dart';

class ZetaTimeInput extends StatefulWidget {
  final bool rounded;
  final bool use12Hr;
  final ValueChanged<TimeOfDay?>? onChange;
  final TimeOfDay? initialValue;
  final bool disabled;

  const ZetaTimeInput({
    super.key,
    this.rounded = true,
    this.use12Hr = false,
    this.disabled = false,
    this.initialValue,
    this.onChange,
  });

  @override
  State<ZetaTimeInput> createState() => _ZetaTimeInputState();
}

class _ZetaTimeInputState extends State<ZetaTimeInput> {
  ZetaColors get _colors => Zeta.of(context).colors;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _hrsController = TextEditingController();
  final TextEditingController _minsController = TextEditingController();

  final _hrsFocusNode = FocusNode();
  final _minsFocusNode = FocusNode();

  int get _hrsLimit => widget.use12Hr ? 11 : 23;
  final int _minsLimit = 59;

  TimeOfDay? _value;

  bool _typing = false;
  bool _hovered = false;
  bool _error = false;

  bool get _showClearButton => _hrsController.text.isNotEmpty || _minsController.text.isNotEmpty;

  Color get _borderColor {
    if (widget.disabled) {
      return _colors.borderDisabled;
    }
    if (_error) {
      return _colors.error;
    }
    if (_typing) {
      return _colors.primary.shade50; // TODO: change to colors.borderPrimary when added
    }
    if (_hovered) {
      return _colors.borderSelected;
    }
    return _colors.borderSubtle;
  }

  Color get _backgroundColor {
    if (widget.disabled) {
      return _colors.surfaceDisabled;
    }
    if (_error) {
      return _colors.error.shade10;
    }
    return _colors.surfacePrimary;
  }

  double get _borderWidth {
    if (_error || _typing) {
      return 2;
    }
    return 1;
  }

  @override
  void initState() {
    _value = widget.initialValue;
    _hrsFocusNode.addListener(
      () => _onFocus(
        controller: _hrsController,
        hasFocus: _hrsFocusNode.hasFocus,
      ),
    );
    _minsFocusNode.addListener(
      () => _onFocus(
        controller: _minsController,
        hasFocus: _minsFocusNode.hasFocus,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _hrsController.dispose();
    _minsController.dispose();
    _hrsFocusNode.dispose();
    _minsFocusNode.dispose();

    super.dispose();
  }

  void _padValue(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      controller.text = controller.text.padLeft(2, '0');
    }
  }

  void _onInputChanged() {
    setState(() {
      _error = !(_formKey.currentState?.validate() ?? true);
    });
    final hrsValue = int.tryParse(_hrsController.text);
    final minsValue = int.tryParse(_minsController.text);
    if (!_error && hrsValue != null && minsValue != null) {
      _value = TimeOfDay(hour: hrsValue, minute: minsValue);

      widget.onChange?.call(_value);
    }
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: !widget.use12Hr),
          child: child!,
        );
      },
    );
    if (result != null) {
      _formKey.currentState?.validate();

      final hrVal = widget.use12Hr && result.hour > 11 ? result.hour - 12 : result.hour;
      _hrsController.text = hrVal.toString();
      _minsController.text = result.minute.toString();
      _padValue(_hrsController);
      _padValue(_minsController);
      setState(() {
        _value = result;
      });
      widget.onChange?.call(result);
    }
  }

  void _onFocus({
    required TextEditingController controller,
    required bool hasFocus,
  }) {
    if (!hasFocus) _padValue(controller);
    setState(() {
      _typing = hasFocus;
    });
  }

  void _clear() {
    setState(() {
      _hrsController.text = '';
      _minsController.text = '';
    });

    widget.onChange?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: !widget.disabled
          ? (_) => setState(() {
                _hovered = true;
              })
          : null,
      onExit: !widget.disabled
          ? (_) => setState(() {
                _hovered = false;
              })
          : null,
      child: Container(
        constraints: BoxConstraints(minWidth: ZetaSpacing.x50),
        padding: const EdgeInsets.only(
          left: ZetaSpacing.x3,
          top: ZetaSpacing.x1,
          bottom: ZetaSpacing.x1,
          right: ZetaSpacing.x0_5,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              spreadRadius: _borderWidth,
              blurStyle: BlurStyle.solid,
              color: _borderColor,
            )
          ],
          color: _backgroundColor,
          borderRadius: widget.rounded ? ZetaRadius.minimal : null,
        ),
        child: Row(
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  _TextInput(
                    hint: 'hh',
                    onChange: _onInputChanged,
                    controller: _hrsController,
                    onSubmit: (val) {
                      _minsFocusNode.requestFocus();
                    },
                    limit: _hrsLimit,
                    focusNode: _hrsFocusNode,
                    disabled: widget.disabled,
                  ),
                  Text(
                    ':',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: !widget.disabled ? _colors.textSubtle : _colors.textDisabled,
                        ),
                  ).paddingHorizontal(ZetaSpacing.x0_5),
                  _TextInput(
                    hint: 'mm',
                    onChange: _onInputChanged,
                    controller: _minsController,
                    focusNode: _minsFocusNode,
                    limit: _minsLimit,
                    disabled: widget.disabled,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_showClearButton)
                    IconButton(
                      onPressed: widget.disabled ? null : _clear,
                      icon: Icon(widget.rounded ? ZetaIcons.cancel_round : ZetaIcons.cancel_sharp),
                    ),
                  IconButton(
                    onPressed: widget.disabled ? null : _pickTime,
                    icon: Icon(
                      widget.rounded ? ZetaIcons.clock_outline_round : ZetaIcons.clock_outline_sharp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmit;
  final VoidCallback onChange;
  final FocusNode focusNode;
  final String hint;
  final int limit;
  final bool disabled;

  const _TextInput({
    required this.controller,
    required this.onChange,
    required this.hint,
    required this.focusNode,
    required this.limit,
    required this.disabled,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return SizedBox(
      width: 32,
      child: TextFormField(
        focusNode: focusNode,
        enabled: !disabled,
        onChanged: (_) => onChange(),
        controller: controller,
        validator: (val) {
          if (val == null || val.isEmpty) return '';
          final value = int.tryParse(val);
          if (value != null && value > limit) {
            return '';
          }
          return null;
        },
        onSaved: (value) {
          if (value != null) {
            onSubmit?.call(value);
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: !disabled ? colors.textSubtle : colors.textDisabled,
              ),
          errorStyle: const TextStyle(height: 0),
        ),
      ),
    );
  }
}
