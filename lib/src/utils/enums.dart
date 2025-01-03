import 'package:flutter/widgets.dart';

import '../../zeta_flutter.dart';

/// Border options for [ZetaButton].
enum ZetaWidgetBorder {
  /// Sharp border
  sharp,

  /// Slightly rounded border.
  rounded,

  /// Fully rounded border.
  full;

  /// Returns the border radius for the given [ZetaWidgetBorder].
  BorderRadius radius(BuildContext context) => switch (this) {
        ZetaWidgetBorder.sharp => Zeta.of(context).radius.none,
        ZetaWidgetBorder.rounded => Zeta.of(context).radius.rounded,
        ZetaWidgetBorder.full => Zeta.of(context).radius.full,
      };
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
  neutral;

  /// Gets the surface color for [ZetaWidgetStatus].
  Color surfaceColor(BuildContext context) => switch (this) {
        ZetaWidgetStatus.info => Zeta.of(context).colors.surfaceInfo,
        ZetaWidgetStatus.positive => Zeta.of(context).colors.surfacePositive,
        ZetaWidgetStatus.warning => Zeta.of(context).colors.surfaceWarning,
        ZetaWidgetStatus.negative => Zeta.of(context).colors.surfaceNegative,
        ZetaWidgetStatus.neutral => Zeta.of(context).colors.mainLight,
      };

  /// Gets the label foreground color for [ZetaWidgetStatus].
  Color labelForegroundColor(BuildContext context) => switch (this) {
        ZetaWidgetStatus.info => Zeta.of(context).colors.mainInverse,
        ZetaWidgetStatus.positive => Zeta.of(context).colors.mainInverse,
        ZetaWidgetStatus.warning => Zeta.of(context).colors.mainInverse,
        ZetaWidgetStatus.negative => Zeta.of(context).colors.mainInverse,
        ZetaWidgetStatus.neutral => Zeta.of(context).colors.mainDefault,
      };

  /// Gets the surface subtle color for [ZetaWidgetStatus].
  Color surfaceSubtleColor(BuildContext context) => switch (this) {
        ZetaWidgetStatus.info => Zeta.of(context).colors.surfaceInfoSubtle,
        ZetaWidgetStatus.positive => Zeta.of(context).colors.surfacePositiveSubtle,
        ZetaWidgetStatus.warning => Zeta.of(context).colors.surfaceWarningSubtle,
        ZetaWidgetStatus.negative => Zeta.of(context).colors.surfaceNegativeSubtle,
        ZetaWidgetStatus.neutral => Zeta.of(context).colors.mainLight,
      };

  /// Gets foreground color from [ZetaWidgetStatus].
  Color mainColor(BuildContext context) => switch (this) {
        ZetaWidgetStatus.info => Zeta.of(context).colors.mainInfo,
        ZetaWidgetStatus.positive => Zeta.of(context).colors.mainPositive,
        ZetaWidgetStatus.warning => Zeta.of(context).colors.mainWarning,
        ZetaWidgetStatus.negative => Zeta.of(context).colors.mainNegative,
        ZetaWidgetStatus.neutral => Zeta.of(context).colors.mainSubtle,
      };

  /// Gets border color for [ZetaWidgetStatus].
  Color borderColor(BuildContext context) => switch (this) {
        ZetaWidgetStatus.info => Zeta.of(context).colors.borderInfo,
        ZetaWidgetStatus.positive => Zeta.of(context).colors.borderPositive,
        ZetaWidgetStatus.warning => Zeta.of(context).colors.borderWarning,
        ZetaWidgetStatus.negative => Zeta.of(context).colors.borderNegative,
        ZetaWidgetStatus.neutral => Zeta.of(context).colors.borderDefault,
      };
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
