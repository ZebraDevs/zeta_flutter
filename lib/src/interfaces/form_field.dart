import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../utils/enums.dart';

/// An interface for all form fields used in Zeta
abstract class ZetaFormFieldState {
  /// Validates the form field. Returns true if there are no errors.
  bool validate();

  /// Resets the form field to its initial state.
  void reset();
}

/// A common interface shared with all Zeta form elements.
abstract class ZetaFormField<T> extends StatefulWidget {
  /// Creats a new [ZetaFormField]
  const ZetaFormField({
    required this.disabled,
    required this.initialValue,
    required this.onChange,
    required this.requirementLevel,
    super.key,
  });

  /// Disables the form field.
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
