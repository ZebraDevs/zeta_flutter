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
    super.autovalidateMode,
    super.initialValue,
    super.validator,
    super.onSaved,
    this.onChange,
    this.onFieldSubmitted,
    this.requirementLevel = ZetaFormFieldRequirement.none,
    bool disabled = false,
    super.key,
  }) : super(
          enabled: !disabled,
        );

  final ValueChanged<T?>? onChange;

  final ValueChanged<T?>? onFieldSubmitted;

  final ZetaFormFieldRequirement requirementLevel;
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
