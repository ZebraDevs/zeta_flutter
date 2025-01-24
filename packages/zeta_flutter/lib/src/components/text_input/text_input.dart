import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../zeta_flutter.dart';

import 'internal_text_input.dart';

// TODO(UX-895): Text Input connected left
// TODO(UX-1360): Text Input disabled bug

/// Text inputs allow the user to enter text.
///
/// To show error messages on the text input, use the [validator]. The string returned from this function will be displayed as the error message.
/// Error messages can also be managed outside the text input by setting [errorText].
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-38&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/text-input
class ZetaTextInput extends ZetaTextFormField {
  /// Creates a new [ZetaTextInput]
  ZetaTextInput({
    super.key,
    super.onChange,
    super.disabled = false,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    super.initialValue,
    super.autovalidateMode,
    super.validator,
    super.onSaved,
    super.onFieldSubmitted,
    bool? rounded,
    this.label,
    this.hintText,
    this.placeholder,
    this.errorText,
    super.controller,
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
    this.semanticLabel,
  })  : assert(initialValue == null || controller == null, 'Only one of initial value and controller can be accepted.'),
        assert(prefix == null || prefixText == null, 'Only one of prefix or prefixText can be accepted.'),
        assert(suffix == null || suffixText == null, 'Only one of suffix or suffixText can be accepted.'),
        super(
          builder: (field) {
            final ZetaTextFormFieldState state = field as ZetaTextFormFieldState;

            return InternalTextInput(
              label: label,
              disabled: disabled,
              rounded: rounded,
              hintText: hintText,
              placeholder: placeholder,
              errorText: field.errorText ?? errorText,
              controller: state.effectiveController,
              suffix: suffix,
              suffixText: suffixText,
              suffixTextStyle: suffixTextStyle,
              prefix: prefix,
              prefixText: prefixText,
              prefixTextStyle: prefixTextStyle,
              size: size,
              onChange: state.onChange,
              onSubmit: onSubmit,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              keyboardType: keyboardType,
              focusNode: focusNode,
              semanticLabel: semanticLabel,
            );
          },
        );

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

  /// Value passed to the wrapping [Semantics] widget.
  ///
  /// If null, the label will be used.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  @override
  FormFieldState<String> createState() => ZetaTextFormFieldState();

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
      ..add(IterableProperty<TextInputFormatter>('inputFormatters', inputFormatters))
      ..add(EnumProperty<ZetaFormFieldRequirement>('requirementLevel', requirementLevel))
      ..add(ObjectFlagProperty<void Function(String? val)?>.has('onSubmit', onSubmit))
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText))
      ..add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
