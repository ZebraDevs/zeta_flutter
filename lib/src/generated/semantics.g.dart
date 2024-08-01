import 'package:flutter/material.dart';
import 'primitives.g.dart';

// This file is automatically generated by the zeta repository
// DO NOT MODIFY

/// Semantic tokens for colors.
abstract interface class ZetaColorSemantics {
    /// Main Default color
Color get mainDefault;
/// Subtle color
Color get subtle;
/// Light color
Color get light;
/// Inverse color
Color get inverse;
/// Disabled color
Color get disabled;
/// Primary color
Color get primary;
/// Secondary color
Color get secondary;
/// Positive color
Color get positive;
/// Warning color
Color get warning;
/// Negative color
Color get negative;
/// Info color
Color get info;
/// Border Default color
Color get borderDefault;
/// Border Subtle color
Color get borderSubtle;
/// Border Hover color
Color get borderHover;
/// Border Selected color
Color get borderSelected;
/// Border Disabled color
Color get borderDisabled;
/// Border Pure color
Color get borderPure;
/// Border Primary Main color
Color get borderPrimaryMain;
/// Border Primary color
Color get borderPrimary;
/// Border Secondary color
Color get borderSecondary;
/// Border Positive color
Color get borderPositive;
/// Border Warning color
Color get borderWarning;
/// Border Negative color
Color get borderNegative;
/// Border Info color
Color get borderInfo;
/// Surface Default color
Color get surfaceDefault;
/// Surface Default Inverse color
Color get surfaceDefaultInverse;
/// Surface Hover color
Color get surfaceHover;
/// Surface Selected color
Color get surfaceSelected;
/// Surface Selected Hover color
Color get surfaceSelectedHover;
/// Surface Disabled color
Color get surfaceDisabled;
/// Surface Cool color
Color get surfaceCool;
/// Surface Warm color
Color get surfaceWarm;
/// Surface Primary color
Color get surfacePrimary;
/// Surface Primary Subtle color
Color get surfacePrimarySubtle;
/// Surface Secondary color
Color get surfaceSecondary;
/// Surface Avatar Blue color
Color get surfaceAvatarBlue;
/// Surface Avatar Green color
Color get surfaceAvatarGreen;
/// Surface Avatar Orange color
Color get surfaceAvatarOrange;
/// Surface Avatar Pink color
Color get surfaceAvatarPink;
/// Surface Avatar Purple color
Color get surfaceAvatarPurple;
/// Surface Avatar Teal color
Color get surfaceAvatarTeal;
/// Surface Avatar Yellow color
Color get surfaceAvatarYellow;
/// Surface Secondary Subtle color
Color get surfaceSecondarySubtle;
/// Surface Positive color
Color get surfacePositive;
/// Surface Positive Subtle color
Color get surfacePositiveSubtle;
/// Surface Warning color
Color get surfaceWarning;
/// Surface Warning Subtle color
Color get surfaceWarningSubtle;
/// Surface Negative color
Color get surfaceNegative;
/// Surface Negative Subtle color
Color get surfaceNegativeSubtle;
/// Surface Info color
Color get surfaceInfo;
/// Surface Info Subtle color
Color get surfaceInfoSubtle;
/// State Disabled color
Color get stateDisabled;
/// Default Enabled color
Color get defaultEnabled;
/// Default Hover color
Color get defaultHover;
/// Default Selected color
Color get defaultSelected;
/// Default Focus color
Color get defaultFocus;
/// Primary Enabled color
Color get primaryEnabled;
/// Primary Hover color
Color get primaryHover;
/// Primary Selected color
Color get primarySelected;
/// Primary Focus color
Color get primaryFocus;
/// Secondary Enabled color
Color get secondaryEnabled;
/// Secondary Hover color
Color get secondaryHover;
/// Secondary Selected color
Color get secondarySelected;
/// Secondary Focus color
Color get secondaryFocus;
/// Positive Enabled color
Color get positiveEnabled;
/// Positive Hover color
Color get positiveHover;
/// Positive Selected color
Color get positiveSelected;
/// Positive Focus color
Color get positiveFocus;
/// Negative Enabled color
Color get negativeEnabled;
/// Negative Hover color
Color get negativeHover;
/// Negative Selected color
Color get negativeSelected;
/// Negative Focus color
Color get negativeFocus;
/// Info Enabled color
Color get infoEnabled;
/// Info Hover color
Color get infoHover;
/// Info Selected color
Color get infoSelected;
/// Info Focus color
Color get infoFocus;
/// Inverse Enabled color
Color get inverseEnabled;
/// Inverse Hover color
Color get inverseHover;
/// Inverse Selected color
Color get inverseSelected;
/// Inverse Focus color
Color get inverseFocus;
}

/// Semantic tokens for Size.
abstract interface class ZetaSpacingSemantics {
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
final class ZetaColorAA implements ZetaColorSemantics{
/// Constructor for ZetaColorAA
const ZetaColorAA({required this.primitives});
/// The primitives for this sizes
final ZetaPrimitives primitives;

@override
Color get mainDefault => primitives.cool.shade90;
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
@override
Color get borderDefault => primitives.cool.shade40;
@override
Color get borderSubtle => primitives.cool.shade30;
@override
Color get borderHover => primitives.cool.shade90;
@override
Color get borderSelected => primitives.cool.shade90;
@override
Color get borderDisabled => primitives.cool.shade20;
@override
Color get borderPure => primitives.pure.shade0;
@override
Color get borderPrimaryMain => primitives.blue.shade60;
@override
Color get borderPrimary => primitives.blue.shade50;
@override
Color get borderSecondary => primitives.yellow.shade50;
@override
Color get borderPositive => primitives.green.shade50;
@override
Color get borderWarning => primitives.orange.shade50;
@override
Color get borderNegative => primitives.red.shade50;
@override
Color get borderInfo => primitives.purple.shade50;
@override
Color get surfaceDefault => primitives.pure.shade0;
@override
Color get surfaceDefaultInverse => primitives.warm.shade100;
@override
Color get surfaceHover => primitives.cool.shade20;
@override
Color get surfaceSelected => primitives.blue.shade10;
@override
Color get surfaceSelectedHover => primitives.blue.shade20;
@override
Color get surfaceDisabled => primitives.cool.shade30;
@override
Color get surfaceCool => primitives.cool.shade10;
@override
Color get surfaceWarm => primitives.warm.shade10;
@override
Color get surfacePrimary => primitives.blue.shade60;
@override
Color get surfacePrimarySubtle => primitives.blue.shade10;
@override
Color get surfaceSecondary => primitives.yellow.shade60;
@override
Color get surfaceAvatarBlue => primitives.blue.shade80;
@override
Color get surfaceAvatarGreen => primitives.green.shade60;
@override
Color get surfaceAvatarOrange => primitives.orange.shade50;
@override
Color get surfaceAvatarPink => primitives.pink.shade80;
@override
Color get surfaceAvatarPurple => primitives.purple.shade80;
@override
Color get surfaceAvatarTeal => primitives.teal.shade80;
@override
Color get surfaceAvatarYellow => primitives.yellow.shade50;
@override
Color get surfaceSecondarySubtle => primitives.yellow.shade10;
@override
Color get surfacePositive => primitives.green.shade60;
@override
Color get surfacePositiveSubtle => primitives.green.shade10;
@override
Color get surfaceWarning => primitives.orange.shade60;
@override
Color get surfaceWarningSubtle => primitives.orange.shade10;
@override
Color get surfaceNegative => primitives.red.shade60;
@override
Color get surfaceNegativeSubtle => primitives.red.shade10;
@override
Color get surfaceInfo => primitives.purple.shade60;
@override
Color get surfaceInfoSubtle => primitives.purple.shade10;
@override
Color get stateDisabled => primitives.cool.shade30;
@override
Color get defaultEnabled => primitives.pure.shade0;
@override
Color get defaultHover => primitives.cool.shade20;
@override
Color get defaultSelected => primitives.blue.shade10;
@override
Color get defaultFocus => primitives.pure.shade0;
@override
Color get primaryEnabled => primitives.blue.shade60;
@override
Color get primaryHover => primitives.blue.shade50;
@override
Color get primarySelected => primitives.blue.shade70;
@override
Color get primaryFocus => primitives.blue.shade60;
@override
Color get secondaryEnabled => primitives.yellow.shade40;
@override
Color get secondaryHover => primitives.yellow.shade30;
@override
Color get secondarySelected => primitives.yellow.shade50;
@override
Color get secondaryFocus => primitives.yellow.shade40;
@override
Color get positiveEnabled => primitives.green.shade60;
@override
Color get positiveHover => primitives.green.shade50;
@override
Color get positiveSelected => primitives.green.shade70;
@override
Color get positiveFocus => primitives.green.shade60;
@override
Color get negativeEnabled => primitives.red.shade60;
@override
Color get negativeHover => primitives.red.shade50;
@override
Color get negativeSelected => primitives.red.shade70;
@override
Color get negativeFocus => primitives.red.shade60;
@override
Color get infoEnabled => primitives.purple.shade60;
@override
Color get infoHover => primitives.purple.shade50;
@override
Color get infoSelected => primitives.purple.shade70;
@override
Color get infoFocus => primitives.purple.shade60;
@override
Color get inverseEnabled => primitives.cool.shade100;
@override
Color get inverseHover => primitives.cool.shade90;
@override
Color get inverseSelected => primitives.cool.shade100;
@override
Color get inverseFocus => primitives.cool.shade100;
}
/// The semantic colors for AAA
final class ZetaColorAAA implements ZetaColorSemantics{
/// Constructor for ZetaColorAAA
const ZetaColorAAA({required this.primitives});
/// The primitives for this sizes
final ZetaPrimitives primitives;

@override
Color get mainDefault => primitives.cool.shade100;
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
@override
Color get borderDefault => primitives.cool.shade100;
@override
Color get borderSubtle => primitives.cool.shade80;
@override
Color get borderHover => primitives.cool.shade90;
@override
Color get borderSelected => primitives.cool.shade90;
@override
Color get borderDisabled => primitives.cool.shade20;
@override
Color get borderPure => primitives.pure.shade0;
@override
Color get borderPrimaryMain => primitives.blue.shade80;
@override
Color get borderPrimary => primitives.blue.shade70;
@override
Color get borderSecondary => primitives.yellow.shade70;
@override
Color get borderPositive => primitives.green.shade70;
@override
Color get borderWarning => primitives.orange.shade70;
@override
Color get borderNegative => primitives.red.shade70;
@override
Color get borderInfo => primitives.purple.shade70;
@override
Color get surfaceDefault => primitives.pure.shade0;
@override
Color get surfaceDefaultInverse => primitives.pure.shade1000;
@override
Color get surfaceHover => primitives.cool.shade20;
@override
Color get surfaceSelected => primitives.blue.shade10;
@override
Color get surfaceSelectedHover => primitives.blue.shade20;
@override
Color get surfaceDisabled => primitives.cool.shade30;
@override
Color get surfaceCool => primitives.cool.shade10;
@override
Color get surfaceWarm => primitives.warm.shade10;
@override
Color get surfacePrimary => primitives.blue.shade80;
@override
Color get surfacePrimarySubtle => primitives.blue.shade10;
@override
Color get surfaceSecondary => primitives.yellow.shade80;
@override
Color get surfaceAvatarBlue => primitives.blue.shade80;
@override
Color get surfaceAvatarGreen => primitives.green.shade60;
@override
Color get surfaceAvatarOrange => primitives.orange.shade50;
@override
Color get surfaceAvatarPink => primitives.pink.shade80;
@override
Color get surfaceAvatarPurple => primitives.purple.shade80;
@override
Color get surfaceAvatarTeal => primitives.teal.shade80;
@override
Color get surfaceAvatarYellow => primitives.yellow.shade50;
@override
Color get surfaceSecondarySubtle => primitives.yellow.shade10;
@override
Color get surfacePositive => primitives.green.shade80;
@override
Color get surfacePositiveSubtle => primitives.green.shade10;
@override
Color get surfaceWarning => primitives.orange.shade80;
@override
Color get surfaceWarningSubtle => primitives.orange.shade10;
@override
Color get surfaceNegative => primitives.red.shade80;
@override
Color get surfaceNegativeSubtle => primitives.red.shade10;
@override
Color get surfaceInfo => primitives.purple.shade80;
@override
Color get surfaceInfoSubtle => primitives.purple.shade10;
@override
Color get stateDisabled => primitives.cool.shade30;
@override
Color get defaultEnabled => primitives.pure.shade0;
@override
Color get defaultHover => primitives.cool.shade20;
@override
Color get defaultSelected => primitives.blue.shade10;
@override
Color get defaultFocus => primitives.pure.shade0;
@override
Color get primaryEnabled => primitives.blue.shade80;
@override
Color get primaryHover => primitives.blue.shade70;
@override
Color get primarySelected => primitives.blue.shade90;
@override
Color get primaryFocus => primitives.blue.shade80;
@override
Color get secondaryEnabled => primitives.yellow.shade80;
@override
Color get secondaryHover => primitives.yellow.shade70;
@override
Color get secondarySelected => primitives.yellow.shade90;
@override
Color get secondaryFocus => primitives.yellow.shade80;
@override
Color get positiveEnabled => primitives.green.shade80;
@override
Color get positiveHover => primitives.green.shade70;
@override
Color get positiveSelected => primitives.green.shade90;
@override
Color get positiveFocus => primitives.green.shade80;
@override
Color get negativeEnabled => primitives.red.shade80;
@override
Color get negativeHover => primitives.red.shade70;
@override
Color get negativeSelected => primitives.red.shade90;
@override
Color get negativeFocus => primitives.red.shade80;
@override
Color get infoEnabled => primitives.purple.shade80;
@override
Color get infoHover => primitives.purple.shade70;
@override
Color get infoSelected => primitives.purple.shade90;
@override
Color get infoFocus => primitives.purple.shade80;
@override
Color get inverseEnabled => primitives.pure.shade1000;
@override
Color get inverseHover => primitives.cool.shade90;
@override
Color get inverseSelected => primitives.pure.shade1000;
@override
Color get inverseFocus => primitives.pure.shade1000;
}

/// The semantic sizes for AA
final class ZetaSpacingAA implements ZetaSpacingSemantics{
/// Constructor for ZetaSpacingAA
const ZetaSpacingAA({required this.primitives});
/// The primitives for this sizes
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
final class ZetaSpacingAAA implements ZetaSpacingSemantics{
/// Constructor for ZetaSpacingAAA
const ZetaSpacingAAA({required this.primitives});
/// The primitives for this sizes
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
final class ZetaRadiiAA implements ZetaRadiiSemantics{
/// Constructor for ZetaRadiiAA
const ZetaRadiiAA({required this.primitives});
/// The primitives for this radii
final ZetaPrimitives primitives;

@override
BorderRadius get none=> BorderRadius.circular(0);
@override
BorderRadius get minimal=> BorderRadius.all(primitives.s);
@override
BorderRadius get rounded=> BorderRadius.all(primitives.m);
@override
BorderRadius get large=> BorderRadius.all(primitives.l);
@override
BorderRadius get xl=> BorderRadius.all(primitives.xl);
@override
BorderRadius get full=> BorderRadius.all(primitives.xl_4);}
/// The semantic radii for AAA
final class ZetaRadiiAAA implements ZetaRadiiSemantics{
/// Constructor for ZetaRadiiAAA
const ZetaRadiiAAA({required this.primitives});
/// The primitives for this radii
final ZetaPrimitives primitives;

@override
BorderRadius get none=> BorderRadius.circular(0);
@override
BorderRadius get minimal=> BorderRadius.circular(0);
@override
BorderRadius get rounded=> BorderRadius.circular(0);
@override
BorderRadius get large=> BorderRadius.circular(0);
@override
BorderRadius get xl=> BorderRadius.circular(0);
@override
BorderRadius get full=> BorderRadius.circular(0);}

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
 class ZetaSemanticsAA implements ZetaSemantics{
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
 class ZetaSemanticsAAA implements ZetaSemantics{
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