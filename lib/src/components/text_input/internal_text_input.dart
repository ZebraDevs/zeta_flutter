import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';
import 'hint_text.dart';
import 'input_label.dart';

/// Text inputs allow the user to enter text.
/// Not intended for external use.
class InternalTextInput extends ZetaStatefulWidget {
  /// Creates a new [InternalTextInput]
  const InternalTextInput({
    super.key,
    this.onChange,
    this.disabled = false,
    this.requirementLevel = ZetaFormFieldRequirement.none,
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
    this.externalPrefix,
    this.semanticLabel,
    this.borderRadius,
  })  : assert(prefix == null || prefixText == null, 'Only one of prefix or prefixText can be accepted.'),
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
  /// The controller given to the input.
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

  /// The keyboard type of the input.
  final TextInputType? keyboardType;

  /// The focus node of the input.
  final FocusNode? focusNode;

  /// The border radius of the input.
  final BorderRadius? borderRadius;

  /// Value passed to the wrapping [Semantics] widget.
  ///
  /// If null, the label will be used.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  final ValueChanged<String?>? onChange;

  final bool disabled;

  final ZetaFormFieldRequirement requirementLevel;

  final Widget? externalPrefix;

  @override
  State<InternalTextInput> createState() => ZetaTextInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('placeholder', placeholder))
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
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText))
      ..add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(DiagnosticsProperty<BorderRadius?>('borderRadius', borderRadius))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// The current state of a [InternalTextInput]
class ZetaTextInputState extends State<InternalTextInput> {
  late final TextEditingController _controller;
  ZetaColors get _colors => Zeta.of(context).colors;

  // TODO(mikecoomber): refactor to use WidgetStateController
  bool _hovered = false;

  Color get _backgroundColor {
    if (widget.disabled) {
      return _colors.surfaceDisabled;
    }
    if (widget.errorText != null) {
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
          vertical: ZetaSpacing.large,
        );
      case ZetaWidgetSize.small:
      case ZetaWidgetSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: ZetaSpacing.medium,
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
        width = ZetaSpacing.xl_6;
        height = ZetaSpacing.xl_6;
      case ZetaWidgetSize.small:
        width = ZetaSpacing.xl_6;
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
        widthFactor: 1,
        child: Text(
          text,
        ),
      ).paddingHorizontal(ZetaSpacing.small);
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
        borderRadius: widget.borderRadius ?? (rounded ? ZetaRadius.minimal : ZetaRadius.none),
        borderSide: BorderSide(
          color: !widget.disabled ? (_hovered ? _colors.borderSelected : _colors.borderSubtle) : _colors.borderDefault,
        ),
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;

    return ZetaRoundedScope(
      rounded: rounded,
      child: Semantics(
        label: widget.semanticLabel ?? widget.hintText,
        enabled: !widget.disabled,
        excludeSemantics: widget.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              ZetaInputLabel(
                label: widget.label!,
                requirementLevel: widget.requirementLevel,
                disabled: widget.disabled,
              ),
              const SizedBox(height: ZetaSpacing.minimum),
            ],
            Row(
              children: [
                if (widget.externalPrefix != null) widget.externalPrefix!,
                Expanded(
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
                    child: TextField(
                      enabled: !widget.disabled,
                      controller: _controller,
                      keyboardType: widget.keyboardType,
                      inputFormatters: widget.inputFormatters,
                      onSubmitted: widget.onSubmit,
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
                        prefixIconConstraints: widget.prefixText != null ? _affixConstraints : null,
                        suffixIcon: _suffix,
                        suffixIconConstraints: widget.suffixText != null ? _affixConstraints : null,
                        focusColor: _backgroundColor,
                        hoverColor: _backgroundColor,
                        fillColor: _backgroundColor,
                        enabledBorder: _baseBorder(rounded),
                        disabledBorder: _baseBorder(rounded),
                        focusedBorder: _focusedBorder(rounded),
                        focusedErrorBorder: _errorBorder(rounded),
                        errorBorder: widget.disabled ? _baseBorder(rounded) : _errorBorder(rounded),
                        hintText: widget.placeholder,
                        errorText: widget.errorText,
                        hintStyle: _baseTextStyle,
                        errorStyle: const TextStyle(height: 0.001, color: Colors.transparent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ZetaHintText(
              disabled: widget.disabled,
              rounded: rounded,
              hintText: widget.hintText,
              errorText: widget.errorText,
            ),
          ],
        ),
      ),
    );
  }
}
