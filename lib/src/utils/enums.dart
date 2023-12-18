import 'dart:ui';

///Border Types
enum BorderType {
  ///sharp border
  sharp,

  ///rounded border
  rounded,
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
