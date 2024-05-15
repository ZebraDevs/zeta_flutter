import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../zeta_flutter.dart';

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

  final _timeFormat = 'hh:mm';
  late final MaskTextInputFormatter _timeFormatter;

  final _controller = TextEditingController();
  final GlobalKey<FormFieldState<String>> _key = GlobalKey();

  bool _hovered = false;
  bool _error = false;

  bool get _showClearButton => _controller.text.isNotEmpty;

  Color get _backgroundColor {
    if (widget.disabled) {
      return _colors.surfaceDisabled;
    }
    if (_error) {
      return _colors.error.shade10;
    }
    return _colors.surfacePrimary;
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

  int get _hrsLimit => widget.use12Hr ? 11 : 23;
  final int _minsLimit = 59;

  TimeOfDay? get _value {
    final splitValue = _timeFormatter.getMaskedText().trim().split(':');
    if (splitValue.length > 1) {
      final hrsValue = int.tryParse(splitValue[0]);
      final minsValue = int.tryParse(splitValue[1]);
      if (hrsValue != null && minsValue != null) {
        return TimeOfDay(hour: hrsValue, minute: minsValue);
      }
    }
    return null;
  }

  OutlineInputBorder get _baseBorder => OutlineInputBorder(
        borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: _hovered ? _colors.borderSelected : _colors.borderSubtle),
      );

  OutlineInputBorder get _focusedBorder => _baseBorder.copyWith(
        borderSide: BorderSide(color: _colors.primary.shade50, width: 2),
      ); // TODO: change to colors.borderPrimary when added

  OutlineInputBorder get _errorBorder => _baseBorder.copyWith(
        borderSide: BorderSide(color: _colors.error, width: 2),
      );

  OutlineInputBorder get _disabledBorder => _baseBorder.copyWith(
        borderSide: BorderSide(color: _colors.borderDisabled, width: 2),
      );

  @override
  void initState() {
    _timeFormatter = MaskTextInputFormatter(
      mask: _timeFormat.replaceAll(RegExp('[a-z]'), '#'),
      filter: {'#': RegExp('[0-9]')},
      type: MaskAutoCompletionType.eager,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void _onChange() {
    if (_timeFormatter.getUnmaskedText().length > 3 && (_key.currentState?.validate() ?? false)) {
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
      final hrText = result.hour.toString().padLeft(2, '0');
      final minText = result.minute.toString().padLeft(2, '0');
      _controller.text = _timeFormatter.maskText(hrText + minText);
    }
  }

  void _clear() {
    _timeFormatter.clear();
    _key.currentState?.reset();
    _error = false;
    _controller.clear();
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
          child: TextFormField(
            enabled: !widget.disabled,
            key: _key,
            controller: _controller,
            inputFormatters: [
              _timeFormatter,
            ],
            validator: (_) {
              if (_value == null || _value!.hour > _hrsLimit || _value!.minute > _minsLimit) {
                setState(() {
                  _error = true;
                });
                return '';
              }
              setState(() {
                _error = false;
              });
              return null;
            },
            textAlignVertical: TextAlignVertical.center,
            onChanged: (_) => _onChange(),
            style: _textStyle,
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              suffixIcon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
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
              focusColor: _backgroundColor,
              hoverColor: _backgroundColor,
              fillColor: _backgroundColor,
              enabledBorder: _baseBorder,
              disabledBorder: _disabledBorder,
              focusedBorder: _focusedBorder,
              focusedErrorBorder: _errorBorder,
              errorBorder: _errorBorder,
              hintText: _timeFormat,
              hintStyle: _textStyle,
              errorStyle: const TextStyle(height: 0),
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
