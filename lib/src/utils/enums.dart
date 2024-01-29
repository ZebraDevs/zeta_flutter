import 'dart:ui';
import '../../zeta_flutter.dart';

///Border Types
enum BorderType {
  /// Sharp border
  sharp,

  /// Slightly rounded border.
  rounded,

  /// Fully rounded border.
  full,
}

/// Widget Severity
enum WidgetSeverity {
  ///Grey Label
  neutral,

  ///Purple Label
  info,

  ///Green Label
  positive,

  ///Yellow Label
  warning,

  ///Red Label
  negative,

  ///Custom Label
  custom
}

/// [ZetaWidgetSize] size
enum ZetaWidgetSize {
  /// large
  large,

  /// medium
  medium,

  /// small
  small,
}

///Widget Colors
class ZetaWidgetColor {
  ///Constructs [ZetaWidgetColor].
  const ZetaWidgetColor({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  ///Background Color
  final Color backgroundColor;

  ///foregroundColor Color
  final Color foregroundColor;
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
