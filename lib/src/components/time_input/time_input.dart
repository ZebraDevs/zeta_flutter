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
  final String? label;
  final String? hintText;
  final String? errorText;
  final ZetaWidgetSize size;

  const ZetaTimeInput(
      {super.key,
      this.rounded = true,
      this.use12Hr = false,
      this.disabled = false,
      this.initialValue,
      this.onChange,
      this.label,
      this.hintText,
      this.errorText,
      this.size = ZetaWidgetSize.medium});

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

  double get _verticalPadding {
    if (widget.size == ZetaWidgetSize.large) {
      return ZetaSpacing.x1;
    }
    return 0;
  }

  TextStyle get _textStyle {
    if (widget.size == ZetaWidgetSize.small) {
      return ZetaTextStyles.bodySmall;
    }
    return ZetaTextStyles.bodyMedium;
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

  void _validate() {
    setState(() {
      _error = !(_formKey.currentState?.validate() ?? true);
    });
  }

  void _onInputChanged() {
    _validate();
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
      final hrVal = widget.use12Hr && result.hour > 11 ? result.hour - 12 : result.hour;
      _hrsController.text = hrVal.toString();
      _minsController.text = result.minute.toString();
      _padValue(_hrsController);
      _padValue(_minsController);
      setState(() {
        _value = result;
      });
      _validate();
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: widget.disabled ? _colors.textDisabled : _colors.textDefault),
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
                Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      _TextInput(
                        hint: 'hh',
                        style: _textStyle,
                        onChange: (val) {
                          _onInputChanged();
                          if (val.length == 2) {
                            _minsFocusNode.requestFocus();
                          }
                        },
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
                        style: _textStyle.copyWith(
                          color: !widget.disabled ? _colors.textSubtle : _colors.textDisabled,
                        ),
                      ).paddingHorizontal(ZetaSpacing.x0_5),
                      _TextInput(
                        hint: 'mm',
                        onChange: (_) => _onInputChanged(),
                        controller: _minsController,
                        style: _textStyle,
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
                          padding: EdgeInsets.all(_iconSize / 2),
                          constraints: BoxConstraints(
                            maxHeight: _iconSize * 2,
                            maxWidth: _iconSize * 2,
                          ),
                          onPressed: widget.disabled ? null : _clear,
                          iconSize: _iconSize,
                          icon: Icon(
                            widget.rounded ? ZetaIcons.cancel_round : ZetaIcons.cancel_sharp,
                          ),
                        ),
                      IconButton(
                        padding: EdgeInsets.all(_iconSize / 2),
                        constraints: BoxConstraints(
                          maxHeight: _iconSize * 2,
                          maxWidth: _iconSize * 2,
                        ),
                        onPressed: widget.disabled ? null : _pickTime,
                        iconSize: _iconSize,
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
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onSubmit;
  final ValueChanged<String> onChange;
  final FocusNode focusNode;
  final String hint;
  final int limit;
  final bool disabled;
  final TextStyle style;

  const _TextInput({
    required this.controller,
    required this.onChange,
    required this.hint,
    required this.focusNode,
    required this.limit,
    required this.disabled,
    required this.style,
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
        onChanged: onChange,
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
        style: style,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          isDense: true,
          hintStyle: style.copyWith(
            color: !disabled ? colors.textSubtle : colors.textDisabled,
          ),
          errorStyle: const TextStyle(height: 0),
        ),
      ),
    );
  }
}

class _HintText extends StatelessWidget {
  final bool error;
  final bool disabled;
  final bool rounded;
  final String? hintText;
  final String? errorText;

  const _HintText({
    required this.error,
    required this.disabled,
    required this.hintText,
    required this.errorText,
    required this.rounded,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final text = error ? errorText : hintText;

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
          rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp,
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
}
