import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// An interface for all form fields used in Zeta
abstract class ZetaFormFieldStateOld {
  /// Validates the form field. Returns true if there are no errors.
  bool validate();

  /// Resets the form field to its initial state.
  void reset();
}

abstract class ZetaFormField<T> extends FormField<T> {
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

  final ValueChanged<T?>? onChange;

  final ValueChanged<T?>? onFieldSubmitted;

  final ZetaFormFieldRequirement? requirementLevel;
}

/// A common interface shared with all Zeta form elements.
abstract class ZetaFormFieldOld<T> extends ZetaStatefulWidget {
  /// Creates a new [ZetaFormFieldOld]
  const ZetaFormFieldOld({
    required this.disabled,
    required this.initialValue,
    required this.onChange,
    required this.requirementLevel,
    super.rounded,
    super.key,
  });

  /// {@macro zeta-widget-disabled}
  final bool disabled;

  /// The initial value of the form field.
  final T? initialValue;

  /// Called with the current value of the field whenever it is changed.
  final ValueChanged<T?>? onChange;

  /// The requirement level of the form field, e.g. mandatory or optional.
  final ZetaFormFieldRequirement requirementLevel;
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<T?>('initialValue', initialValue))
      ..add(ObjectFlagProperty<ValueChanged<T?>?>.has('onChange', onChange))
      ..add(EnumProperty<ZetaFormFieldRequirement>('requirementLevel', requirementLevel));
  }
}

abstract class ZetaTextFormField extends ZetaFormField<String> {
  ZetaTextFormField({
    required super.builder,
    required super.autovalidateMode,
    required super.initialValue,
    required super.validator,
    required super.onSaved,
    required super.onChange,
    required super.onFieldSubmitted,
    required super.disabled,
    required super.requirementLevel,
    required this.controller,
    super.key,
  });

  final TextEditingController? controller;
}

class ZetaTextFormFieldState extends FormFieldState<String> {
  @override
  ZetaTextFormField get widget => super.widget as ZetaTextFormField;

  late final TextEditingController effectiveController;

  @override
  void initState() {
    effectiveController = widget.controller ?? TextEditingController();

    if (widget.initialValue != null) {
      effectiveController.text = widget.initialValue!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ZetaTextInput oldWidget) {
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

  void onChange(String? value) {
    super.didChange(value);

    if (effectiveController.text != value) {
      effectiveController.text = value ?? '';
    }
    widget.onChange?.call(value);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>('effectiveController', effectiveController),
    );
  }
}
