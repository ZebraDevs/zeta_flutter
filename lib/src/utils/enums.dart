import '../../zeta_flutter.dart';

/// Border options for [ZetaButton].
enum ZetaWidgetBorder {
  /// Sharp border
  sharp,

  /// Slightly rounded border.
  rounded,

  /// Fully rounded border.
  full,
}

///  Size options for [ZetaIndicator], [ZetaButton], [ZetaPasswordInput].
enum ZetaWidgetSize {
  /// large
  large,

  /// medium
  medium,

  /// small
  small,
}

/// Status options for [ZetaLabel], [ZetaStatusLabel], [ZetaInPageBanner].
enum ZetaWidgetStatus {
  /// Information widget; defaults to purple color scheme.
  info,

  /// Positive widget; defaults to green color scheme.
  positive,

  /// Warning widget; defaults to yellow color scheme.
  warning,

  /// Negative widget; defaults to red color scheme.
  negative,

  /// Neutral widget; defaults to grey color scheme.
  neutral,
}

/// The requirement options for a Form Field.
enum ZetaFormFieldRequirement {
  /// The default form field requirement.
  none,

  /// A mandatory form field.
  mandatory,

  /// An optional form field.
  optional,
}

/// Sets the type of a [ZetaDropdown]
enum ZetaDropdownMenuType {
  /// No leading elements before each item unless an icon is given to the [ZetaDropdownItem]
  standard,

  /// Displays a [ZetaCheckbox] before each item.
  checkbox,

  /// Displays a [ZetaRadio] before each item.
  radio
}

/// Used to set the size of a [ZetaDropdown]
enum ZetaDropdownSize {
  /// The minimum width of the dropdown menu is set to the width of the parent.
  standard,

  /// The width of the dropdown menu wraps the largest of its children.
  mini,
}
