import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';
import 'hint_text.dart';
import 'input_label.dart';

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
    this.obscureText = false,
    this.keyboardType,
    this.focusNode,
  })  : assert(initialValue == null || controller == null, 'Only one of initial value and controller can be accepted.'),
        assert(prefix == null || prefixText == null, 'Only one of prefix or prefixText can be accepted.'),
        assert(suffix == null || suffixText == null, 'Only one of suffix or suffixText can be accepted.');

  /// {@template text-input-label}
  /// The label displayed above the input.
  /// {@endtemplate}
  final String? label;

  /// {@template text-input-on-submit}
  /// Called when the input is submitted.
  /// {@endtemplate}
  final void Function(String? val)? onSubmit;

  /// {@template text-input-hint-text}
  /// The hint text displayed below the input.
  /// {@endtemplate}
  final String? hintText;

  /// {@template text-input-placeholder}
  /// The placeholder text displayed in the input.
  /// {@endtemplate}
  final String? placeholder;

  /// {@template text-input-error-text}
  /// The error text shown beneath the input. Replaces [hintText].
  /// {@endtemplate}
  final String? errorText;

  /// {@template text-input-controller}
  /// The controller given to the input. Cannot be given in addition to [initialValue].
  /// {@endtemplate}
  final TextEditingController? controller;

  /// {@template text-input-validator}
  /// The validator passed to the input. Should return the error message to be displayed below the input.
  /// Should return null if there is no error.
  /// {@endtemplate}
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

  ///{@template text-input-size}
  /// The size of the input.
  /// {@endtemplate}
  final ZetaWidgetSize size;

  /// The input formatters given to the text input.
  final List<TextInputFormatter>? inputFormatters;

  /// {@template text-input-obscure-text}
  /// Obscures the text within the input.
  /// {@endtemplate}
  final bool obscureText;

  final TextInputType? keyboardType;

  final FocusNode? focusNode;

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
      ..add(ObjectFlagProperty<void Function(String? val)?>.has('onSubmit', onSubmit))
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText));
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
        return const EdgeInsets.symmetric(
          horizontal: ZetaSpacing.medium,
          vertical: ZetaSpacing.medium,
        );
      case ZetaWidgetSize.small:
      case ZetaWidgetSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZetaSpacing.small,
          vertical: ZetaSpacing.small,
        );
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
    late final double width;
    late final double height;
    switch (widget.size) {
      case ZetaWidgetSize.large:
        width = ZetaSpacing.xl_6;
        height = ZetaSpacing.xl_8;
      case ZetaWidgetSize.medium:
        width = ZetaSpacing.xl_4;
        height = ZetaSpacing.xl_6;
      case ZetaWidgetSize.small:
        width = ZetaSpacing.xl_2;
        height = ZetaSpacing.xl_4;
    }
    return BoxConstraints(
      minWidth: width,
      maxHeight: height,
    );
  }

  Widget? get _prefix => _getAffix(
        widget: widget.prefix,
        text: widget.prefixText,
        textStyle: widget.prefixTextStyle,
      );

  Widget? get _suffix => _getAffix(
        widget: widget.suffix,
        text: widget.suffixText,
        textStyle: widget.suffixTextStyle,
      );

  Widget? _getAffix({
    required Widget? widget,
    required String? text,
    required TextStyle? textStyle,
  }) {
    if (widget == null && text == null) return null;

    late final Widget child;
    if (widget != null) child = widget;
    if (text != null) {
      child = Center(
        widthFactor: 0,
        child: Text(
          text,
        ),
      ).paddingStart(ZetaSpacing.small);
    }
    final style = textStyle ?? _affixStyle;
    return DefaultTextStyle(
      style: style.copyWith(height: 1.5),
      textHeightBehavior: const TextHeightBehavior(
        applyHeightToFirstAscent: false,
      ),
      child: child,
    );
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
      child: MouseRegion(
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
          keyboardType: widget.keyboardType,
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
          obscureText: widget.obscureText,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: _contentPadding,
            filled: true,
            prefixIcon: _prefix,
            prefixIconConstraints: _affixConstraints,
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
    );
  }
}
