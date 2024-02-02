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

///  Size options for [ZetaIndicator], [ZetaWorkcloudIndicator], [ZetaButton], [ZetaPasswordInput].
enum ZetaWidgetSize {
  /// large
  large,

  /// medium
  medium,

  /// small
  small,
}

/// Status options for [ZetaBadge], [ZetaStatusLabel], [ZetaInPageBanner].
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
