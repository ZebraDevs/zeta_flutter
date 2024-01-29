import 'package:flutter/material.dart';

/// Tokens that are used for spacing.
///
/// Values are doubles, and can be used for padding, margins and other spacings.
///
// TODO(thelukewalton): Refactor to match latest designs.
class ZetaSpacing {
  /// Base multiplier used to calculate spacing values.
  static const double spacingBaseMultiplier = 4;

  /// 0dp space.
  static const double x0 = spacingBaseMultiplier * 0;

  /// 4dp space.
  static const double x1 = spacingBaseMultiplier;

  /// 4dp space.
  static const double xxs = spacingBaseMultiplier;

  /// 8dp space.
  static const double x2 = spacingBaseMultiplier * 2;

  /// 8dp space.
  static const double xs = spacingBaseMultiplier * 2;

  /// 12dp space.
  static const double x3 = spacingBaseMultiplier * 3;

  /// 12dp space.
  static const double s = spacingBaseMultiplier * 3;

  /// 14dp space.
  static const double x3_5 = spacingBaseMultiplier * 3.5;

  /// 16dp space.
  static const double x4 = spacingBaseMultiplier * 4;

  /// 16dp space.
  static const double b = spacingBaseMultiplier * 4;

  /// 20dp space.
  static const double x5 = spacingBaseMultiplier * 5;

  /// 24dp space.
  static const double x6 = spacingBaseMultiplier * 6;

  /// 24dp space.
  static const double m = spacingBaseMultiplier * 6;

  /// 28dp space.
  static const double x7 = spacingBaseMultiplier * 7;

  /// 32dp space.
  static const double x8 = spacingBaseMultiplier * 8;

  /// 32dp space.
  static const double l = spacingBaseMultiplier * 8;

  /// 36dp space.
  static const double x9 = spacingBaseMultiplier * 9;

  /// 40dp space.
  static const double x10 = spacingBaseMultiplier * 10;

  /// 44dp space.
  static const double x11 = spacingBaseMultiplier * 11;

  /// 48dp space.
  static const double x12 = spacingBaseMultiplier * 12;

  /// 52dp Space.
  static const double x13 = spacingBaseMultiplier * 13;

  /// 56dp Space.
  static const double x14 = spacingBaseMultiplier * 14;

  /// 64dp space.
  static const double x16 = spacingBaseMultiplier * 16;

  /// 64dp space.
  static const double xl = spacingBaseMultiplier * 16;

  /// 80dp space.
  static const double x20 = spacingBaseMultiplier * 20;

  /// 80dp space.
  static const double xxl = spacingBaseMultiplier * 20;

  /// 96dp space.
  static const double x24 = spacingBaseMultiplier * 24;

  /// 96dp space.
  static const double xxxl = spacingBaseMultiplier * 24;
}

/// Tokens used for Border Radius.
class ZetaRadius {
  /// No border radius; 0px radius.
  static const BorderRadius none = BorderRadius.zero;

  /// Smallest amount of border radius; 4px radius.
  static const BorderRadius minimal = BorderRadius.all(Radius.circular(ZetaSpacing.xxs));

  /// Border radius used when rounded parameter is true; 8px radius.
  static const BorderRadius rounded = BorderRadius.all(Radius.circular(ZetaSpacing.xs));

  /// Wide border radius; 24px radius.
  static const BorderRadius wide = BorderRadius.all(Radius.circular(ZetaSpacing.m));

  /// Largest amount of border radius; 360px radius.
  static const BorderRadius full = BorderRadius.all(Radius.circular(360));
}
