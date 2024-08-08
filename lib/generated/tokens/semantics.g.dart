import 'package:flutter/material.dart';
import 'primitives.g.dart';

// This file is automatically generated by the zeta repository
// DO NOT MODIFY

/// Semantic tokens for colors.
abstract interface class ZetaColorSemantics {
  /// Primitives used to construct semantic colors
  ZetaPrimitives get primitives;

  /// The semantic tokens for Main
  ZetaMainColors get main;

  /// The semantic tokens for Border
  ZetaBorderColors get border;

  /// The semantic tokens for Surface
  ZetaSurfaceColors get surface;

  /// The semantic tokens for Avatar
  ZetaAvatarColors get avatar;

  /// The semantic tokens for State
  ZetaStateColors get state;

  /// The semantic tokens for Disabled
  ZetaDisabledColors get disabled;

  /// The semantic tokens for Default
  ZetaDefaultColors get defaultColor;

  /// The semantic tokens for Primary
  ZetaPrimaryColors get primary;

  /// The semantic tokens for Secondary
  ZetaSecondaryColors get secondary;

  /// The semantic tokens for Positive
  ZetaPositiveColors get positive;

  /// The semantic tokens for Negative
  ZetaNegativeColors get negative;

  /// The semantic tokens for Info
  ZetaInfoColors get info;

  /// The semantic tokens for Inverse
  ZetaInverseColors get inverse;
}

/// The semantic tokens for Main colors
abstract interface class ZetaMainColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Default Color
  Color get defaultColor;

  /// Subtle
  Color get subtle;

  /// Light
  Color get light;

  /// Inverse
  Color get inverse;

  /// Disabled
  Color get disabled;

  /// Primary
  Color get primary;

  /// Secondary
  Color get secondary;

  /// Positive
  Color get positive;

  /// Warning
  Color get warning;

  /// Negative
  Color get negative;

  /// Info
  Color get info;
}

/// The semantic tokens for Border colors
abstract interface class ZetaBorderColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Default Color
  Color get defaultColor;

  /// Subtle
  Color get subtle;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Disabled
  Color get disabled;

  /// Pure
  Color get pure;

  /// Primary Main
  Color get primaryMain;

  /// Primary
  Color get primary;

  /// Secondary
  Color get secondary;

  /// Positive
  Color get positive;

  /// Warning
  Color get warning;

  /// Negative
  Color get negative;

  /// Info
  Color get info;
}

/// The semantic tokens for Surface colors
abstract interface class ZetaSurfaceColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Default Color
  Color get defaultColor;

  /// Default Inverse
  Color get defaultInverse;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Selected Hover
  Color get selectedHover;

  /// Disabled
  Color get disabled;

  /// Cool
  Color get cool;

  /// Warm
  Color get warm;

  /// Primary
  Color get primary;

  /// Primary Subtle
  Color get primarySubtle;

  /// Secondary
  Color get secondary;

  /// Avatar
  ZetaAvatarColors get avatar;
}

/// The semantic tokens for Avatar colors
abstract interface class ZetaAvatarColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Blue
  Color get blue;

  /// Green
  Color get green;

  /// Orange
  Color get orange;

  /// Pink
  Color get pink;

  /// Purple
  Color get purple;

  /// Teal
  Color get teal;

  /// Yellow
  Color get yellow;

  /// Secondary Subtle
  Color get secondarySubtle;

  /// Positive
  Color get positive;

  /// Positive Subtle
  Color get positiveSubtle;

  /// Warning
  Color get warning;

  /// Warning Subtle
  Color get warningSubtle;

  /// Negative
  Color get negative;

  /// Negative Subtle
  Color get negativeSubtle;

  /// Info
  Color get info;

  /// Info Subtle
  Color get infoSubtle;
}

/// The semantic tokens for State colors
abstract interface class ZetaStateColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Disabled
  ZetaDisabledColors get disabled;
}

/// The semantic tokens for Disabled colors
abstract interface class ZetaDisabledColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Disabled
  Color get disabled;

  /// Default
  ZetaDefaultColors get defaultColor;
}

/// The semantic tokens for Default colors
abstract interface class ZetaDefaultColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;

  /// Primary
  ZetaPrimaryColors get primary;
}

/// The semantic tokens for Primary colors
abstract interface class ZetaPrimaryColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;

  /// Secondary
  ZetaSecondaryColors get secondary;
}

/// The semantic tokens for Secondary colors
abstract interface class ZetaSecondaryColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;

  /// Positive
  ZetaPositiveColors get positive;
}

/// The semantic tokens for Positive colors
abstract interface class ZetaPositiveColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;

  /// Negative
  ZetaNegativeColors get negative;
}

/// The semantic tokens for Negative colors
abstract interface class ZetaNegativeColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;

  /// Info
  ZetaInfoColors get info;
}

/// The semantic tokens for Info colors
abstract interface class ZetaInfoColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;

  ///  Inverse
  ZetaInverseColors get inverse;
}

/// The semantic tokens for Inverse colors
abstract interface class ZetaInverseColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Enabled
  Color get enabled;

  /// Hover
  Color get hover;

  /// Selected
  Color get selected;

  /// Focus
  Color get focus;
}

/// Semantic tokens for Size.
abstract interface class ZetaSpacingSemantics {
  /// Primitives used to construct semantic spaces
  ZetaPrimitives get primitives;

  /// None space
  double get none;

  /// Minimum space
  double get minimum;

  /// Small space
  double get small;

  /// Medium space
  double get medium;

  /// Large space
  double get large;

  /// Xl space
  double get xl;

  /// Xl_2 space
  double get xl_2;

  /// Xl_3 space
  double get xl_3;

  /// Xl_4 space
  double get xl_4;

  /// Xl_5 space
  double get xl_5;

  /// Xl_6 space
  double get xl_6;

  /// Xl_7 space
  double get xl_7;

  /// Xl_8 space
  double get xl_8;

  /// Xl_9 space
  double get xl_9;

  /// Xl_10 space
  double get xl_10;

  /// Xl_11 space
  double get xl_11;
}

/// Semantic tokens for Radii.
abstract interface class ZetaRadiiSemantics {
  /// Primitives used to construct semantic radii
  ZetaPrimitives get primitives;

  /// None radius
  BorderRadius get none;

  /// Minimal radius
  BorderRadius get minimal;

  /// Rounded radius
  BorderRadius get rounded;

  /// Large radius
  BorderRadius get large;

  /// Xl radius
  BorderRadius get xl;

  /// Full radius
  BorderRadius get full;
}

/// The semantic colors for AA
final class ZetaColorAA implements ZetaColorSemantics {
  /// Constructor for ZetaColorAA
  const ZetaColorAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  @override
  ZetaMainColors get main => ZetaMainColorsAA(primitives: primitives);
  @override
  ZetaBorderColors get border => ZetaBorderColorsAA(primitives: primitives);
  @override
  ZetaSurfaceColors get surface => ZetaSurfaceColorsAA(primitives: primitives);
  @override
  ZetaAvatarColors get avatar => ZetaAvatarColorsAA(primitives: primitives);
  @override
  ZetaStateColors get state => ZetaStateColorsAA(primitives: primitives);
  @override
  ZetaDisabledColors get disabled => ZetaDisabledColorsAA(primitives: primitives);
  @override
  ZetaDefaultColors get defaultColor => ZetaDefaultColorsAA(primitives: primitives);
  @override
  ZetaPrimaryColors get primary => ZetaPrimaryColorsAA(primitives: primitives);
  @override
  ZetaSecondaryColors get secondary => ZetaSecondaryColorsAA(primitives: primitives);
  @override
  ZetaPositiveColors get positive => ZetaPositiveColorsAA(primitives: primitives);
  @override
  ZetaNegativeColors get negative => ZetaNegativeColorsAA(primitives: primitives);
  @override
  ZetaInfoColors get info => ZetaInfoColorsAA(primitives: primitives);
  @override
  ZetaInverseColors get inverse => ZetaInverseColorsAA(primitives: primitives);
}

/// The semantic colors for AAA
final class ZetaColorAAA implements ZetaColorSemantics {
  /// Constructor for ZetaColorAAA
  const ZetaColorAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  @override
  ZetaMainColors get main => ZetaMainColorsAAA(primitives: primitives);
  @override
  ZetaBorderColors get border => ZetaBorderColorsAAA(primitives: primitives);
  @override
  ZetaSurfaceColors get surface => ZetaSurfaceColorsAAA(primitives: primitives);
  @override
  ZetaAvatarColors get avatar => ZetaAvatarColorsAAA(primitives: primitives);
  @override
  ZetaStateColors get state => ZetaStateColorsAAA(primitives: primitives);
  @override
  ZetaDisabledColors get disabled => ZetaDisabledColorsAAA(primitives: primitives);
  @override
  ZetaDefaultColors get defaultColor => ZetaDefaultColorsAAA(primitives: primitives);
  @override
  ZetaPrimaryColors get primary => ZetaPrimaryColorsAAA(primitives: primitives);
  @override
  ZetaSecondaryColors get secondary => ZetaSecondaryColorsAAA(primitives: primitives);
  @override
  ZetaPositiveColors get positive => ZetaPositiveColorsAAA(primitives: primitives);
  @override
  ZetaNegativeColors get negative => ZetaNegativeColorsAAA(primitives: primitives);
  @override
  ZetaInfoColors get info => ZetaInfoColorsAAA(primitives: primitives);
  @override
  ZetaInverseColors get inverse => ZetaInverseColorsAAA(primitives: primitives);
}

/// The semantic sizes for AA
final class ZetaSpacingAA implements ZetaSpacingSemantics {
  /// Constructor for ZetaSpacingAA
  const ZetaSpacingAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  /// None space
  @override
  double get none => primitives.x0;

  /// Minimum space
  @override
  double get minimum => primitives.x1;

  /// Small space
  @override
  double get small => primitives.x2;

  /// Medium space
  @override
  double get medium => primitives.x3;

  /// Large space
  @override
  double get large => primitives.x4;

  /// Xl space
  @override
  double get xl => primitives.x5;

  /// Xl_2 space
  @override
  double get xl_2 => primitives.x6;

  /// Xl_3 space
  @override
  double get xl_3 => primitives.x7;

  /// Xl_4 space
  @override
  double get xl_4 => primitives.x8;

  /// Xl_5 space
  @override
  double get xl_5 => primitives.x9;

  /// Xl_6 space
  @override
  double get xl_6 => primitives.x10;

  /// Xl_7 space
  @override
  double get xl_7 => primitives.x11;

  /// Xl_8 space
  @override
  double get xl_8 => primitives.x12;

  /// Xl_9 space
  @override
  double get xl_9 => primitives.x13;

  /// Xl_10 space
  @override
  double get xl_10 => primitives.x14;

  /// Xl_11 space
  @override
  double get xl_11 => primitives.x15;
}

/// The semantic sizes for AAA
final class ZetaSpacingAAA implements ZetaSpacingSemantics {
  /// Constructor for ZetaSpacingAAA
  const ZetaSpacingAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  /// None space
  @override
  double get none => primitives.x0;

  /// Minimum space
  @override
  double get minimum => primitives.x1;

  /// Small space
  @override
  double get small => primitives.x2;

  /// Medium space
  @override
  double get medium => primitives.x3;

  /// Large space
  @override
  double get large => primitives.x4;

  /// Xl space
  @override
  double get xl => primitives.x5;

  /// Xl_2 space
  @override
  double get xl_2 => primitives.x6;

  /// Xl_3 space
  @override
  double get xl_3 => primitives.x7;

  /// Xl_4 space
  @override
  double get xl_4 => primitives.x8;

  /// Xl_5 space
  @override
  double get xl_5 => primitives.x9;

  /// Xl_6 space
  @override
  double get xl_6 => primitives.x10;

  /// Xl_7 space
  @override
  double get xl_7 => primitives.x11;

  /// Xl_8 space
  @override
  double get xl_8 => primitives.x12;

  /// Xl_9 space
  @override
  double get xl_9 => primitives.x13;

  /// Xl_10 space
  @override
  double get xl_10 => primitives.x14;

  /// Xl_11 space
  @override
  double get xl_11 => primitives.x15;
}

/// The semantic radii for AA
final class ZetaRadiiAA implements ZetaRadiiSemantics {
  /// Constructor for ZetaRadiiAA
  const ZetaRadiiAA({required this.primitives});

  /// The primitives for this radii
  @override
  final ZetaPrimitives primitives;

  @override
  BorderRadius get none => BorderRadius.circular(0);
  @override
  BorderRadius get minimal => BorderRadius.all(primitives.s);
  @override
  BorderRadius get rounded => BorderRadius.all(primitives.m);
  @override
  BorderRadius get large => BorderRadius.all(primitives.l);
  @override
  BorderRadius get xl => BorderRadius.all(primitives.xl);
  @override
  BorderRadius get full => BorderRadius.all(primitives.xl_4);
}

/// The semantic radii for AAA
final class ZetaRadiiAAA implements ZetaRadiiSemantics {
  /// Constructor for ZetaRadiiAAA
  const ZetaRadiiAAA({required this.primitives});

  /// The primitives for this radii
  @override
  final ZetaPrimitives primitives;

  @override
  BorderRadius get none => BorderRadius.circular(0);
  @override
  BorderRadius get minimal => BorderRadius.circular(0);
  @override
  BorderRadius get rounded => BorderRadius.circular(0);
  @override
  BorderRadius get large => BorderRadius.circular(0);
  @override
  BorderRadius get xl => BorderRadius.circular(0);
  @override
  BorderRadius get full => BorderRadius.circular(0);
}

/// The semantic tokens for Main colors
final class ZetaMainColorsAA implements ZetaMainColors {
  /// Constructor for MainColorsAA
  const ZetaMainColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get defaultColor => primitives.cool.shade90;
  @override
  Color get subtle => primitives.cool.shade70;
  @override
  Color get light => primitives.cool.shade30;
  @override
  Color get inverse => primitives.cool.shade20;
  @override
  Color get disabled => primitives.cool.shade50;
  @override
  Color get primary => primitives.blue.shade60;
  @override
  Color get secondary => primitives.yellow.shade60;
  @override
  Color get positive => primitives.green.shade60;
  @override
  Color get warning => primitives.orange.shade60;
  @override
  Color get negative => primitives.red.shade60;
  @override
  Color get info => primitives.purple.shade60;
}

/// The semantic tokens for Border colors
final class ZetaBorderColorsAA implements ZetaBorderColors {
  /// Constructor for BorderColorsAA
  const ZetaBorderColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get defaultColor => primitives.cool.shade40;
  @override
  Color get subtle => primitives.cool.shade30;
  @override
  Color get hover => primitives.cool.shade90;
  @override
  Color get selected => primitives.cool.shade90;
  @override
  Color get disabled => primitives.cool.shade20;
  @override
  Color get pure => primitives.pure.shade0;
  @override
  Color get primaryMain => primitives.blue.shade60;
  @override
  Color get primary => primitives.blue.shade50;
  @override
  Color get secondary => primitives.yellow.shade50;
  @override
  Color get positive => primitives.green.shade50;
  @override
  Color get warning => primitives.orange.shade50;
  @override
  Color get negative => primitives.red.shade50;
  @override
  Color get info => primitives.purple.shade50;
}

/// The semantic tokens for Surface colors
final class ZetaSurfaceColorsAA implements ZetaSurfaceColors {
  /// Constructor for SurfaceColorsAA
  const ZetaSurfaceColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get defaultColor => primitives.pure.shade0;
  @override
  Color get defaultInverse => primitives.warm.shade100;
  @override
  Color get hover => primitives.cool.shade20;
  @override
  Color get selected => primitives.blue.shade10;
  @override
  Color get selectedHover => primitives.blue.shade20;
  @override
  Color get disabled => primitives.cool.shade30;
  @override
  Color get cool => primitives.cool.shade10;
  @override
  Color get warm => primitives.warm.shade10;
  @override
  Color get primary => primitives.blue.shade60;
  @override
  Color get primarySubtle => primitives.blue.shade10;
  @override
  Color get secondary => primitives.yellow.shade60;
  @override
  ZetaAvatarColors get avatar => ZetaAvatarColorsAA(primitives: primitives);
}

/// The semantic tokens for Avatar colors
final class ZetaAvatarColorsAA implements ZetaAvatarColors {
  /// Constructor for AvatarColorsAA
  const ZetaAvatarColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get blue => primitives.blue.shade80;
  @override
  Color get green => primitives.green.shade60;
  @override
  Color get orange => primitives.orange.shade50;
  @override
  Color get pink => primitives.pink.shade80;
  @override
  Color get purple => primitives.purple.shade80;
  @override
  Color get teal => primitives.teal.shade80;
  @override
  Color get yellow => primitives.yellow.shade50;
  @override
  Color get secondarySubtle => primitives.yellow.shade10;
  @override
  Color get positive => primitives.green.shade60;
  @override
  Color get positiveSubtle => primitives.green.shade10;
  @override
  Color get warning => primitives.orange.shade60;
  @override
  Color get warningSubtle => primitives.orange.shade10;
  @override
  Color get negative => primitives.red.shade60;
  @override
  Color get negativeSubtle => primitives.red.shade10;
  @override
  Color get info => primitives.purple.shade60;
  @override
  Color get infoSubtle => primitives.purple.shade10;
}

/// The semantic tokens for State colors
final class ZetaStateColorsAA implements ZetaStateColors {
  /// Constructor for StateColorsAA
  const ZetaStateColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  ZetaDisabledColors get disabled => ZetaDisabledColorsAA(primitives: primitives);
}

/// The semantic tokens for Disabled colors
final class ZetaDisabledColorsAA implements ZetaDisabledColors {
  /// Constructor for DisabledColorsAA
  const ZetaDisabledColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get disabled => primitives.cool.shade30;
  @override
  ZetaDefaultColors get defaultColor => ZetaDefaultColorsAA(primitives: primitives);
}

/// The semantic tokens for Default colors
final class ZetaDefaultColorsAA implements ZetaDefaultColors {
  /// Constructor for DefaultColorsAA
  const ZetaDefaultColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.pure.shade0;
  @override
  Color get hover => primitives.cool.shade20;
  @override
  Color get selected => primitives.blue.shade10;
  @override
  Color get focus => primitives.pure.shade0;
  @override
  ZetaPrimaryColors get primary => ZetaPrimaryColorsAA(primitives: primitives);
}

/// The semantic tokens for Primary colors
final class ZetaPrimaryColorsAA implements ZetaPrimaryColors {
  /// Constructor for PrimaryColorsAA
  const ZetaPrimaryColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.blue.shade60;
  @override
  Color get hover => primitives.blue.shade50;
  @override
  Color get selected => primitives.blue.shade70;
  @override
  Color get focus => primitives.blue.shade60;
  @override
  ZetaSecondaryColors get secondary => ZetaSecondaryColorsAA(primitives: primitives);
}

/// The semantic tokens for Secondary colors
final class ZetaSecondaryColorsAA implements ZetaSecondaryColors {
  /// Constructor for SecondaryColorsAA
  const ZetaSecondaryColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.yellow.shade40;
  @override
  Color get hover => primitives.yellow.shade30;
  @override
  Color get selected => primitives.yellow.shade50;
  @override
  Color get focus => primitives.yellow.shade40;
  @override
  ZetaPositiveColors get positive => ZetaPositiveColorsAA(primitives: primitives);
}

/// The semantic tokens for Positive colors
final class ZetaPositiveColorsAA implements ZetaPositiveColors {
  /// Constructor for PositiveColorsAA
  const ZetaPositiveColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.green.shade60;
  @override
  Color get hover => primitives.green.shade50;
  @override
  Color get selected => primitives.green.shade70;
  @override
  Color get focus => primitives.green.shade60;
  @override
  ZetaNegativeColors get negative => ZetaNegativeColorsAA(primitives: primitives);
}

/// The semantic tokens for Negative colors
final class ZetaNegativeColorsAA implements ZetaNegativeColors {
  /// Constructor for NegativeColorsAA
  const ZetaNegativeColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.red.shade60;
  @override
  Color get hover => primitives.red.shade50;
  @override
  Color get selected => primitives.red.shade70;
  @override
  Color get focus => primitives.red.shade60;
  @override
  ZetaInfoColors get info => ZetaInfoColorsAA(primitives: primitives);
}

/// The semantic tokens for Info colors
final class ZetaInfoColorsAA implements ZetaInfoColors {
  /// Constructor for InfoColorsAA
  const ZetaInfoColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.purple.shade60;
  @override
  Color get hover => primitives.purple.shade50;
  @override
  Color get selected => primitives.purple.shade70;
  @override
  Color get focus => primitives.purple.shade60;
  @override
  ZetaInverseColors get inverse => ZetaInverseColorsAA(primitives: primitives);
}

/// The semantic tokens for Inverse colors
final class ZetaInverseColorsAA implements ZetaInverseColors {
  /// Constructor for InverseColorsAA
  const ZetaInverseColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.cool.shade100;
  @override
  Color get hover => primitives.cool.shade90;
  @override
  Color get selected => primitives.cool.shade100;
  @override
  Color get focus => primitives.cool.shade100;
}

/// The semantic tokens for Main colors
final class ZetaMainColorsAAA implements ZetaMainColors {
  /// Constructor for MainColorsAAA
  const ZetaMainColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get defaultColor => primitives.cool.shade100;
  @override
  Color get subtle => primitives.cool.shade90;
  @override
  Color get light => primitives.pure.shade0;
  @override
  Color get inverse => primitives.pure.shade0;
  @override
  Color get disabled => primitives.cool.shade60;
  @override
  Color get primary => primitives.blue.shade80;
  @override
  Color get secondary => primitives.yellow.shade80;
  @override
  Color get positive => primitives.green.shade80;
  @override
  Color get warning => primitives.orange.shade80;
  @override
  Color get negative => primitives.red.shade80;
  @override
  Color get info => primitives.purple.shade80;
}

/// The semantic tokens for Border colors
final class ZetaBorderColorsAAA implements ZetaBorderColors {
  /// Constructor for BorderColorsAAA
  const ZetaBorderColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get defaultColor => primitives.cool.shade100;
  @override
  Color get subtle => primitives.cool.shade80;
  @override
  Color get hover => primitives.cool.shade90;
  @override
  Color get selected => primitives.cool.shade90;
  @override
  Color get disabled => primitives.cool.shade20;
  @override
  Color get pure => primitives.pure.shade0;
  @override
  Color get primaryMain => primitives.blue.shade80;
  @override
  Color get primary => primitives.blue.shade70;
  @override
  Color get secondary => primitives.yellow.shade70;
  @override
  Color get positive => primitives.green.shade70;
  @override
  Color get warning => primitives.orange.shade70;
  @override
  Color get negative => primitives.red.shade70;
  @override
  Color get info => primitives.purple.shade70;
}

/// The semantic tokens for Surface colors
final class ZetaSurfaceColorsAAA implements ZetaSurfaceColors {
  /// Constructor for SurfaceColorsAAA
  const ZetaSurfaceColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get defaultColor => primitives.pure.shade0;
  @override
  Color get defaultInverse => primitives.pure.shade1000;
  @override
  Color get hover => primitives.cool.shade20;
  @override
  Color get selected => primitives.blue.shade10;
  @override
  Color get selectedHover => primitives.blue.shade20;
  @override
  Color get disabled => primitives.cool.shade30;
  @override
  Color get cool => primitives.cool.shade10;
  @override
  Color get warm => primitives.warm.shade10;
  @override
  Color get primary => primitives.blue.shade80;
  @override
  Color get primarySubtle => primitives.blue.shade10;
  @override
  Color get secondary => primitives.yellow.shade80;
  @override
  ZetaAvatarColors get avatar => ZetaAvatarColorsAAA(primitives: primitives);
}

/// The semantic tokens for Avatar colors
final class ZetaAvatarColorsAAA implements ZetaAvatarColors {
  /// Constructor for AvatarColorsAAA
  const ZetaAvatarColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get blue => primitives.blue.shade80;
  @override
  Color get green => primitives.green.shade60;
  @override
  Color get orange => primitives.orange.shade50;
  @override
  Color get pink => primitives.pink.shade80;
  @override
  Color get purple => primitives.purple.shade80;
  @override
  Color get teal => primitives.teal.shade80;
  @override
  Color get yellow => primitives.yellow.shade50;
  @override
  Color get secondarySubtle => primitives.yellow.shade10;
  @override
  Color get positive => primitives.green.shade80;
  @override
  Color get positiveSubtle => primitives.green.shade10;
  @override
  Color get warning => primitives.orange.shade80;
  @override
  Color get warningSubtle => primitives.orange.shade10;
  @override
  Color get negative => primitives.red.shade80;
  @override
  Color get negativeSubtle => primitives.red.shade10;
  @override
  Color get info => primitives.purple.shade80;
  @override
  Color get infoSubtle => primitives.purple.shade10;
}

/// The semantic tokens for State colors
final class ZetaStateColorsAAA implements ZetaStateColors {
  /// Constructor for StateColorsAAA
  const ZetaStateColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  ZetaDisabledColors get disabled => ZetaDisabledColorsAAA(primitives: primitives);
}

/// The semantic tokens for Disabled colors
final class ZetaDisabledColorsAAA implements ZetaDisabledColors {
  /// Constructor for DisabledColorsAAA
  const ZetaDisabledColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get disabled => primitives.cool.shade30;
  @override
  ZetaDefaultColors get defaultColor => ZetaDefaultColorsAAA(primitives: primitives);
}

/// The semantic tokens for Default colors
final class ZetaDefaultColorsAAA implements ZetaDefaultColors {
  /// Constructor for DefaultColorsAAA
  const ZetaDefaultColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.pure.shade0;
  @override
  Color get hover => primitives.cool.shade20;
  @override
  Color get selected => primitives.blue.shade10;
  @override
  Color get focus => primitives.pure.shade0;
  @override
  ZetaPrimaryColors get primary => ZetaPrimaryColorsAAA(primitives: primitives);
}

/// The semantic tokens for Primary colors
final class ZetaPrimaryColorsAAA implements ZetaPrimaryColors {
  /// Constructor for PrimaryColorsAAA
  const ZetaPrimaryColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.blue.shade80;
  @override
  Color get hover => primitives.blue.shade70;
  @override
  Color get selected => primitives.blue.shade90;
  @override
  Color get focus => primitives.blue.shade80;
  @override
  ZetaSecondaryColors get secondary => ZetaSecondaryColorsAAA(primitives: primitives);
}

/// The semantic tokens for Secondary colors
final class ZetaSecondaryColorsAAA implements ZetaSecondaryColors {
  /// Constructor for SecondaryColorsAAA
  const ZetaSecondaryColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.yellow.shade80;
  @override
  Color get hover => primitives.yellow.shade70;
  @override
  Color get selected => primitives.yellow.shade90;
  @override
  Color get focus => primitives.yellow.shade80;
  @override
  ZetaPositiveColors get positive => ZetaPositiveColorsAAA(primitives: primitives);
}

/// The semantic tokens for Positive colors
final class ZetaPositiveColorsAAA implements ZetaPositiveColors {
  /// Constructor for PositiveColorsAAA
  const ZetaPositiveColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.green.shade80;
  @override
  Color get hover => primitives.green.shade70;
  @override
  Color get selected => primitives.green.shade90;
  @override
  Color get focus => primitives.green.shade80;
  @override
  ZetaNegativeColors get negative => ZetaNegativeColorsAAA(primitives: primitives);
}

/// The semantic tokens for Negative colors
final class ZetaNegativeColorsAAA implements ZetaNegativeColors {
  /// Constructor for NegativeColorsAAA
  const ZetaNegativeColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.red.shade80;
  @override
  Color get hover => primitives.red.shade70;
  @override
  Color get selected => primitives.red.shade90;
  @override
  Color get focus => primitives.red.shade80;
  @override
  ZetaInfoColors get info => ZetaInfoColorsAAA(primitives: primitives);
}

/// The semantic tokens for Info colors
final class ZetaInfoColorsAAA implements ZetaInfoColors {
  /// Constructor for InfoColorsAAA
  const ZetaInfoColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.purple.shade80;
  @override
  Color get hover => primitives.purple.shade70;
  @override
  Color get selected => primitives.purple.shade90;
  @override
  Color get focus => primitives.purple.shade80;
  @override
  ZetaInverseColors get inverse => ZetaInverseColorsAAA(primitives: primitives);
}

/// The semantic tokens for Inverse colors
final class ZetaInverseColorsAAA implements ZetaInverseColors {
  /// Constructor for InverseColorsAAA
  const ZetaInverseColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get enabled => primitives.pure.shade1000;
  @override
  Color get hover => primitives.cool.shade90;
  @override
  Color get selected => primitives.pure.shade1000;
  @override
  Color get focus => primitives.pure.shade1000;
}

/// The semantic tokens for Zeta
abstract interface class ZetaSemantics {
  /// Semantic colors
  ZetaColorSemantics get colors;

  /// Semantic sizes
  ZetaSpacingSemantics get size;

  /// Semantic Radii
  ZetaRadiiSemantics get radii;

  /// Primitives for this semantics
  ZetaPrimitives get primitives;
}

/// The semantic tokens for AA
class ZetaSemanticsAA implements ZetaSemantics {
  /// Constructor for [ZetaSemanticsAA]
  ZetaSemanticsAA({required this.primitives})
      : colors = ZetaColorAA(primitives: primitives),
        size = ZetaSpacingAA(primitives: primitives),
        radii = ZetaRadiiAA(primitives: primitives);
  @override
  final ZetaPrimitives primitives;
  @override
  final ZetaColorSemantics colors;
  @override
  final ZetaSpacingSemantics size;
  @override
  final ZetaRadiiSemantics radii;
}

/// The semantic tokens for AAA
class ZetaSemanticsAAA implements ZetaSemantics {
  /// Constructor for [ZetaSemanticsAAA]
  ZetaSemanticsAAA({required this.primitives})
      : colors = ZetaColorAAA(primitives: primitives),
        size = ZetaSpacingAAA(primitives: primitives),
        radii = ZetaRadiiAAA(primitives: primitives);
  @override
  final ZetaPrimitives primitives;
  @override
  final ZetaColorSemantics colors;
  @override
  final ZetaSpacingSemantics size;
  @override
  final ZetaRadiiSemantics radii;
}
