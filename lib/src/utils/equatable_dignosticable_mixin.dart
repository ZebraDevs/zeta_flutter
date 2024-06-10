import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/// A mixin that combines the functionality of `Diagnosticable` and `EquatableMixin`.
///
/// This mixin is useful for classes that need to be both equatable (i.e., support value comparison)
/// and support Flutter's diagnostic capabilities (e.g., for improved debugging output).
///
/// When using this mixin, ensure that the `toString` method conforms to the `Diagnosticable` signature,
/// which accepts an optional `minLevel` parameter.
mixin EquatableDiagnosticableMixin on EquatableMixin {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${super.toString()}';
  }
}
