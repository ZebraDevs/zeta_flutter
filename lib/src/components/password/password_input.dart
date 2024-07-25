import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';

/// Zeta Password Input
/// {@category Components}
class ZetaPasswordInput extends ZetaFormFieldOld<String> {
  ///Constructs [ZetaPasswordInput]
  const ZetaPasswordInput({
    super.key,
    super.rounded,
    super.initialValue,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    super.onChange,
    super.disabled = false,
    this.size = ZetaWidgetSize.large,
    this.validator,
    this.onSubmit,
    this.obscureText = true,
    @Deprecated('Use disabled instead. ' 'This property has been renamed as of 0.11.2') bool enabled = true,
    this.controller,
    this.hintText,
    this.errorText,
    this.label,
    this.placeholder,
    this.semanticLabel,
    this.obscureSemanticLabel,
    this.showSemanticLabel,
  });

  /// {@macro text-input-controller}
  final TextEditingController? controller;

  /// {@macro text-input-obscure-text}
  final bool obscureText;

  /// {@macro text-input-placeholder}
  final String? placeholder;

  /// {@macro text-input-label}
  final String? label;

  /// {@macro text-input-hint-text}
  final String? hintText;

  /// {@macro text-input-error-text}
  final String? errorText;

  /// {@macro text-input-size}
  final ZetaWidgetSize size;

  /// {@macro text-input-validator}
  final String? Function(String?)? validator;

  /// {@macro text-input-on-submit}
  final void Function(String? val)? onSubmit;

  /// Value passed to the wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  /// Semantic value on button to obscure text.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? obscureSemanticLabel;

  /// Semantic value on button to show text.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? showSemanticLabel;

  @override
  State<ZetaPasswordInput> createState() => _ZetaPasswordInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController?>('controller', controller))
      ..add(DiagnosticsProperty<bool>('obscureText', obscureText))
      ..add(StringProperty('hintText', hintText))
      ..add(StringProperty('label', label))
      ..add(StringProperty('footerText', hintText))
      ..add(ObjectFlagProperty<String? Function(String? p1)?>.has('validator', validator))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(StringProperty('placeholder', placeholder))
      ..add(ObjectFlagProperty<void Function(String? val)?>.has('onSubmit', onSubmit))
      ..add(StringProperty('errorText', errorText))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(StringProperty('showSemanticLabel', showSemanticLabel))
      ..add(StringProperty('obscureSemanticLabel', obscureSemanticLabel));
  }
}

class _ZetaPasswordInputState extends State<ZetaPasswordInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;

    return ZetaTextInput(
      size: widget.size,
      rounded: rounded,
      controller: widget.controller,
      validator: widget.validator,
      hintText: widget.hintText,
      placeholder: widget.placeholder,
      label: widget.label,
      onChange: widget.onChange,
      errorText: widget.errorText,
      onSubmit: widget.onSubmit,
      disabled: widget.disabled,
      obscureText: _obscureText,
      semanticLabel: widget.semanticLabel,
      suffix: MergeSemantics(
        child: Semantics(
          label: _obscureText ? widget.showSemanticLabel : widget.obscureSemanticLabel,
          child: IconButton(
            icon: ZetaIcon(_obscureText ? ZetaIcons.visibility_off : ZetaIcons.visibility),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
      ),
    );
  }
}
