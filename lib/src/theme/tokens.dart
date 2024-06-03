import 'package:flutter/material.dart';

/// Tokens that are used for spacing.
///
/// Values are doubles, and can be used for padding, margins and other spacings.
///
// TODO(thelukewalton): Refactor to match latest designs.
/// Semantic zeta spacings.
class ZetaSpacing {
  /// No spacing => 0px.
  static const double none = ZetaSpacingBase.x0;

  /// Minimum spacing => 4px.
  static const double minimum = ZetaSpacingBase.x1;

  /// Small spacing => 8px.
  static const double small = ZetaSpacingBase.x2;

  /// Medium spacing => 12px.
  static const double medium = ZetaSpacingBase.x3;

  /// Large spacing => 16px.
  static const double large = ZetaSpacingBase.x4;

  /// xL spacing => 20px.
  static const double xL = ZetaSpacingBase.x5;

  /// 2xL spacing => 24px.
  static const double xL2 = ZetaSpacingBase.x6;

  /// 3xL spacing => 28px.
  static const double xL3 = ZetaSpacingBase.x7;

  /// 4xL spacing => 32px.
  static const double xL4 = ZetaSpacingBase.x8;

  /// 5xL spacing => 36px.
  static const double xL5 = ZetaSpacingBase.x9;

  /// 6xL spacing => 40px.
  static const double xL6 = ZetaSpacingBase.x10;

  /// 7xL spacing => 44px.
  static const double xL7 = ZetaSpacingBase.x11;

  /// 8xL spacing => 48px.
  static const double xL8 = ZetaSpacingBase.x12;

  /// 9xL spacing => 64px.
  static const double xL9 = ZetaSpacingBase.x13;

  /// 10xL spacing => 80px.
  static const double xL10 = ZetaSpacingBase.x14;

  /// 11xL spacing => 96px
  static const double xL11 = ZetaSpacingBase.x15;
}

/// Semantic zeta radii.
class ZetaRadius {
  /// No radius =>  0px radius.
  static const BorderRadius none = BorderRadius.zero;

  /// Minimal radius => 4px radius.
  static const BorderRadius minimal = ZetaRadiusBase.s;

  /// Rounded radius => 8px radius.
  static const BorderRadius rounded = ZetaRadiusBase.m;

  /// Large radius => 16px radius.
  static const BorderRadius large = ZetaRadiusBase.l;

  /// xL radius => 24px radius.
  static const BorderRadius xL = ZetaRadiusBase.xL;

  /// Full radius => 360px radius.
  static const BorderRadius full = ZetaRadiusBase.x4;
}

///Tokens that are used for Spacing
class ZetaSpacingBase {
  /// 0dp space
  static const double x0 = 0;

  /// 2dp space
  static const double x0_5 = 2;

  /// 4dp space
  static const double x1 = 4;

  /// 8dp space
  static const double x2 = 8;

  /// 10dp space
  static const double x2_5 = 10;

  /// 12dp space
  static const double x3 = 12;

  /// 14dp space.
  static const double x3_5 = 14;

  /// 16dp space
  static const double x4 = 16;

  /// 20dp space
  static const double x5 = 20;

  /// 24dp space
  static const double x6 = 24;

  /// 28dp space
  static const double x7 = 28;

  /// 30dp space.
  static const double x7_5 = 30;

  /// 32dp space
  static const double x8 = 32;

  /// 36dp space
  static const double x9 = 36;

  /// 40dp space
  static const double x10 = 40;

  /// 44dp space
  static const double x11 = 44;

  /// 48dp space
  static const double x12 = 48;

  /// 56dp space
  static const double x12_5 = 56;

  /// 64dp space
  static const double x13 = 64;

  /// 80dp space
  static const double x14 = 80;

  /// 96dp space
  static const double x15 = 96;

  /// 120dp space
  static const double x30 = 120;

  /// 200dp space
  static const double x50 = 200;
}

///Tokens that are used for Border Radius
class ZetaRadiusBase {
  /// 4px radius
  static const BorderRadius s = BorderRadius.all(Radius.circular(4));

  /// 8px radius
  static const BorderRadius m = BorderRadius.all(Radius.circular(8));

  /// 16px radius
  static const BorderRadius l = BorderRadius.all(Radius.circular(16));

  /// 24px radius
  static const BorderRadius xL = BorderRadius.all(Radius.circular(24));

  /// 32px radius
  static const BorderRadius x2 = BorderRadius.all(Radius.circular(32));

  /// 128px radius
  static const BorderRadius x3 = BorderRadius.all(Radius.circular(128));

  /// 360px radius
  static const BorderRadius x4 = BorderRadius.all(Radius.circular(360));
}
