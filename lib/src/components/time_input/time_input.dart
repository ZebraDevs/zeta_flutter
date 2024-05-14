import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../zeta_flutter.dart';
import '../../assets/icons.dart';

class ZetaTimeInput extends StatefulWidget {
  const ZetaTimeInput({
    super.key,
    this.rounded = true,
    this.use12Hr = false,
    this.disabled = false,
    this.initialValue,
    this.onChange,
    this.label,
    this.hintText,
    this.errorText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.validator,
    this.size = ZetaWidgetSize.medium,
  });

  final bool rounded;
  final bool use12Hr;
  final ValueChanged<TimeOfDay?>? onChange;
  final TimeOfDay? initialValue;
  final bool disabled;
  final String? label;
  final String? hintText;
  final String? errorText;
  final ZetaWidgetSize size;
  final AutovalidateMode autovalidateMode;
  final bool Function(TimeOfDay value)? validator;

  @override
  State<ZetaTimeInput> createState() => _ZetaTimeInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('use12Hr', use12Hr))
      ..add(ObjectFlagProperty<ValueChanged<TimeOfDay?>?>.has('onChange', onChange))
      ..add(DiagnosticsProperty<TimeOfDay?>('initialValue', initialValue))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(EnumProperty<AutovalidateMode>('autovalidateMode', autovalidateMode))
      ..add(ObjectFlagProperty<bool Function(TimeOfDay value)?>.has('validator', validator));
  }
}

class _ZetaTimeInputState extends State<ZetaTimeInput> {
  ZetaColors get _colors => Zeta.of(context).colors;

  final GlobalKey<FormFieldState<TimeOfDay?>> _formKey = GlobalKey();

  final TextEditingController _hrsController = TextEditingController();
  final TextEditingController _minsController = TextEditingController();

  final _hrsFocusNode = FocusNode();
  final _minsFocusNode = FocusNode();

  int get _hrsLimit => widget.use12Hr ? 11 : 23;
  final int _minsLimit = 59;

  int? get _hrsValue => int.tryParse(_hrsController.text);
  int? get _minsValue => int.tryParse(_minsController.text);

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

  Color get _textColor {
    if (widget.disabled) {
      return _colors.textDisabled;
    }
    return _colors.textSubtle;
  }

  TextStyle get _textStyle {
    TextStyle style = ZetaTextStyles.bodyMedium;
    if (widget.size == ZetaWidgetSize.small) {
      style = ZetaTextStyles.bodySmall;
    }
    return style.copyWith(
      color: _textColor,
    );
  }

  double get _iconSize {
    switch (widget.size) {
      case ZetaWidgetSize.large:
        return 24;
      case ZetaWidgetSize.medium:
        return 20;
      case ZetaWidgetSize.small:
        return 16;
    }
  }

  @override
  void initState() {
    _value = widget.initialValue;
    if (widget.initialValue != null) {
      _hrsController.text = widget.initialValue!.hour.toString();
      _minsController.text = widget.initialValue!.minute.toString();

      _padValues();
    }

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

  void _onFocus({
    required TextEditingController controller,
    required bool hasFocus,
  }) {
    if (!hasFocus) _padValue(controller);
    setState(() {
      _typing = hasFocus;
    });
  }

  void _padValues() {
    _padValue(_hrsController);
    _padValue(_minsController);
  }

  void _padValue(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      controller.text = controller.text.padLeft(2, '0');
    }
  }

  void _onValueChanged(TimeOfDay? value) {
    _formKey.currentState?.didChange(value);
    widget.onChange?.call(_value);
  }

  void _onInputChanged() {
    if (_hrsValue != null && _minsValue != null) {
      _value = TimeOfDay(hour: _hrsValue!, minute: _minsValue!);

      _onValueChanged(_value);
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
      final hrVal = widget.use12Hr && result.hour > _hrsLimit ? result.hour - _hrsLimit + 1 : result.hour;
      _hrsController.text = hrVal.toString();
      _minsController.text = result.minute.toString();

      setState(() {
        _value = result;
      });
      _padValues();
      _onValueChanged(result);
    }
  }

  void _clear() {
    setState(() {
      _hrsController.text = '';
      _minsController.text = '';
      _value = null;
    });

    _formKey.currentState?.reset();
    widget.onChange?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return FormField<TimeOfDay>(
      autovalidateMode: widget.autovalidateMode,
      key: _formKey,
      validator: (val) {
        if (val == null || (_value != null && (_hrsValue! > _hrsLimit || _minsValue! > _minsLimit))) {
          _error = true;
          return '';
        }

        final customValidation = widget.validator?.call(val) ?? false;
        if (customValidation) {
          _error = true;
          return '';
        }

        _error = false;
        return null;
      },
      builder: (formState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: _textColor),
              ),
              const SizedBox(height: ZetaSpacing.x2),
            ],
            MouseRegion(
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
                constraints: const BoxConstraints(minWidth: ZetaSpacing.x50),
                padding: const EdgeInsets.only(
                  left: ZetaSpacing.x3,
                  right: ZetaSpacing.x0_5,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: _borderWidth,
                      blurStyle: BlurStyle.solid,
                      color: _borderColor,
                    ),
                  ],
                  color: _backgroundColor,
                  borderRadius: widget.rounded ? ZetaRadius.minimal : null,
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        _TextInput(
                          hint: 'hh', //TODO Localize
                          style: _textStyle,
                          onChange: (val) {
                            _onInputChanged();
                            if (val.length == 2) {
                              _minsFocusNode.requestFocus();
                            }
                          },
                          controller: _hrsController,
                          onSubmit: (_) {
                            _minsFocusNode.requestFocus();
                          },
                          focusNode: _hrsFocusNode,
                          disabled: widget.disabled,
                        ),
                        Text(
                          ':',
                          style: _textStyle,
                        ).paddingHorizontal(ZetaSpacing.x0_5),
                        _TextInput(
                          hint: 'mm', //TODO Localize
                          onChange: (_) => _onInputChanged(),
                          controller: _minsController,
                          style: _textStyle,
                          focusNode: _minsFocusNode,
                          disabled: widget.disabled,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (_showClearButton)
                            _IconButton(
                              icon: widget.rounded ? ZetaIcons.cancel_round : ZetaIcons.cancel_sharp,
                              onTap: _clear,
                              disabled: widget.disabled,
                              size: _iconSize,
                            ),
                          _IconButton(
                            icon: widget.rounded ? ZetaIcons.clock_outline_round : ZetaIcons.clock_outline_sharp,
                            onTap: _pickTime,
                            disabled: widget.disabled,
                            size: _iconSize,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _HintText(
              error: _error,
              disabled: widget.disabled,
              rounded: widget.rounded,
              hintText: widget.hintText,
              errorText: widget.errorText,
            ),
          ],
        );
      },
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.onChange,
    required this.hint,
    required this.focusNode,
    required this.disabled,
    required this.style,
    this.onSubmit,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String> onChange;
  final FocusNode focusNode;
  final String hint;
  final bool disabled;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: TextField(
        focusNode: focusNode,
        enabled: !disabled,
        onChanged: onChange,
        controller: controller,
        onSubmitted: (value) => onSubmit?.call(value),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(2),
        ],
        style: style,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          isDense: true,
          hintStyle: style,
          errorStyle: const TextStyle(height: 0),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController>('controller', controller))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onSubmit', onSubmit))
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onChange', onChange))
      ..add(DiagnosticsProperty<FocusNode>('focusNode', focusNode))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<TextStyle>('style', style));
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    required this.disabled,
    required this.size,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool disabled;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(size / 2),
      constraints: BoxConstraints(
        maxHeight: size * 2,
        maxWidth: size * 2,
      ),
      onPressed: disabled ? null : onTap,
      iconSize: size,
      icon: Icon(icon),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DoubleProperty('size', size));
  }
}

class _HintText extends StatelessWidget {
  const _HintText({
    required this.error,
    required this.disabled,
    required this.hintText,
    required this.errorText,
    required this.rounded,
  });
  final bool error;
  final bool disabled;
  final bool rounded;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final text = error && errorText != null ? errorText : hintText;

    Color elementColor = colors.textSubtle;

    if (disabled) {
      elementColor = colors.textDisabled;
    } else if (error && errorText != null) {
      elementColor = colors.error;
    }

    if (text == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Icon(
          error
              ? rounded
                  ? ZetaIcons.error_round
                  : ZetaIcons.error_sharp
              : rounded
                  ? ZetaIcons.info_round
                  : ZetaIcons.info_sharp,
          size: ZetaSpacing.x4,
          color: elementColor,
        ),
        const SizedBox(
          width: ZetaSpacing.x1,
        ),
        Text(
          text,
          style: ZetaTextStyles.bodyXSmall.copyWith(color: elementColor),
        ),
      ],
    ).paddingTop(ZetaSpacing.x2);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('error', error))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText));
  }
}
