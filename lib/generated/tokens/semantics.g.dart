import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'primitives.g.dart';

// This file is automatically generated by the zeta repository
// DO NOT MODIFY

/// The semantic tokens for colors
abstract interface class ZetaSemanticColors extends Equatable {
  /// Primitives used to construct semantic colors
  ZetaPrimitives get primitives;

  /// Main Default color
  Color get mainDefault;

  /// Main Subtle color
  Color get mainSubtle;

  /// Main Primary color
  Color get mainPrimary;

  /// Main Secondary color
  Color get mainSecondary;

  /// Main Positive color
  Color get mainPositive;

  /// Main Warning color
  Color get mainWarning;

  /// Main Negative color
  Color get mainNegative;

  /// Main Info color
  Color get mainInfo;

  /// Main Disabled color
  Color get mainDisabled;

  /// Main Light color
  Color get mainLight;

  /// Main Inverse color
  Color get mainInverse;

  /// Border Default color
  Color get borderDefault;

  /// Border Selected color
  Color get borderSelected;

  /// Border Hover color
  Color get borderHover;

  /// Border Subtle color
  Color get borderSubtle;

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

  /// State Disabled Disabled color
  Color get stateDisabledDisabled;

  /// State Default Enabled color
  Color get stateDefaultEnabled;

  /// State Default Hover color
  Color get stateDefaultHover;

  /// State Default Selected color
  Color get stateDefaultSelected;

  /// State Default Focus color
  Color get stateDefaultFocus;

  /// State Primary Enabled color
  Color get statePrimaryEnabled;

  /// State Primary Hover color
  Color get statePrimaryHover;

  /// State Primary Selected color
  Color get statePrimarySelected;

  /// State Primary Focus color
  Color get statePrimaryFocus;

  /// State Secondary Enabled color
  Color get stateSecondaryEnabled;

  /// State Secondary Hover color
  Color get stateSecondaryHover;

  /// State Secondary Selected color
  Color get stateSecondarySelected;

  /// State Secondary Focus color
  Color get stateSecondaryFocus;

  /// State Negative Enabled color
  Color get stateNegativeEnabled;

  /// State Negative Hover color
  Color get stateNegativeHover;

  /// State Negative Selected color
  Color get stateNegativeSelected;

  /// State Negative Focus color
  Color get stateNegativeFocus;

  /// State Info Enabled color
  Color get stateInfoEnabled;

  /// State Info Hover color
  Color get stateInfoHover;

  /// State Info Selected color
  Color get stateInfoSelected;

  /// State Info Focus color
  Color get stateInfoFocus;

  /// State Inverse Enabled color
  Color get stateInverseEnabled;

  /// State Inverse Hover color
  Color get stateInverseHover;

  /// State Inverse Selected color
  Color get stateInverseSelected;

  /// State Inverse Focus color
  Color get stateInverseFocus;

  /// State Positive Enabled color
  Color get statePositiveEnabled;

  /// State Positive Hover color
  Color get statePositiveHover;

  /// State Positive Selected color
  Color get statePositiveSelected;

  /// State Positive Focus color
  Color get statePositiveFocus;
}

/// The semantic tokens for spaces
abstract interface class ZetaSemanticSpaces extends Equatable {
  /// Primitives used to construct semantic spaces
  ZetaPrimitives get primitives;

  /// None spaces
  double get none;

  /// Minimum spaces
  double get minimum;

  /// Small spaces
  double get small;

  /// Medium spaces
  double get medium;

  /// Large spaces
  double get large;

  /// Xl spaces
  double get xl;

  /// Xl_2 spaces
  double get xl_2;

  /// Xl_3 spaces
  double get xl_3;

  /// Xl_4 spaces
  double get xl_4;

  /// Xl_5 spaces
  double get xl_5;

  /// Xl_6 spaces
  double get xl_6;

  /// Xl_7 spaces
  double get xl_7;

  /// Xl_8 spaces
  double get xl_8;

  /// Xl_9 spaces
  double get xl_9;

  /// Xl_10 spaces
  double get xl_10;

  /// Xl_11 spaces
  double get xl_11;
}

/// The semantic tokens for radii
abstract interface class ZetaSemanticRadii extends Equatable {
  /// Primitives used to construct semantic radii
  ZetaPrimitives get primitives;

  /// None radii
  BorderRadius get none;

  /// Minimal radii
  BorderRadius get minimal;

  /// Rounded radii
  BorderRadius get rounded;

  /// Large radii
  BorderRadius get large;

  /// Xl radii
  BorderRadius get xl;

  /// Full radii
  BorderRadius get full;
}

/// The semantic colors for AAA
class ZetaSemanticColorsAAA extends Equatable implements ZetaSemanticColors {
  /// Constructor for [ZetaSemanticColorsAAA]
  const ZetaSemanticColorsAAA({required this.primitives});
  @override
  final ZetaPrimitives primitives;
  @override
  Color get mainDefault => primitives.cool.shade100;
  @override
  Color get mainSubtle => primitives.cool.shade90;
  @override
  Color get mainPrimary => primitives.primary.shade80;
  @override
  Color get mainSecondary => primitives.secondary.shade80;
  @override
  Color get mainPositive => primitives.green.shade80;
  @override
  Color get mainWarning => primitives.orange.shade80;
  @override
  Color get mainNegative => primitives.red.shade80;
  @override
  Color get mainInfo => primitives.purple.shade80;
  @override
  Color get mainDisabled => primitives.cool.shade60;
  @override
  Color get mainLight => primitives.pure.shade0;
  @override
  Color get mainInverse => primitives.pure.shade0;
  @override
  Color get borderDefault => primitives.cool.shade100;
  @override
  Color get borderSelected => primitives.cool.shade90;
  @override
  Color get borderHover => primitives.cool.shade90;
  @override
  Color get borderSubtle => primitives.cool.shade80;
  @override
  Color get borderDisabled => primitives.cool.shade20;
  @override
  Color get borderPure => primitives.pure.shade0;
  @override
  Color get borderPrimaryMain => primitives.primary.shade80;
  @override
  Color get borderPrimary => primitives.primary.shade70;
  @override
  Color get borderSecondary => primitives.secondary.shade70;
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
  Color get surfacePrimary => primitives.primary.shade80;
  @override
  Color get surfacePrimarySubtle => primitives.primary.shade10;
  @override
  Color get surfaceSecondary => primitives.secondary.shade80;
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
  Color get surfaceSecondarySubtle => primitives.secondary.shade10;
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
  Color get stateDisabledDisabled => primitives.cool.shade30;
  @override
  Color get stateDefaultEnabled => primitives.pure.shade0;
  @override
  Color get stateDefaultHover => primitives.cool.shade20;
  @override
  Color get stateDefaultSelected => primitives.blue.shade10;
  @override
  Color get stateDefaultFocus => primitives.pure.shade0;
  @override
  Color get statePrimaryEnabled => primitives.primary.shade80;
  @override
  Color get statePrimaryHover => primitives.primary.shade70;
  @override
  Color get statePrimarySelected => primitives.primary.shade90;
  @override
  Color get statePrimaryFocus => primitives.primary.shade80;
  @override
  Color get stateSecondaryEnabled => primitives.secondary.shade80;
  @override
  Color get stateSecondaryHover => primitives.secondary.shade70;
  @override
  Color get stateSecondarySelected => primitives.secondary.shade90;
  @override
  Color get stateSecondaryFocus => primitives.secondary.shade80;
  @override
  Color get stateNegativeEnabled => primitives.red.shade80;
  @override
  Color get stateNegativeHover => primitives.red.shade70;
  @override
  Color get stateNegativeSelected => primitives.red.shade90;
  @override
  Color get stateNegativeFocus => primitives.red.shade80;
  @override
  Color get stateInfoEnabled => primitives.purple.shade80;
  @override
  Color get stateInfoHover => primitives.purple.shade70;
  @override
  Color get stateInfoSelected => primitives.purple.shade90;
  @override
  Color get stateInfoFocus => primitives.purple.shade80;
  @override
  Color get stateInverseEnabled => primitives.pure.shade1000;
  @override
  Color get stateInverseHover => primitives.cool.shade90;
  @override
  Color get stateInverseSelected => primitives.pure.shade1000;
  @override
  Color get stateInverseFocus => primitives.pure.shade1000;
  @override
  Color get statePositiveEnabled => primitives.green.shade80;
  @override
  Color get statePositiveHover => primitives.green.shade70;
  @override
  Color get statePositiveSelected => primitives.green.shade90;
  @override
  Color get statePositiveFocus => primitives.green.shade80;
  @override
  List<Object?> get props => [
        mainDefault,
        mainSubtle,
        mainPrimary,
        mainSecondary,
        mainPositive,
        mainWarning,
        mainNegative,
        mainInfo,
        mainDisabled,
        mainLight,
        mainInverse,
        borderDefault,
        borderSelected,
        borderHover,
        borderSubtle,
        borderDisabled,
        borderPure,
        borderPrimaryMain,
        borderPrimary,
        borderSecondary,
        borderPositive,
        borderWarning,
        borderNegative,
        borderInfo,
        surfaceDefault,
        surfaceDefaultInverse,
        surfaceHover,
        surfaceSelected,
        surfaceSelectedHover,
        surfaceDisabled,
        surfaceCool,
        surfaceWarm,
        surfacePrimary,
        surfacePrimarySubtle,
        surfaceSecondary,
        surfaceAvatarBlue,
        surfaceAvatarGreen,
        surfaceAvatarOrange,
        surfaceAvatarPink,
        surfaceAvatarPurple,
        surfaceAvatarTeal,
        surfaceAvatarYellow,
        surfaceSecondarySubtle,
        surfacePositive,
        surfacePositiveSubtle,
        surfaceWarning,
        surfaceWarningSubtle,
        surfaceNegative,
        surfaceNegativeSubtle,
        surfaceInfo,
        surfaceInfoSubtle,
        stateDisabledDisabled,
        stateDefaultEnabled,
        stateDefaultHover,
        stateDefaultSelected,
        stateDefaultFocus,
        statePrimaryEnabled,
        statePrimaryHover,
        statePrimarySelected,
        statePrimaryFocus,
        stateSecondaryEnabled,
        stateSecondaryHover,
        stateSecondarySelected,
        stateSecondaryFocus,
        stateNegativeEnabled,
        stateNegativeHover,
        stateNegativeSelected,
        stateNegativeFocus,
        stateInfoEnabled,
        stateInfoHover,
        stateInfoSelected,
        stateInfoFocus,
        stateInverseEnabled,
        stateInverseHover,
        stateInverseSelected,
        stateInverseFocus,
        statePositiveEnabled,
        statePositiveHover,
        statePositiveSelected,
        statePositiveFocus
      ];
}

/// The semantic colors for AA
class ZetaSemanticColorsAA extends Equatable implements ZetaSemanticColors {
  /// Constructor for [ZetaSemanticColorsAA]
  const ZetaSemanticColorsAA({required this.primitives});
  @override
  final ZetaPrimitives primitives;
  @override
  Color get mainDefault => primitives.cool.shade90;
  @override
  Color get mainSubtle => primitives.cool.shade70;
  @override
  Color get mainPrimary => primitives.primary.shade60;
  @override
  Color get mainSecondary => primitives.secondary.shade60;
  @override
  Color get mainPositive => primitives.green.shade60;
  @override
  Color get mainWarning => primitives.orange.shade60;
  @override
  Color get mainNegative => primitives.red.shade60;
  @override
  Color get mainInfo => primitives.purple.shade60;
  @override
  Color get mainDisabled => primitives.cool.shade50;
  @override
  Color get mainLight => primitives.cool.shade30;
  @override
  Color get mainInverse => primitives.cool.shade20;
  @override
  Color get borderDefault => primitives.cool.shade40;
  @override
  Color get borderSelected => primitives.cool.shade90;
  @override
  Color get borderHover => primitives.cool.shade90;
  @override
  Color get borderSubtle => primitives.cool.shade30;
  @override
  Color get borderDisabled => primitives.cool.shade20;
  @override
  Color get borderPure => primitives.pure.shade0;
  @override
  Color get borderPrimaryMain => primitives.primary.shade60;
  @override
  Color get borderPrimary => primitives.primary.shade50;
  @override
  Color get borderSecondary => primitives.secondary.shade50;
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
  Color get surfacePrimary => primitives.primary.shade60;
  @override
  Color get surfacePrimarySubtle => primitives.primary.shade10;
  @override
  Color get surfaceSecondary => primitives.secondary.shade60;
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
  Color get surfaceSecondarySubtle => primitives.secondary.shade10;
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
  Color get stateDisabledDisabled => primitives.cool.shade30;
  @override
  Color get stateDefaultEnabled => primitives.pure.shade0;
  @override
  Color get stateDefaultHover => primitives.cool.shade20;
  @override
  Color get stateDefaultSelected => primitives.blue.shade10;
  @override
  Color get stateDefaultFocus => primitives.pure.shade0;
  @override
  Color get statePrimaryEnabled => primitives.primary.shade60;
  @override
  Color get statePrimaryHover => primitives.primary.shade50;
  @override
  Color get statePrimarySelected => primitives.primary.shade70;
  @override
  Color get statePrimaryFocus => primitives.primary.shade60;
  @override
  Color get stateSecondaryEnabled => primitives.secondary.shade40;
  @override
  Color get stateSecondaryHover => primitives.secondary.shade30;
  @override
  Color get stateSecondarySelected => primitives.secondary.shade50;
  @override
  Color get stateSecondaryFocus => primitives.secondary.shade40;
  @override
  Color get stateNegativeEnabled => primitives.red.shade60;
  @override
  Color get stateNegativeHover => primitives.red.shade50;
  @override
  Color get stateNegativeSelected => primitives.red.shade70;
  @override
  Color get stateNegativeFocus => primitives.red.shade60;
  @override
  Color get stateInfoEnabled => primitives.purple.shade60;
  @override
  Color get stateInfoHover => primitives.purple.shade50;
  @override
  Color get stateInfoSelected => primitives.purple.shade70;
  @override
  Color get stateInfoFocus => primitives.purple.shade60;
  @override
  Color get stateInverseEnabled => primitives.cool.shade100;
  @override
  Color get stateInverseHover => primitives.cool.shade90;
  @override
  Color get stateInverseSelected => primitives.cool.shade100;
  @override
  Color get stateInverseFocus => primitives.cool.shade100;
  @override
  Color get statePositiveEnabled => primitives.green.shade60;
  @override
  Color get statePositiveHover => primitives.green.shade50;
  @override
  Color get statePositiveSelected => primitives.green.shade70;
  @override
  Color get statePositiveFocus => primitives.green.shade60;
  @override
  List<Object?> get props => [
        mainDefault,
        mainSubtle,
        mainPrimary,
        mainSecondary,
        mainPositive,
        mainWarning,
        mainNegative,
        mainInfo,
        mainDisabled,
        mainLight,
        mainInverse,
        borderDefault,
        borderSelected,
        borderHover,
        borderSubtle,
        borderDisabled,
        borderPure,
        borderPrimaryMain,
        borderPrimary,
        borderSecondary,
        borderPositive,
        borderWarning,
        borderNegative,
        borderInfo,
        surfaceDefault,
        surfaceDefaultInverse,
        surfaceHover,
        surfaceSelected,
        surfaceSelectedHover,
        surfaceDisabled,
        surfaceCool,
        surfaceWarm,
        surfacePrimary,
        surfacePrimarySubtle,
        surfaceSecondary,
        surfaceAvatarBlue,
        surfaceAvatarGreen,
        surfaceAvatarOrange,
        surfaceAvatarPink,
        surfaceAvatarPurple,
        surfaceAvatarTeal,
        surfaceAvatarYellow,
        surfaceSecondarySubtle,
        surfacePositive,
        surfacePositiveSubtle,
        surfaceWarning,
        surfaceWarningSubtle,
        surfaceNegative,
        surfaceNegativeSubtle,
        surfaceInfo,
        surfaceInfoSubtle,
        stateDisabledDisabled,
        stateDefaultEnabled,
        stateDefaultHover,
        stateDefaultSelected,
        stateDefaultFocus,
        statePrimaryEnabled,
        statePrimaryHover,
        statePrimarySelected,
        statePrimaryFocus,
        stateSecondaryEnabled,
        stateSecondaryHover,
        stateSecondarySelected,
        stateSecondaryFocus,
        stateNegativeEnabled,
        stateNegativeHover,
        stateNegativeSelected,
        stateNegativeFocus,
        stateInfoEnabled,
        stateInfoHover,
        stateInfoSelected,
        stateInfoFocus,
        stateInverseEnabled,
        stateInverseHover,
        stateInverseSelected,
        stateInverseFocus,
        statePositiveEnabled,
        statePositiveHover,
        statePositiveSelected,
        statePositiveFocus
      ];
}

/// The semantic spaces for AAA
class ZetaSemanticSpacesAAA extends Equatable implements ZetaSemanticSpaces {
  /// Constructor for [ZetaSemanticSpacesAAA]
  const ZetaSemanticSpacesAAA({required this.primitives});
  @override
  final ZetaPrimitives primitives;
  @override
  double get none => primitives.x0;
  @override
  double get minimum => primitives.x1;
  @override
  double get small => primitives.x2;
  @override
  double get medium => primitives.x3;
  @override
  double get large => primitives.x4;
  @override
  double get xl => primitives.x5;
  @override
  double get xl_2 => primitives.x6;
  @override
  double get xl_3 => primitives.x7;
  @override
  double get xl_4 => primitives.x8;
  @override
  double get xl_5 => primitives.x9;
  @override
  double get xl_6 => primitives.x10;
  @override
  double get xl_7 => primitives.x11;
  @override
  double get xl_8 => primitives.x12;
  @override
  double get xl_9 => primitives.x13;
  @override
  double get xl_10 => primitives.x14;
  @override
  double get xl_11 => primitives.x15;
  @override
  List<Object?> get props =>
      [none, minimum, small, medium, large, xl, xl_2, xl_3, xl_4, xl_5, xl_6, xl_7, xl_8, xl_9, xl_10, xl_11];
}

/// The semantic spaces for AA
class ZetaSemanticSpacesAA extends Equatable implements ZetaSemanticSpaces {
  /// Constructor for [ZetaSemanticSpacesAA]
  const ZetaSemanticSpacesAA({required this.primitives});
  @override
  final ZetaPrimitives primitives;
  @override
  double get none => primitives.x0;
  @override
  double get minimum => primitives.x1;
  @override
  double get small => primitives.x2;
  @override
  double get medium => primitives.x3;
  @override
  double get large => primitives.x4;
  @override
  double get xl => primitives.x5;
  @override
  double get xl_2 => primitives.x6;
  @override
  double get xl_3 => primitives.x7;
  @override
  double get xl_4 => primitives.x8;
  @override
  double get xl_5 => primitives.x9;
  @override
  double get xl_6 => primitives.x10;
  @override
  double get xl_7 => primitives.x11;
  @override
  double get xl_8 => primitives.x12;
  @override
  double get xl_9 => primitives.x13;
  @override
  double get xl_10 => primitives.x14;
  @override
  double get xl_11 => primitives.x15;
  @override
  List<Object?> get props =>
      [none, minimum, small, medium, large, xl, xl_2, xl_3, xl_4, xl_5, xl_6, xl_7, xl_8, xl_9, xl_10, xl_11];
}

/// The semantic radii for AAA
class ZetaSemanticRadiiAAA extends Equatable implements ZetaSemanticRadii {
  /// Constructor for [ZetaSemanticRadiiAAA]
  const ZetaSemanticRadiiAAA({required this.primitives});
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
  @override
  List<Object?> get props => [none, minimal, rounded, large, xl, full];
}

/// The semantic radii for AA
class ZetaSemanticRadiiAA extends Equatable implements ZetaSemanticRadii {
  /// Constructor for [ZetaSemanticRadiiAA]
  const ZetaSemanticRadiiAA({required this.primitives});
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
  @override
  List<Object?> get props => [none, minimal, rounded, large, xl, full];
}

/// The semantic tokens for Zeta
abstract interface class ZetaSemantics {
  /// Semantic colors
  ZetaSemanticColors get colors;

  /// Semantic sizes
  ZetaSemanticSpaces get size;

  /// Semantic Radii
  ZetaSemanticRadii get radii;

  /// Primitives for this semantics
  ZetaPrimitives get primitives;
}

/// The semantic tokens for AAA
class ZetaSemanticsAAA implements ZetaSemantics {
  /// Constructor for [ZetaSemanticsAAA]
  ZetaSemanticsAAA({required this.primitives})
      : colors = ZetaSemanticColorsAAA(primitives: primitives),
        size = ZetaSemanticSpacesAAA(primitives: primitives),
        radii = ZetaSemanticRadiiAAA(primitives: primitives);
  @override
  final ZetaPrimitives primitives;
  @override
  final ZetaSemanticColors colors;
  @override
  final ZetaSemanticSpaces size;
  @override
  final ZetaSemanticRadii radii;
}

/// The semantic tokens for AA
class ZetaSemanticsAA implements ZetaSemantics {
  /// Constructor for [ZetaSemanticsAA]
  ZetaSemanticsAA({required this.primitives})
      : colors = ZetaSemanticColorsAA(primitives: primitives),
        size = ZetaSemanticSpacesAA(primitives: primitives),
        radii = ZetaSemanticRadiiAA(primitives: primitives);
  @override
  final ZetaPrimitives primitives;
  @override
  final ZetaSemanticColors colors;
  @override
  final ZetaSemanticSpaces size;
  @override
  final ZetaSemanticRadii radii;
}
