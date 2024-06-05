import 'package:flutter/material.dart';

/// Tokens that are used for spacing.
///
/// Values are doubles, and can be used for padding, margins and other spacings.
///
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

  /// Base multiplier used to calculate spacing values.
  @Deprecated('Use minimum instead ' 'This size has been deprecated as of 0.11.0')
  static const double spacingBaseMultiplier = 4;

  /// 2dp space.
  @Deprecated('Use ZetaSpacingBase.x0_5 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x0_5 = spacingBaseMultiplier * 0.5;

  /// 4dp space.
  @Deprecated('Use minimum instead ' 'This size has been deprecated as of 0.11.0')
  static const double x1 = spacingBaseMultiplier;

  /// 4dp space.
  @Deprecated('Use minimum instead ' 'This size has been deprecated as of 0.11.0')
  static const double xxs = spacingBaseMultiplier;

  /// 8dp space.
  @Deprecated('Use small instead ' 'This size has been deprecated as of 0.11.0')
  static const double x2 = spacingBaseMultiplier * 2;

  /// 8dp space.
  @Deprecated('Use small instead ' 'This size has been deprecated as of 0.11.0')
  static const double xs = spacingBaseMultiplier * 2;

  /// 10dp space.
  @Deprecated('Use ZetaSpacingBase.x2_5 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x2_5 = spacingBaseMultiplier * 2.5;

  /// 12dp space.
  @Deprecated('Use medium instead ' 'This size has been deprecated as of 0.11.0')
  static const double x3 = spacingBaseMultiplier * 3;

  /// 12dp space.
  @Deprecated('Use medium instead ' 'This size has been deprecated as of 0.11.0')
  static const double s = spacingBaseMultiplier * 3;

  /// 14dp space.
  @Deprecated('Use ZetaSpacingBase.x3_5 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x3_5 = spacingBaseMultiplier * 3.5;

  /// 16dp space.
  @Deprecated('Use large instead ' 'This size has been deprecated as of 0.11.0')
  static const double x4 = spacingBaseMultiplier * 4;

  /// 16dp space.
  @Deprecated('Use large instead ' 'This size has been deprecated as of 0.11.0')
  static const double b = spacingBaseMultiplier * 4;

  /// 20dp space.
  @Deprecated('Use xL instead ' 'This size has been deprecated as of 0.11.0')
  static const double x5 = spacingBaseMultiplier * 5;

  /// 24dp space.
  @Deprecated('Use xL2 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x6 = spacingBaseMultiplier * 6;

  /// 24dp space.
  @Deprecated('Use xL2 instead ' 'This size has been deprecated as of 0.11.0')
  static const double m = spacingBaseMultiplier * 6;

  /// 28dp space.
  @Deprecated('Use xL3 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x7 = spacingBaseMultiplier * 7;

  /// 30dp space.
  @Deprecated('Use ZetaSpacingBase.x7_5 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x7_5 = spacingBaseMultiplier * 7.5;

  /// 32dp space.
  @Deprecated('Use xL4 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x8 = spacingBaseMultiplier * 8;

  /// 32dp space.
  @Deprecated('Use xL4 instead ' 'This size has been deprecated as of 0.11.0')
  static const double l = spacingBaseMultiplier * 8;

  /// 36dp space.
  @Deprecated('Use xL5 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x9 = spacingBaseMultiplier * 9;

  /// 40dp space.
  @Deprecated('Use xL6 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x10 = spacingBaseMultiplier * 10;

  /// 44dp space.
  @Deprecated('Use xL7 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x11 = spacingBaseMultiplier * 11;

  /// 48dp space.
  @Deprecated('Use xL8 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x12 = spacingBaseMultiplier * 12;

  /// 52dp Space.
  @Deprecated('This size has been deprecated as of 0.11.0')
  static const double x13 = spacingBaseMultiplier * 13;

  /// 56dp Space.
  @Deprecated('Use ZetaSpacingBase.x12_5 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x14 = spacingBaseMultiplier * 14;

  /// 64dp space.
  @Deprecated('Use xL9 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x16 = spacingBaseMultiplier * 16;

  /// 64dp space.
  @Deprecated('Use xL9 instead ' 'This size has been deprecated as of 0.11.0')
  static const double xl = spacingBaseMultiplier * 16;

  /// 80dp space.
  @Deprecated('Use xL10 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x20 = spacingBaseMultiplier * 20;

  /// 80dp space.
  @Deprecated('Use xL10 instead ' 'This size has been deprecated as of 0.11.0')
  static const double xxl = spacingBaseMultiplier * 20;

  /// 96dp space.
  @Deprecated('Use xL11 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x24 = spacingBaseMultiplier * 24;

  /// 96dp space.
  @Deprecated('Use xL11 instead ' 'This size has been deprecated as of 0.11.0')
  static const double xxxl = spacingBaseMultiplier * 24;

  /// 120dp space
  @Deprecated('Use ZetaSpacingBase.x30 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x30 = spacingBaseMultiplier * 30;

  /// 200dp space
  @Deprecated('Use ZetaSpacingBase.x50 instead ' 'This size has been deprecated as of 0.11.0')
  static const double x50 = spacingBaseMultiplier * 50;
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

  /// Wide border radius; 24px radius.
  @Deprecated('Use xL instead ' 'This size has been deprecated as of 0.11.0')
  static const BorderRadius wide = BorderRadius.all(Radius.circular(ZetaSpacing.m));
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
