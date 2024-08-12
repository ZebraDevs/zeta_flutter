import 'package:flutter/material.dart';
import 'primitives.g.dart';

// This file is automatically generated by the zeta repository
// DO NOT MODIFY

/// The semantic tokens for
abstract interface class ZetaSemanticColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Main
  ZetaSemanticMainColors get main;

  /// Border
  ZetaSemanticBorderColors get border;

  /// Surface
  ZetaSemanticSurfaceColors get surface;

  /// State
  ZetaSemanticStateColors get state;
}

/// The semantic tokens for Main
abstract interface class ZetaSemanticMainColors {
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

/// The semantic tokens for Border
abstract interface class ZetaSemanticBorderColors {
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

/// The semantic tokens for Surface
abstract interface class ZetaSemanticSurfaceColors {
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
  ZetaSemanticAvatarColors get avatar;

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

/// The semantic tokens for Avatar
abstract interface class ZetaSemanticAvatarColors {
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
}

/// The semantic tokens for State
abstract interface class ZetaSemanticStateColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Disabled
  ZetaSemanticDisabledColors get disabled;

  /// Default
  ZetaSemanticDefaultColors get defaultColor;

  /// Primary
  ZetaSemanticPrimaryColors get primary;

  /// Secondary
  ZetaSemanticSecondaryColors get secondary;

  /// Positive
  ZetaSemanticPositiveColors get positive;

  /// Negative
  ZetaSemanticNegativeColors get negative;

  /// Info
  ZetaSemanticInfoColors get info;

  ///  Inverse
  ZetaSemanticInverseColors get inverse;
}

/// The semantic tokens for Disabled
abstract interface class ZetaSemanticDisabledColors {
  /// The primitives for the colors
  ZetaPrimitives get primitives;

  /// Disabled
  Color get disabled;
}

/// The semantic tokens for Default
abstract interface class ZetaSemanticDefaultColors {
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

/// The semantic tokens for Primary
abstract interface class ZetaSemanticPrimaryColors {
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

/// The semantic tokens for Secondary
abstract interface class ZetaSemanticSecondaryColors {
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

/// The semantic tokens for Positive
abstract interface class ZetaSemanticPositiveColors {
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

/// The semantic tokens for Negative
abstract interface class ZetaSemanticNegativeColors {
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

/// The semantic tokens for Info
abstract interface class ZetaSemanticInfoColors {
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

/// The semantic tokens for Inverse
abstract interface class ZetaSemanticInverseColors {
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

/// Implementation of ZetaSemanticColors
final class ZetaSemanticColorsAA implements ZetaSemanticColors {
  /// Constructor for ZetaSemanticColorsAA
  const ZetaSemanticColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  /// Main
  @override
  ZetaSemanticMainColors get main => ZetaSemanticMainColorsAA(primitives: primitives);

  /// Border
  @override
  ZetaSemanticBorderColors get border => ZetaSemanticBorderColorsAA(primitives: primitives);

  /// Surface
  @override
  ZetaSemanticSurfaceColors get surface => ZetaSemanticSurfaceColorsAA(primitives: primitives);

  /// State
  @override
  ZetaSemanticStateColors get state => ZetaSemanticStateColorsAA(primitives: primitives);
}

/// Implementation of ZetaSemanticMainColors
final class ZetaSemanticMainColorsAA implements ZetaSemanticMainColors {
  /// Constructor for ZetaSemanticMainColorsAA
  const ZetaSemanticMainColorsAA({required this.primitives});

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

/// Implementation of ZetaSemanticBorderColors
final class ZetaSemanticBorderColorsAA implements ZetaSemanticBorderColors {
  /// Constructor for ZetaSemanticBorderColorsAA
  const ZetaSemanticBorderColorsAA({required this.primitives});

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

/// Implementation of ZetaSemanticSurfaceColors
final class ZetaSemanticSurfaceColorsAA implements ZetaSemanticSurfaceColors {
  /// Constructor for ZetaSemanticSurfaceColorsAA
  const ZetaSemanticSurfaceColorsAA({required this.primitives});

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

  /// Avatar
  @override
  ZetaSemanticAvatarColors get avatar => ZetaSemanticAvatarColorsAA(primitives: primitives);
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

/// Implementation of ZetaSemanticAvatarColors
final class ZetaSemanticAvatarColorsAA implements ZetaSemanticAvatarColors {
  /// Constructor for ZetaSemanticAvatarColorsAA
  const ZetaSemanticAvatarColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticStateColors
final class ZetaSemanticStateColorsAA implements ZetaSemanticStateColors {
  /// Constructor for ZetaSemanticStateColorsAA
  const ZetaSemanticStateColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  /// Disabled
  @override
  ZetaSemanticDisabledColors get disabled => ZetaSemanticDisabledColorsAA(primitives: primitives);

  /// Default
  @override
  ZetaSemanticDefaultColors get defaultColor => ZetaSemanticDefaultColorsAA(primitives: primitives);

  /// Primary
  @override
  ZetaSemanticPrimaryColors get primary => ZetaSemanticPrimaryColorsAA(primitives: primitives);

  /// Secondary
  @override
  ZetaSemanticSecondaryColors get secondary => ZetaSemanticSecondaryColorsAA(primitives: primitives);

  /// Positive
  @override
  ZetaSemanticPositiveColors get positive => ZetaSemanticPositiveColorsAA(primitives: primitives);

  /// Negative
  @override
  ZetaSemanticNegativeColors get negative => ZetaSemanticNegativeColorsAA(primitives: primitives);

  /// Info
  @override
  ZetaSemanticInfoColors get info => ZetaSemanticInfoColorsAA(primitives: primitives);

  ///  Inverse
  @override
  ZetaSemanticInverseColors get inverse => ZetaSemanticInverseColorsAA(primitives: primitives);
}

/// Implementation of ZetaSemanticDisabledColors
final class ZetaSemanticDisabledColorsAA implements ZetaSemanticDisabledColors {
  /// Constructor for ZetaSemanticDisabledColorsAA
  const ZetaSemanticDisabledColorsAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get disabled => primitives.cool.shade30;
}

/// Implementation of ZetaSemanticDefaultColors
final class ZetaSemanticDefaultColorsAA implements ZetaSemanticDefaultColors {
  /// Constructor for ZetaSemanticDefaultColorsAA
  const ZetaSemanticDefaultColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticPrimaryColors
final class ZetaSemanticPrimaryColorsAA implements ZetaSemanticPrimaryColors {
  /// Constructor for ZetaSemanticPrimaryColorsAA
  const ZetaSemanticPrimaryColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticSecondaryColors
final class ZetaSemanticSecondaryColorsAA implements ZetaSemanticSecondaryColors {
  /// Constructor for ZetaSemanticSecondaryColorsAA
  const ZetaSemanticSecondaryColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticPositiveColors
final class ZetaSemanticPositiveColorsAA implements ZetaSemanticPositiveColors {
  /// Constructor for ZetaSemanticPositiveColorsAA
  const ZetaSemanticPositiveColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticNegativeColors
final class ZetaSemanticNegativeColorsAA implements ZetaSemanticNegativeColors {
  /// Constructor for ZetaSemanticNegativeColorsAA
  const ZetaSemanticNegativeColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticInfoColors
final class ZetaSemanticInfoColorsAA implements ZetaSemanticInfoColors {
  /// Constructor for ZetaSemanticInfoColorsAA
  const ZetaSemanticInfoColorsAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticInverseColors
final class ZetaSemanticInverseColorsAA implements ZetaSemanticInverseColors {
  /// Constructor for ZetaSemanticInverseColorsAA
  const ZetaSemanticInverseColorsAA({required this.primitives});

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

/// Implementation of ZetaSemanticColors
final class ZetaSemanticColorsAAA implements ZetaSemanticColors {
  /// Constructor for ZetaSemanticColorsAAA
  const ZetaSemanticColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  /// Main
  @override
  ZetaSemanticMainColors get main => ZetaSemanticMainColorsAAA(primitives: primitives);

  /// Border
  @override
  ZetaSemanticBorderColors get border => ZetaSemanticBorderColorsAAA(primitives: primitives);

  /// Surface
  @override
  ZetaSemanticSurfaceColors get surface => ZetaSemanticSurfaceColorsAAA(primitives: primitives);

  /// State
  @override
  ZetaSemanticStateColors get state => ZetaSemanticStateColorsAAA(primitives: primitives);
}

/// Implementation of ZetaSemanticMainColors
final class ZetaSemanticMainColorsAAA implements ZetaSemanticMainColors {
  /// Constructor for ZetaSemanticMainColorsAAA
  const ZetaSemanticMainColorsAAA({required this.primitives});

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

/// Implementation of ZetaSemanticBorderColors
final class ZetaSemanticBorderColorsAAA implements ZetaSemanticBorderColors {
  /// Constructor for ZetaSemanticBorderColorsAAA
  const ZetaSemanticBorderColorsAAA({required this.primitives});

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

/// Implementation of ZetaSemanticSurfaceColors
final class ZetaSemanticSurfaceColorsAAA implements ZetaSemanticSurfaceColors {
  /// Constructor for ZetaSemanticSurfaceColorsAAA
  const ZetaSemanticSurfaceColorsAAA({required this.primitives});

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

  /// Avatar
  @override
  ZetaSemanticAvatarColors get avatar => ZetaSemanticAvatarColorsAAA(primitives: primitives);
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

/// Implementation of ZetaSemanticAvatarColors
final class ZetaSemanticAvatarColorsAAA implements ZetaSemanticAvatarColors {
  /// Constructor for ZetaSemanticAvatarColorsAAA
  const ZetaSemanticAvatarColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticStateColors
final class ZetaSemanticStateColorsAAA implements ZetaSemanticStateColors {
  /// Constructor for ZetaSemanticStateColorsAAA
  const ZetaSemanticStateColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;

  /// Disabled
  @override
  ZetaSemanticDisabledColors get disabled => ZetaSemanticDisabledColorsAAA(primitives: primitives);

  /// Default
  @override
  ZetaSemanticDefaultColors get defaultColor => ZetaSemanticDefaultColorsAAA(primitives: primitives);

  /// Primary
  @override
  ZetaSemanticPrimaryColors get primary => ZetaSemanticPrimaryColorsAAA(primitives: primitives);

  /// Secondary
  @override
  ZetaSemanticSecondaryColors get secondary => ZetaSemanticSecondaryColorsAAA(primitives: primitives);

  /// Positive
  @override
  ZetaSemanticPositiveColors get positive => ZetaSemanticPositiveColorsAAA(primitives: primitives);

  /// Negative
  @override
  ZetaSemanticNegativeColors get negative => ZetaSemanticNegativeColorsAAA(primitives: primitives);

  /// Info
  @override
  ZetaSemanticInfoColors get info => ZetaSemanticInfoColorsAAA(primitives: primitives);

  ///  Inverse
  @override
  ZetaSemanticInverseColors get inverse => ZetaSemanticInverseColorsAAA(primitives: primitives);
}

/// Implementation of ZetaSemanticDisabledColors
final class ZetaSemanticDisabledColorsAAA implements ZetaSemanticDisabledColors {
  /// Constructor for ZetaSemanticDisabledColorsAAA
  const ZetaSemanticDisabledColorsAAA({required this.primitives});

  /// The primitives for this sizes
  @override
  final ZetaPrimitives primitives;
  @override
  Color get disabled => primitives.cool.shade30;
}

/// Implementation of ZetaSemanticDefaultColors
final class ZetaSemanticDefaultColorsAAA implements ZetaSemanticDefaultColors {
  /// Constructor for ZetaSemanticDefaultColorsAAA
  const ZetaSemanticDefaultColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticPrimaryColors
final class ZetaSemanticPrimaryColorsAAA implements ZetaSemanticPrimaryColors {
  /// Constructor for ZetaSemanticPrimaryColorsAAA
  const ZetaSemanticPrimaryColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticSecondaryColors
final class ZetaSemanticSecondaryColorsAAA implements ZetaSemanticSecondaryColors {
  /// Constructor for ZetaSemanticSecondaryColorsAAA
  const ZetaSemanticSecondaryColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticPositiveColors
final class ZetaSemanticPositiveColorsAAA implements ZetaSemanticPositiveColors {
  /// Constructor for ZetaSemanticPositiveColorsAAA
  const ZetaSemanticPositiveColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticNegativeColors
final class ZetaSemanticNegativeColorsAAA implements ZetaSemanticNegativeColors {
  /// Constructor for ZetaSemanticNegativeColorsAAA
  const ZetaSemanticNegativeColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticInfoColors
final class ZetaSemanticInfoColorsAAA implements ZetaSemanticInfoColors {
  /// Constructor for ZetaSemanticInfoColorsAAA
  const ZetaSemanticInfoColorsAAA({required this.primitives});

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
}

/// Implementation of ZetaSemanticInverseColors
final class ZetaSemanticInverseColorsAAA implements ZetaSemanticInverseColors {
  /// Constructor for ZetaSemanticInverseColorsAAA
  const ZetaSemanticInverseColorsAAA({required this.primitives});

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

/// Zeta Semantic colors object.
///
/// Note: This typedef is used to make object generation easier.
typedef ZetaColorSemantics = ZetaSemanticColors;

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
      : colors = ZetaSemanticColorsAA(primitives: primitives),
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
      : colors = ZetaSemanticColorsAAA(primitives: primitives),
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
