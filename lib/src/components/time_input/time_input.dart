import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../zeta_flutter.dart';

const _maxHrValue = 23;
const _max12HrValue = 12;
const _maxMinsValue = 59;

/// A form field used to input time.
///
/// Can be used and validated the same way as a [TextFormField]
class ZetaTimeInput extends StatefulWidget {
  /// Creates a new [ZetaTimeInput]
  const ZetaTimeInput({
    super.key,
    this.rounded = true,
    this.use12Hr,
    this.disabled = false,
    this.initialValue,
    this.onChange,
    this.label,
    this.hint,
    this.errorText,
    this.validator,
    this.size = ZetaWidgetSize.medium,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Changes the time input to 12 hour time.
  /// Uses the device default if not set.
  final bool? use12Hr;

  /// Called when the input changes.
  /// Null is passed to this function if the current value is an invalid time.
  final ValueChanged<TimeOfDay?>? onChange;

  /// The inital value of the input.
  final TimeOfDay? initialValue;

  /// Disables the input.
  final bool disabled;

  /// The label for the input.
  final String? label;

  /// The hint displayed below the input.
  final String? hint;

  /// The error displayed below the input.
  final String? errorText;

  /// The size of the input.
  final ZetaWidgetSize size;

  /// The validator passed to the text input.
  /// Returns a string containing an error message.
  ///
  /// By default, the form field checks for null and invalid hour or minute values.
  /// If the default validation fails, [errorText] will be shown.
  /// However, if [validator] catches any of these conditions, the return value of [validator] will be shown.
  final String? Function(TimeOfDay? value)? validator;

  @override
  State<ZetaTimeInput> createState() => ZetaTimeInputState();
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
      ..add(StringProperty('hintText', hint))
      ..add(StringProperty('errorText', errorText))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(ObjectFlagProperty<String? Function(TimeOfDay value)?>.has('validator', validator));
  }
}

/// State for [ZetaTimeInput]
class ZetaTimeInputState extends State<ZetaTimeInput> {
  // TODO(mikecoomber): add AM/PM selector inline.

  ZetaColors get _colors => Zeta.of(context).colors;

  final _timeFormat = 'hh:mm'; // TODO(UX-1003): needs localizing.
  late final MaskTextInputFormatter _timeFormatter;

  bool _firstBuildComplete = false;
  bool get _use12Hr => widget.use12Hr ?? !MediaQuery.of(context).alwaysUse24HourFormat;

  final _controller = TextEditingController();
  final GlobalKey<FormFieldState<String>> _key = GlobalKey();

  bool _hovered = false;
  String? _errorText;

  /// Returns true if the input contains a valid [TimeOfDay]
  bool get isValid => _errorText != null;

  bool get _showClearButton => _controller.text.isNotEmpty;

  Color get _backgroundColor {
    if (widget.disabled) {
      return _colors.surfaceDisabled;
    }
    if (_errorText != null) {
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
      style = ZetaTextStyles.bodyXSmall;
    }
    return style.copyWith(
      color: _textColor,
    );
  }

  double get _iconSize {
    switch (widget.size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.x6;
      case ZetaWidgetSize.medium:
        return ZetaSpacing.x5;
      case ZetaWidgetSize.small:
        return ZetaSpacing.x4;
    }
  }

  int get _hrsLimit => _use12Hr ? _max12HrValue : _maxHrValue;
  final int _minsLimit = _maxMinsValue;

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
        borderSide: BorderSide(color: _colors.primary.shade50, width: ZetaSpacing.x0_5),
      ); // TODO(mikecoomber): change to colors.borderPrimary when added

  OutlineInputBorder get _errorBorder => _baseBorder.copyWith(
        borderSide: BorderSide(color: _colors.error, width: ZetaSpacing.x0_5),
      );

  @override
  void initState() {
    _timeFormatter = MaskTextInputFormatter(
      mask: _timeFormat.replaceAll(RegExp('[a-z]'), '#'),
      filter: {'#': RegExp('[0-9]')},
      type: MaskAutoCompletionType.eager,
    );

    if (widget.initialValue != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _key.currentState?.validate();
      });
    }
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
    } else {
      widget.onChange?.call(null);
    }
    setState(() {});
  }

  void _setText(TimeOfDay value) {
    final hrsValue = _use12Hr && value.hour > _hrsLimit ? value.hour - _hrsLimit : value.hour;

    final hrText = hrsValue.toString().padLeft(2, '0');
    final minText = value.minute.toString().padLeft(2, '0');

    _controller.text = _timeFormatter.maskText(hrText + minText);
    _timeFormatter.formatEditUpdate(TextEditingValue.empty, _controller.value);
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: _value ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: !_use12Hr),
          child: child!,
        );
      },
    );
    if (result != null) {
      _setText(result);
    }
  }

  void _clear() {
    _timeFormatter.clear();
    _key.currentState?.reset();
    setState(() {
      _errorText = null;
    });
    _controller.clear();
    widget.onChange?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    if (!_firstBuildComplete && widget.initialValue != null) {
      _setText(widget.initialValue!);
      _firstBuildComplete = true;
    }

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
              final customValidation = widget.validator?.call(_value);
              if (_value == null ||
                  _value!.hour > _hrsLimit ||
                  _value!.minute > _minsLimit ||
                  customValidation != null) {
                setState(() {
                  _errorText = customValidation ?? widget.errorText ?? '';
                });
                return '';
              }

              setState(() {
                _errorText = null;
              });
              return null;
            },
            textAlignVertical: TextAlignVertical.center,
            onChanged: (_) => _onChange(),
            style: _textStyle,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.only(left: ZetaSpacing.x3),
              filled: true,
              suffixIconConstraints: BoxConstraints(
                maxHeight: _iconSize * 2,
                minWidth: _iconSize * 2,
              ),
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
                      color: _colors.iconSubtle,
                    ),
                  _IconButton(
                    icon: widget.rounded ? ZetaIcons.clock_outline_round : ZetaIcons.clock_outline_sharp,
                    onTap: _pickTime,
                    disabled: widget.disabled,
                    size: _iconSize,
                    color: _colors.iconDefault,
                  ),
                ],
              ),
              focusColor: _backgroundColor,
              hoverColor: _backgroundColor,
              fillColor: _backgroundColor,
              enabledBorder: _baseBorder,
              disabledBorder: _baseBorder,
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
          disabled: widget.disabled,
          rounded: widget.rounded,
          hintText: widget.hint,
          errorText: _errorText,
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isValid', isValid));
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    required this.disabled,
    required this.size,
    required this.color,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool disabled;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return IconButton(
      padding: EdgeInsets.all(size / 2),
      constraints: BoxConstraints(
        maxHeight: size * 2,
        maxWidth: size * 2,
      ),
      color: !disabled ? color : colors.iconDisabled,
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
      ..add(DoubleProperty('size', size))
      ..add(ColorProperty('color', color));
  }
}

class _HintText extends StatelessWidget {
  const _HintText({
    required this.disabled,
    required this.hintText,
    required this.errorText,
    required this.rounded,
  });
  final bool disabled;
  final bool rounded;
  final String? hintText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final error = errorText != null && errorText!.isNotEmpty;

    final text = error ? errorText : hintText;

    Color elementColor = colors.textSubtle;

    if (disabled) {
      elementColor = colors.textDisabled;
    } else if (error) {
      elementColor = colors.error;
    }

    if (text == null) {
      return const SizedBox();
    }

    return Row(
      children: [
        Icon(
          errorText != null
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
        Expanded(
          child: Text(
            text,
            style: ZetaTextStyles.bodyXSmall.copyWith(color: elementColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).paddingTop(ZetaSpacing.x2);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('errorText', errorText));
  }
}
