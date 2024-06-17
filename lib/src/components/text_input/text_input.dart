import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';

/// Text inputs allow the user to enter text.
///
/// To show error messages on the text input, use the [validator]. The string returned from this function will be displayed as the error message.
/// Error messages can also be managed outside the text input by setting [errorText].
///
/// The input can be reset and validated by Creating a key of type [ZetaTextInputState] and calling either `reset` or `validate`.
/// However, it is recommended that the input is used and validated as part of a form.
class ZetaTextInput extends ZetaFormField<String> {
  /// Creates a new [ZetaTextInput]
  const ZetaTextInput({
    super.key,
    super.onChange,
    super.disabled = false,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    super.initialValue,
    super.rounded,
    this.label,
    this.hintText,
    this.placeholder,
    this.errorText,
    this.controller,
    this.validator,
    this.suffix,
    this.prefix,
    this.size = ZetaWidgetSize.medium,
    this.inputFormatters,
    this.prefixText,
    this.prefixTextStyle,
    this.suffixText,
    this.suffixTextStyle,
    this.onSubmit,
  })  : assert(initialValue == null || controller == null, 'Only one of initial value and controller can be accepted.'),
        assert(prefix == null || prefixText == null, 'Only one of prefix or prefixText can be accepted.'),
        assert(suffix == null || suffixText == null, 'Only one of suffix or suffixText can be accepted.');

  /// The label displayed above the input.
  final String? label;

  /// Called when the input is submitted.
  final void Function(String? val)? onSubmit;

  /// The hint text displayed below the input.
  final String? hintText;

  /// The placeholder text displayed in the input.
  final String? placeholder;

  /// The error text shown beneath the input. Replaces [hintText].
  final String? errorText;

  /// The controller given to the input. Cannot be given in addition to [initialValue].
  final TextEditingController? controller;

  /// The validator passed to the input. Should return the error message to be displayed below the input.
  /// Should return null if there is no error.
  final String? Function(String?)? validator;

  /// The widget displayed at the end of the input. Cannot be given in addition to [suffixText].
  final Widget? suffix;

  /// The text displayed at the end of the input. Cannot be given in addition to [suffix].
  final String? suffixText;

  /// The style applied to [suffixText].
  final TextStyle? suffixTextStyle;

  /// The widget displayed at the start of the input. Cannot be given in addition to [prefixText].
  final Widget? prefix;

  /// The text displayed at the end of the input. Cannot be given in addition to [prefix].
  final String? prefixText;

  /// The style applied to [prefixText].
  final TextStyle? prefixTextStyle;

  /// The size of the input.
  final ZetaWidgetSize size;

  /// The input formatters given to the text input.
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<ZetaTextInput> createState() => ZetaTextInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('placeholder', placeholder))
      ..add(StringProperty('initialValue', initialValue))
      ..add(StringProperty('errorText', errorText))
      ..add(DiagnosticsProperty<TextEditingController?>('controller', controller))
      ..add(ObjectFlagProperty<ValueChanged<String>?>.has('onChanged', onChange))
      ..add(ObjectFlagProperty<String? Function(String? p1)?>.has('validator', validator))
      ..add(StringProperty('suffixText', suffixText))
      ..add(DiagnosticsProperty<TextStyle?>('suffixTextStyle', suffixTextStyle))
      ..add(StringProperty('prefixText', prefixText))
      ..add(DiagnosticsProperty<TextStyle?>('prefixTextStyle', prefixTextStyle))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(IterableProperty<TextInputFormatter>('inputFormatters', inputFormatters))
      ..add(EnumProperty<ZetaFormFieldRequirement>('requirementLevel', requirementLevel))
      ..add(ObjectFlagProperty<void Function(String? val)?>.has('onSubmit', onSubmit));
  }
}

/// The current state of a [ZetaTextInput]
class ZetaTextInputState extends State<ZetaTextInput> implements ZetaFormFieldState {
  late final TextEditingController _controller;
  final GlobalKey<FormFieldState<String>> _key = GlobalKey();
  ZetaColors get _colors => Zeta.of(context).colors;

  // TODO(mikecoomber): refactor to use WidgetStateController
  bool _hovered = false;

  String? _errorText;

  Color get _backgroundColor {
    if (widget.disabled) {
      return _colors.surfaceDisabled;
    }
    if (_errorText != null) {
      return _colors.error.shade10;
    }
    return _colors.surfacePrimary;
  }

  TextStyle get _baseTextStyle {
    TextStyle style = ZetaTextStyles.bodyMedium;
    if (widget.size == ZetaWidgetSize.small) {
      style = ZetaTextStyles.bodyXSmall;
    }
    return style;
  }

  EdgeInsets get _contentPadding {
    switch (widget.size) {
      case ZetaWidgetSize.large:
        return const EdgeInsets.symmetric(horizontal: ZetaSpacing.medium, vertical: ZetaSpacing.large);
      case ZetaWidgetSize.small:
      case ZetaWidgetSize.medium:
        return const EdgeInsets.symmetric(horizontal: ZetaSpacing.medium, vertical: ZetaSpacing.medium);
    }
  }

  TextStyle get _affixStyle {
    Color color = _colors.textSubtle;
    if (widget.disabled) {
      color = _colors.textDisabled;
    }
    return _baseTextStyle.copyWith(color: color);
  }

  BoxConstraints get _affixConstraints {
    late final double size;
    switch (widget.size) {
      case ZetaWidgetSize.large:
        size = ZetaSpacing.xl_6;
      case ZetaWidgetSize.medium:
        size = ZetaSpacing.xl_4;
      case ZetaWidgetSize.small:
        size = ZetaSpacing.xl_2;
    }
    return BoxConstraints(
      minWidth: size,
    );
  }

  Widget? get _prefix {
    if (widget.prefix != null) return widget.prefix;
    if (widget.prefixText != null) {
      final style = widget.prefixTextStyle ?? _affixStyle;
      return Center(
        widthFactor: 0,
        child: Text(
          widget.prefixText!,
          style: style,
        ),
      ).paddingStart(ZetaSpacing.small);
    }

    return null;
  }

  Widget? get _suffix {
    if (widget.suffix != null) return widget.suffix;
    if (widget.suffixText != null) {
      final style = widget.suffixTextStyle ?? _affixStyle;
      return Center(
        widthFactor: 0,
        child: Text(
          widget.suffixText!,
          style: style,
        ),
      ).paddingEnd(ZetaSpacing.small);
    }

    return null;
  }

  OutlineInputBorder _baseBorder(bool rounded) => OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: _hovered ? _colors.borderSelected : _colors.borderSubtle),
      );

  OutlineInputBorder _focusedBorder(bool rounded) => _baseBorder(rounded).copyWith(
        borderSide: BorderSide(color: _colors.primary.shade50, width: ZetaSpacingBase.x0_5),
      ); // TODO(mikecoomber): change to colors.borderPrimary when added

  OutlineInputBorder _errorBorder(bool rounded) => _baseBorder(rounded).copyWith(
        borderSide: BorderSide(color: _colors.error, width: ZetaSpacingBase.x0_5),
      );

  @override
  void initState() {
    _controller = widget.controller ?? TextEditingController();
    _errorText = widget.errorText;

    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ZetaTextInput oldWidget) {
    if (oldWidget.errorText != widget.errorText) {
      setState(() {
        _errorText = widget.errorText;
      });
    }
    if (oldWidget.initialValue != widget.initialValue && widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool validate() => _key.currentState?.validate() ?? false;

  @override
  void reset() {
    _key.currentState?.reset();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;

    return ZetaRoundedScope(
      rounded: rounded,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            _Label(
              label: widget.label!,
              requirementLevel: widget.requirementLevel,
              disabled: widget.disabled,
            ),
            const SizedBox(height: ZetaSpacing.minimum),
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
              inputFormatters: widget.inputFormatters,
              validator: (val) {
                setState(() {
                  _errorText = widget.validator?.call(val);
                });
                return _errorText;
              },
              onFieldSubmitted: widget.onSubmit,
              textAlignVertical: TextAlignVertical.center,
              onChanged: widget.onChange,
              style: _baseTextStyle,
              cursorErrorColor: _colors.error,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: _contentPadding,
                filled: true,
                prefixIcon: _prefix,
                prefixIconConstraints: widget.prefixText != null ? _affixConstraints : null,
                suffixIcon: _suffix,
                suffixIconConstraints: _affixConstraints,
                focusColor: _backgroundColor,
                hoverColor: _backgroundColor,
                fillColor: _backgroundColor,
                enabledBorder: _baseBorder(rounded),
                disabledBorder: _baseBorder(rounded),
                focusedBorder: _focusedBorder(rounded),
                focusedErrorBorder: _errorBorder(rounded),
                errorBorder: widget.disabled ? _baseBorder(rounded) : _errorBorder(rounded),
                hintText: widget.placeholder,
                errorText: _errorText,
                hintStyle: _baseTextStyle,
                errorStyle: const TextStyle(height: 0.001, color: Colors.transparent),
              ),
            ),
          ),
          _HintText(
            disabled: widget.disabled,
            rounded: rounded,
            hintText: widget.hintText,
            errorText: _errorText,
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    required this.label,
    required this.requirementLevel,
    required this.disabled,
  });

  final String label;
  final ZetaFormFieldRequirement requirementLevel;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    const textStyle = ZetaTextStyles.bodyMedium;

    Widget? requirementWidget;

    if (requirementLevel == ZetaFormFieldRequirement.optional) {
      requirementWidget = Text(
        '(optional)', // TODO(UX-1003): needs localizing.
        style: textStyle.copyWith(color: disabled ? colors.textDisabled : colors.textSubtle),
      );
    } else if (requirementLevel == ZetaFormFieldRequirement.mandatory) {
      requirementWidget = Text(
        '*',
        style: ZetaTextStyles.labelIndicator.copyWith(
          color: disabled ? colors.textDisabled : colors.error, // TODO(mikecoomber): change to textNegative when added
        ),
      );
    }

    return Row(
      children: [
        Text(
          label,
          style: textStyle.copyWith(
            color: disabled ? colors.textDisabled : colors.textDefault,
          ),
        ),
        if (requirementWidget != null) requirementWidget.paddingStart(ZetaSpacing.minimum),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(EnumProperty<ZetaFormFieldRequirement>('requirementLevel', requirementLevel))
      ..add(DiagnosticsProperty<bool>('disabled', disabled));
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

    final text = error && !disabled ? errorText : hintText;

    Color elementColor = colors.textSubtle;

    if (disabled) {
      elementColor = colors.textDisabled;
    } else if (error) {
      elementColor = colors.error;
    }

    if (text == null || text.isEmpty) {
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
          size: ZetaSpacing.large,
          color: elementColor,
        ),
        const SizedBox(
          width: ZetaSpacing.minimum,
        ),
        Expanded(
          child: Text(
            text,
            style: ZetaTextStyles.bodyXSmall.copyWith(color: elementColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ).paddingTop(ZetaSpacing.small);
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
