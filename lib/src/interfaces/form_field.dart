/// An interface for all form fields used in Zeta
abstract class ZetaFormField {
  /// Validates the form field. Returns true if there are no errors.
  bool validate();

  /// Resets the form field to its initial state.
  void reset();
}
