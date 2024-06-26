import '../../../zeta_flutter.dart';

/// A class for controlling a [ZetaDropdown]
///
/// Can be acquired from the builder method of a [ZetaDropdown]
abstract class ZetaDropdownController {
  /// Returns true if the dropdown is open.
  bool get isOpen;

  /// Opens the dropdown.
  void open();

  /// Closes the dropdown.
  void close();

  /// Toggles the dropdown open or closed depending on its current state.
  void toggle();
}
