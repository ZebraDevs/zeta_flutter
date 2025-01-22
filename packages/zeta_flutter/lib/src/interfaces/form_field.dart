import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// An interface for all form fields used in Zeta
abstract class ZetaFormField<T> extends FormField<T> {
  /// Creates a new [ZetaFormField]
  const ZetaFormField({
    required super.builder,
    required super.autovalidateMode,
    required super.initialValue,
    required super.validator,
    required super.onSaved,
    required this.onChange,
    required this.onFieldSubmitted,
    ZetaFormFieldRequirement? requirementLevel,
    bool disabled = false,
    super.key,
  })  : requirementLevel = requirementLevel ?? ZetaFormFieldRequirement.none,
        super(
          enabled: !disabled,
        );

  /// Called whenever the form field changes.
  final ValueChanged<T?>? onChange;

  /// Called whenever the form field is submitted.
  final ValueChanged<T?>? onFieldSubmitted;

  /// The requirement level of the form field.
  final ZetaFormFieldRequirement? requirementLevel;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ValueChanged<T?>?>.has('onChange', onChange))
      ..add(ObjectFlagProperty<ValueChanged<T?>?>.has('onFieldSubmitted', onFieldSubmitted))
      ..add(EnumProperty<ZetaFormFieldRequirement?>('requirementLevel', requirementLevel));
  }
}

/// A text form field used in Zeta
abstract class ZetaTextFormField extends ZetaFormField<String> {
  /// Creates a new [ZetaTextFormField]
  ZetaTextFormField({
    required super.builder,
    required super.autovalidateMode,
    required super.validator,
    required super.onSaved,
    required super.onChange,
    required super.onFieldSubmitted,
    required super.disabled,
    required super.requirementLevel,
    required this.controller,
    required String? initialValue,
    super.key,
  }) : super(
          initialValue: controller != null ? controller.text : (initialValue ?? ''),
        );

  /// The controller for the text form field.
  final TextEditingController? controller;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController?>('controller', controller));
  }
}

/// The state for a [ZetaTextFormField]
class ZetaTextFormFieldState extends FormFieldState<String> {
  @override
  ZetaTextFormField get widget => super.widget as ZetaTextFormField;

  /// The effective controller for the form field.
  /// This is either the controller passed in or a new controller.
  late final TextEditingController effectiveController;

  @override
  void initState() {
    effectiveController = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      effectiveController.text = widget.initialValue!;
    }
    effectiveController.addListener(_handleControllerChange);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ZetaTextFormField oldWidget) {
    if (oldWidget.initialValue != widget.initialValue && widget.initialValue != null) {
      effectiveController.text = widget.initialValue!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void reset() {
    effectiveController.text = widget.initialValue ?? '';
    super.reset();
    widget.onChange?.call(effectiveController.text);
  }

  /// Called whenever the form field changes.
  void onChange(String? value) {
    didChange(value);
    widget.onChange?.call(value);
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (effectiveController.text != value) {
      effectiveController.text = value ?? '';
    }
  }

  void _handleControllerChange() {
    if (effectiveController.text != value) {
      didChange(effectiveController.text);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>('effectiveController', effectiveController),
    );
  }
}
