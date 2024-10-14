import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import '../../interfaces/form_field.dart';
import '../text_input/internal_text_input.dart';

/// Zeta Password Input
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=948-13002&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/password-input
class ZetaPasswordInput extends ZetaTextFormField {
  ///Constructs [ZetaPasswordInput]
  ZetaPasswordInput({
    super.key,
    bool? rounded,
    super.initialValue,
    super.autovalidateMode,
    super.requirementLevel = ZetaFormFieldRequirement.none,
    super.onChange,
    super.onSaved,
    super.onFieldSubmitted,
    super.disabled = false,
    this.size = ZetaWidgetSize.medium,
    super.validator,
    this.onSubmit,
    @Deprecated('Use disabled instead. ' 'This property has been renamed as of 0.11.2') bool enabled = true,
    super.controller,
    this.hintText,
    this.errorText,
    this.label,
    this.placeholder,
    this.semanticLabel,
    this.obscureSemanticLabel,
    this.showSemanticLabel,
  }) : super(
          builder: (field) {
            final _ZetaPasswordInputState state = field as _ZetaPasswordInputState;

            return InternalTextInput(
              size: size,
              rounded: rounded,
              controller: state.effectiveController,
              hintText: hintText,
              placeholder: placeholder,
              label: label,
              onChange: state.didChange,
              requirementLevel: requirementLevel,
              errorText: field.errorText ?? errorText,
              onSubmit: onSubmit,
              constrained: true,
              disabled: disabled,
              obscureText: state._obscureText,
              semanticLabel: semanticLabel,
              suffix: MergeSemantics(
                child: Semantics(
                  label: state._obscureText ? showSemanticLabel : obscureSemanticLabel,
                  child: IconButton(
                    icon: ZetaIcon(state._obscureText ? ZetaIcons.visibility_off : ZetaIcons.visibility),
                    onPressed: state.toggleVisibility,
                  ),
                ),
              ),
            );
          },
        );

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

  /// {@macro text-input-on-submit}
  final void Function(String? val)? onSubmit;

  /// Value passed to the wrapping [Semantics]
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
  FormFieldState<String> createState() => _ZetaPasswordInputState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController?>('controller', controller))
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

class _ZetaPasswordInputState extends ZetaTextFormFieldState {
  bool _obscureText = true;

  void toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
