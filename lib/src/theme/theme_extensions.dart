import 'package:flutter/material.dart';

import 'color_scheme.dart';
import 'color_swatch.dart';
import 'colors.dart';
import 'colors_base.dart';
import 'contrast.dart';

enum _ZetaColorProperties {
  primarySwatch,
  secondarySwatch,
  cool,
  warm,
  shadow,
  textDefault,
  textSubtle,
  pink,
  teal,
  yellow,
  purple,
  orange,
  red,
  green,
  blue,
  surfaceSelected,
  surfaceSelectedHovered,
  surfaceHovered,
  surfaceDisabled,
  surfaceTertiary,
  surfaceSecondary,
  surfacePrimary,
  linkVisited,
  link,
  borderSelected,
  borderDisabled,
  borderSubtle,
  borderDefault,
  textInverse,
  textDisabled,
}

/// Custom extension on ColorScheme which makes  [ZetaColors] available through theme context.
///
/// A customizable, token-based color palette, adapting Zeta colors to Flutter's colorScheme.
extension ZetaColorGetters on ColorScheme {
  ZetaColorScheme? get _resolve => this is ZetaColorScheme ? this as ZetaColorScheme : null;

  /// Represents the Zeta accessibility standard.
  ZetaContrast get contrast => _resolve?.zetaColors.contrast ?? ZetaContrast.aa;

  /// Primary color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get primarySwatch =>
      _resolve?.zetaColors.primary ?? _resolveDefault(_ZetaColorProperties.primarySwatch);

  /// Secondary color used in app.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// Maps to [ColorScheme.secondary].
  ZetaColorSwatch get secondarySwatch =>
      _resolve?.zetaColors.secondary ?? _resolveDefault(_ZetaColorProperties.secondarySwatch);

  /// Cool grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyCool].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get cool => _resolve?.zetaColors.cool ?? _resolveDefault(_ZetaColorProperties.cool);

  /// Warm grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyWarm].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get warm => _resolve?.zetaColors.warm ?? _resolveDefault(_ZetaColorProperties.warm);

  /// Shadow color.
  ///
  /// Maps to [ColorScheme.shadow].
  ///
  /// Defaults to #49505E at 10% opacity.
  Color get shadow => _resolve?.zetaColors.shadow ?? _resolveDefault(_ZetaColorProperties.shadow);

  /// Cool grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyCool].
  ///
  /// {@macro zeta-color-dark}
  Color get textDefault => _resolve?.zetaColors.textDefault ?? _resolveDefault(_ZetaColorProperties.textDefault);

  /// Subtle text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onBackground].
  ///
  /// {@macro zeta-color-dark}
  Color get textSubtle => _resolve?.zetaColors.textSubtle ?? _resolveDefault(_ZetaColorProperties.textSubtle);

  /// Disabled text / icon color.
  ///
  /// Defaults to `ZetaColors.cool.50`.
  ///
  /// {@macro zeta-color-dark}
  Color get textDisabled => _resolve?.zetaColors.textDisabled ?? _resolveDefault(_ZetaColorProperties.textDisabled);

  /// Inverse text / icon color.
  ///
  /// Used for text that is not on [ColorScheme.background] or [ThemeData.scaffoldBackgroundColor].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get textInverse => _resolve?.zetaColors.textInverse ?? _resolveDefault(_ZetaColorProperties.textInverse);

  // Border variants.

  /// Default border color.
  ///
  /// Defaults to `ZetaColors.warm.50`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderDefault => _resolve?.zetaColors.borderDefault ?? _resolveDefault(_ZetaColorProperties.borderDefault);

  /// Subtle border color.
  ///
  /// `ZetaColors.cool.40`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderSubtle => _resolve?.zetaColors.borderSubtle ?? _resolveDefault(_ZetaColorProperties.borderSubtle);

  /// Disabled border color.
  ///
  /// Defaults to `ZetaColors.cool.30`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderDisabled =>
      _resolve?.zetaColors.borderDisabled ?? _resolveDefault(_ZetaColorProperties.borderDisabled);

  /// Selected border color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderSelected =>
      _resolve?.zetaColors.borderSelected ?? _resolveDefault(_ZetaColorProperties.borderSelected);

  // Links

  /// Link color.
  ///
  /// Defaults to [ZetaColorBase.linkLight] or [ZetaColorBase.linkDark].
  Color get link => _resolve?.zetaColors.link ?? _resolveDefault(_ZetaColorProperties.link);

  /// Link color.
  ///
  /// Defaults to [ZetaColorBase.linkVisitedLight] or [ZetaColorBase.linkVisitedDark].
  Color get linkVisited => _resolve?.zetaColors.linkVisited ?? _resolveDefault(_ZetaColorProperties.linkVisited);

  // Backdrop colors.

  /// Surface color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// * Light mode: `ZetaColors.black`
  /// * Dark mode: `ZetaColors.white`.
  Color get surfacePrimary =>
      _resolve?.zetaColors.surfacePrimary ?? _resolveDefault(_ZetaColorProperties.surfacePrimary);

  /// Secondary surface color.
  ///
  ///
  /// * `ZetaColors.cool.10`.
  Color get surfaceSecondary =>
      _resolve?.zetaColors.surfaceSecondary ?? _resolveDefault(_ZetaColorProperties.surfaceSecondary);

  /// Tertiary surface color.
  ///
  /// Maps to [ColorScheme.background] and [ThemeData.scaffoldBackgroundColor]
  ///
  /// * `ZetaColors.warm.10`.
  Color get surfaceTertiary =>
      _resolve?.zetaColors.surfaceTertiary ?? _resolveDefault(_ZetaColorProperties.surfaceTertiary);

  /// Disabled surface color.
  ///
  /// Defaults to `ZetaColors.cool.30`.
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceDisabled =>
      _resolve?.zetaColors.surfaceDisabled ?? _resolveDefault(_ZetaColorProperties.surfaceDisabled);

  /// Hover surface color.
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceHovered =>
      _resolve?.zetaColors.surfaceHovered ?? _resolveDefault(_ZetaColorProperties.surfaceHovered);

  /// Selected hover surface color.
  ///
  /// Defaults to: `ZetaColors.blue.20`.
  Color get surfaceSelectedHovered =>
      _resolve?.zetaColors.surfaceSelectedHovered ?? _resolveDefault(_ZetaColorProperties.surfaceSelectedHovered);

  /// Selected surface color.
  ///
  /// Defaults to: `ZetaColors.blue.10`.
  Color get surfaceSelected =>
      _resolve?.zetaColors.surfaceSelected ?? _resolveDefault(_ZetaColorProperties.surfaceSelected);

  /// Blue color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get blue => _resolve?.zetaColors.blue ?? _resolveDefault(_ZetaColorProperties.blue);

  /// Green color swatch.
  ///
  /// Defaults to [ZetaColorBase.green].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get green => _resolve?.zetaColors.green ?? _resolveDefault(_ZetaColorProperties.green);

  /// Red color swatch.
  ///
  /// Defaults to [ZetaColorBase.red].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get red => _resolve?.zetaColors.red ?? _resolveDefault(_ZetaColorProperties.red);

  /// Orange color swatch.
  ///
  /// Defaults to [ZetaColorBase.orange].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get orange => _resolve?.zetaColors.orange ?? _resolveDefault(_ZetaColorProperties.orange);

  /// Purple color swatch.
  ///
  /// Defaults to [ZetaColorBase.purple].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get purple => _resolve?.zetaColors.purple ?? _resolveDefault(_ZetaColorProperties.purple);

  /// Yellow color swatch.
  ///
  /// Defaults to [ZetaColorBase.yellow].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get yellow => _resolve?.zetaColors.yellow ?? _resolveDefault(_ZetaColorProperties.yellow);

  /// Teal color swatch.
  ///
  /// Defaults to [ZetaColorBase.teal].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get teal => _resolve?.zetaColors.teal ?? _resolveDefault(_ZetaColorProperties.teal);

  /// Pink color swatch.
  ///
  /// Defaults to [ZetaColorBase.pink].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get pink => _resolve?.zetaColors.pink ?? _resolveDefault(_ZetaColorProperties.pink);

  // Alert Colors

  /// Green positive color.
  ///
  /// Defaults to `ZetaColors.green.60` in AA system.
  /// Defaults to `ZetaColors.green.80` in AAA system.
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get positive => green;

  /// Red negative color.
  ///
  /// Defaults to `ZetaColors.red.60` in AA system.
  /// Defaults to `ZetaColors.red.80` in AAA system.
  ///
  /// Maps to [ColorScheme.error].
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get negative => red;

  /// Orange warning color.
  ///
  /// Defaults to `ZetaColors.orange.60` in AA system.
  /// Defaults to `ZetaColors.orange.80` in AAA system.
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get warning => orange;

  /// Purple info color.
  ///
  /// Defaults to `ZetaColors.purple.60` in AA system.
  /// Defaults to `ZetaColors.purple.80` in AAA system.
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get info => purple;

  T _resolveDefault<T>(_ZetaColorProperties property) {
    switch (property) {
      case _ZetaColorProperties.primarySwatch:
      case _ZetaColorProperties.secondarySwatch:
        return ZetaColorBase.blue.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.cool:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.warm:
        return ZetaColorBase.greyWarm.apply(brightness: brightness, contrast: contrast) as T;

      case _ZetaColorProperties.textDefault:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade90 as T;
      case _ZetaColorProperties.textSubtle:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade70 as T;
      case _ZetaColorProperties.textInverse:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade20 as T;
      case _ZetaColorProperties.textDisabled:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade50 as T;
      case _ZetaColorProperties.pink:
        return ZetaColorBase.pink.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.teal:
        return ZetaColorBase.teal.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.yellow:
        return ZetaColorBase.yellow.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.purple:
        return ZetaColorBase.purple.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.orange:
        return ZetaColorBase.orange.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.red:
        return ZetaColorBase.red.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.green:
        return ZetaColorBase.green.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.blue:
        return ZetaColorBase.blue.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.surfaceSelected:
        return ZetaColorBase.blue.apply(brightness: brightness, contrast: contrast).shade10 as T;
      case _ZetaColorProperties.surfaceSelectedHovered:
        return ZetaColorBase.blue.apply(brightness: brightness, contrast: contrast).shade20 as T;
      case _ZetaColorProperties.surfaceHovered:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade20 as T;
      case _ZetaColorProperties.surfaceDisabled:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade30 as T;
      case _ZetaColorProperties.surfaceTertiary:
        return ZetaColorBase.greyWarm.apply(brightness: brightness, contrast: contrast).shade10 as T;
      case _ZetaColorProperties.surfaceSecondary:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade10 as T;
      case _ZetaColorProperties.borderSelected:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade90 as T;
      case _ZetaColorProperties.borderDisabled:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade30 as T;
      case _ZetaColorProperties.borderSubtle:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade40 as T;
      case _ZetaColorProperties.borderDefault:
        return ZetaColorBase.greyCool.apply(brightness: brightness, contrast: contrast).shade50 as T;
      case _ZetaColorProperties.shadow:
        return (brightness == Brightness.light ? ZetaColorBase.shadowLight : ZetaColorBase.shadowDark) as T;
      case _ZetaColorProperties.surfacePrimary:
        return (brightness == Brightness.light ? ZetaColorBase.white : ZetaColorBase.black) as T;
      case _ZetaColorProperties.linkVisited:
        return (brightness == Brightness.light ? ZetaColorBase.linkVisitedLight : ZetaColorBase.linkVisitedDark) as T;
      case _ZetaColorProperties.link:
        return (brightness == Brightness.light ? ZetaColorBase.linkLight : ZetaColorBase.linkVisitedDark) as T;
    }
  }
}
