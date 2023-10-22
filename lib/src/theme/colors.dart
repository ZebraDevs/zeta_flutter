import 'package:flutter/material.dart';

import 'color_extensions.dart';
import 'color_scheme.dart';
import 'color_swatch.dart';
import 'colors_base.dart';
import 'contrast.dart';

/// Zeta Colors.
///
/// A customizable, token-based color palette, adapting Zeta colors to Flutter's colorScheme.
class ZetaColors {
  /// Represents the brightness value.
  final Brightness brightness;

  /// Represents the Zeta accessibility standard.
  /// {@macro zeta-color-dark}
  final ZetaContrast contrast;

  /// Primary color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch primary;

  /// Secondary color used in app.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// Maps to [ColorScheme.secondary].
  final ZetaColorSwatch secondary;

  /// Secondary color used in app.
  ///
  /// Defaults to `ZetaColors.red.60`.
  ///
  /// Maps to [ColorScheme.error].
  final ZetaColorSwatch error;

  /// Cool grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyCool].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch cool;

  /// Warm grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyWarm].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch warm;

  /// Shadow color.
  ///
  /// Maps to [ColorScheme.shadow].
  ///
  /// Defaults to #49505E at 10% opacity.
  final Color shadow;

  /// White color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// Defaults to [ZetaColorBase.white].
  final Color white;

  /// Shadow color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// Defaults to [ZetaColorBase.black].
  final Color black;

  // Text / icons.

  /// Default text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@template zeta-color-dark}
  /// Color swatches are inverted if [ZetaColors.brightness] is Dark.
  /// {@endTemplate}
  Color get textDefault => cool.shade90;

  /// Subtle text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onBackground].
  ///
  /// {@macro zeta-color-dark}
  Color get textSubtle => cool.shade70;

  /// Disabled text / icon color.
  ///
  /// Defaults to `ZetaColors.cool.50`.
  ///
  /// {@macro zeta-color-dark}
  Color get textDisabled => cool.shade50;

  /// Inverse text / icon color.
  ///
  /// Used for text that is not on [ColorScheme.background] or [ThemeData.scaffoldBackgroundColor].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get textInverse => cool.shade20;

  // Border variants.

  /// Default border color.
  ///
  /// Defaults to `ZetaColors.cool.50`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderDefault => cool.shade50;

  /// Subtle border color.
  ///
  /// `ZetaColors.cool.40`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderSubtle => cool.shade40;

  /// Disabled border color.
  ///
  /// Defaults to `ZetaColors.cool.30`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderDisabled => cool.shade30;

  /// Selected border color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@macro zeta-color-dark}
  Color get borderSelected => cool.shade90;

  // Links

  /// Link color.
  ///
  /// Defaults to [ZetaColorBase.linkLight] or [ZetaColorBase.linkDark].
  final Color link;

  /// Link color.
  ///
  /// Defaults to [ZetaColorBase.linkVisitedLight] or [ZetaColorBase.linkVisitedDark].
  final Color linkVisited;

  // Backdrop colors.

  /// Surface color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// * Light mode: `ZetaColors.black`
  /// * Dark mode: `ZetaColors.white`.
  final Color surfacePrimary;

  /// Secondary surface color.
  ///
  ///
  /// * `ZetaColors.cool.10`.
  final Color surfaceSecondary;

  /// Tertiary surface color.
  ///
  /// Maps to [ColorScheme.background] and [ThemeData.scaffoldBackgroundColor]
  ///
  /// * `ZetaColors.warm.10`.
  final Color surfaceTertiary;

  /// Disabled surface color.
  ///
  /// Defaults to `ZetaColors.cool.30`.
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceDisabled => cool.shade30;

  /// Hover surface color.
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceHovered => cool.shade20;

  /// Selected hover surface color.
  ///
  /// Defaults to: `ZetaColors.blue.20`.
  // TODO(colors): get these colors from primary if swatch generation is a success.
  //Color get surfaceSelectedHovered => blue.shade20;
  Color get surfaceSelectedHovered => primary.shade20;

  /// Selected surface color.
  ///
  /// Defaults to: `ZetaColors.blue.10`.
  // TODO(colors): get these colors from primary if swatch generation is a success.
  //Color get surfaceSelected => blue.shade10;
  Color get surfaceSelected => primary.shade10;

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
  Color get negative => error;

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

  /// Blue color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch blue;

  /// Green color swatch.
  ///
  /// Defaults to [ZetaColorBase.green].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch green;

  /// Red color swatch.
  ///
  /// Defaults to [ZetaColorBase.red].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch red;

  /// Orange color swatch.
  ///
  /// Defaults to [ZetaColorBase.orange].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch orange;

  /// Purple color swatch.
  ///
  /// Defaults to [ZetaColorBase.purple].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch purple;

  /// Yellow color swatch.
  ///
  /// Defaults to [ZetaColorBase.yellow].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch yellow;

  /// Teal color swatch.
  ///
  /// Defaults to [ZetaColorBase.teal].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch teal;

  /// Pink color swatch.
  ///
  /// Defaults to [ZetaColorBase.pink].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch pink;

  /// Colorful colors.
  List<ZetaColorSwatch> get rainbow => [red, orange, yellow, green, blue, teal, pink];

  /// Default constructor for instance of [ZetaColors].
  ZetaColors({
    this.brightness = Brightness.light,
    this.contrast = ZetaContrast.aa,
    this.link = ZetaColorBase.linkLight,
    this.linkVisited = ZetaColorBase.linkVisitedLight,
    this.shadow = ZetaColorBase.shadowLight,
    this.white = ZetaColorBase.white,
    this.black = ZetaColorBase.black,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceTertiary,
    bool adjust = true,
  })  : primary = _adjustedValue(primary, ZetaColorBase.blue, adjust, brightness, contrast),
        secondary = _adjustedValue(secondary, primary ?? ZetaColorBase.blue, adjust, brightness, contrast),
        error = _adjustedValue(error, ZetaColorBase.red, adjust, brightness, contrast),
        cool = _adjustedValue(cool, ZetaColorBase.greyCool, adjust, brightness, ZetaContrast.aa),
        warm = _adjustedValue(warm, ZetaColorBase.greyWarm, adjust, brightness, ZetaContrast.aa),
        blue = _adjustedBase(ZetaColorBase.blue, adjust, brightness, contrast),
        green = _adjustedBase(ZetaColorBase.green, adjust, brightness, contrast),
        red = _adjustedBase(ZetaColorBase.red, adjust, brightness, contrast),
        orange = _adjustedBase(ZetaColorBase.orange, adjust, brightness, contrast),
        purple = _adjustedBase(ZetaColorBase.purple, adjust, brightness, contrast),
        yellow = _adjustedBase(ZetaColorBase.yellow, adjust, brightness, contrast),
        teal = _adjustedBase(ZetaColorBase.teal, adjust, brightness, contrast),
        pink = _adjustedBase(ZetaColorBase.pink, adjust, brightness, contrast),
        surfacePrimary = surfacePrimary ?? white,
        surfaceSecondary = surfaceSecondary ??
            _adjustedValue(
              cool,
              ZetaColorBase.greyCool,
              adjust,
              brightness,
              ZetaContrast.aa,
            ).shade10,
        surfaceTertiary = surfaceTertiary ??
            _adjustedValue(
              warm,
              ZetaColorBase.greyWarm,
              adjust,
              brightness,
              ZetaContrast.aa,
            ).shade10;

  /// Helper function to adjust color swatch values based on brightness and contrast
  static ZetaColorSwatch _adjustedValue(
    ZetaColorSwatch? value,
    ZetaColorSwatch defaultValue,
    bool adjust,
    Brightness brightness,
    ZetaContrast contrast,
  ) {
    final swatch = value ?? defaultValue;
    return adjust ? swatch.apply(brightness: brightness, contrast: contrast) : swatch;
  }

  /// Helper function to adjust color base values based on brightness and contrast
  static ZetaColorSwatch _adjustedBase(
    ZetaColorSwatch baseColor,
    bool adjust,
    Brightness brightness,
    ZetaContrast contrast,
  ) {
    return adjust ? baseColor.apply(brightness: brightness, contrast: contrast) : baseColor;
  }

  factory ZetaColors.light({
    ZetaContrast contrast = ZetaContrast.aa,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    Color? white,
    Color? black,
    Color? link,
    Color? linkVisited,
    Color? shadow,
  }) {
    return ZetaColors(
      white: white ?? ZetaColorBase.white,
      black: black ?? ZetaColorBase.black,
      cool: cool,
      warm: warm,
      error: error,
      primary: primary,
      contrast: contrast,
      secondary: secondary,
      surfaceTertiary: warm?.shade10,
      surfaceSecondary: cool?.shade10,
      surfacePrimary: white ?? ZetaColorBase.white,
      link: link ?? ZetaColorBase.linkLight,
      shadow: shadow ?? ZetaColorBase.shadowLight,
      linkVisited: linkVisited ?? ZetaColorBase.linkVisitedLight,
    );
  }

  factory ZetaColors.dark({
    ZetaContrast contrast = ZetaContrast.aa,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    Color? white,
    Color? black,
    Color? link,
    Color? linkVisited,
    Color? shadow,
  }) {
    return ZetaColors(
      cool: cool,
      warm: warm,
      white: white ?? ZetaColorBase.white,
      black: black ?? ZetaColorBase.black,
      primary: primary,
      contrast: contrast,
      secondary: secondary,
      error: error,
      brightness: Brightness.dark,
      surfaceTertiary: warm?.shade10,
      surfaceSecondary: cool?.shade10,
      surfacePrimary: black ?? ZetaColorBase.black,
      link: link ?? ZetaColorBase.linkDark,
      shadow: shadow ?? ZetaColorBase.shadowLight,
      linkVisited: linkVisited ?? ZetaColorBase.linkVisitedDark,
    );
  }

  ZetaColors copyWith({
    Brightness? brightness,
    ZetaContrast? contrast,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    Color? white,
    Color? black,
    Color? shadow,
    Color? link,
    Color? linkVisited,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceTertiary,
  }) {
    return ZetaColors(
      white: white ?? this.white,
      black: black ?? this.black,
      brightness: brightness ?? this.brightness,
      contrast: contrast ?? this.contrast,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      error: error ?? this.error,
      cool: cool ?? this.cool,
      warm: warm ?? this.warm,
      shadow: shadow ?? this.shadow,
      link: link ?? this.link,
      linkVisited: linkVisited ?? this.linkVisited,
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      adjust: (brightness != null && brightness != this.brightness) || (contrast != null && contrast != this.contrast),
    );
  }

  ZetaColors apply({
    required ZetaContrast contrast,
  }) {
    if (contrast == this.contrast) return this;
    return ZetaColors(
      adjust: contrast != this.contrast,
      contrast: contrast,
      brightness: brightness,
      primary: primary,
      secondary: secondary,
      error: error,
      cool: cool,
      warm: warm,
      shadow: shadow,
      link: link,
      linkVisited: linkVisited,
      surfacePrimary: surfacePrimary,
      surfaceSecondary: surfaceSecondary,
      surfaceTertiary: surfaceTertiary,
      white: white,
      black: black,
    );
  }

  ZetaColorScheme toScheme() {
    final effectivePrimary = primary.shade(contrast.primary);
    final effectiveSecondary = secondary.shade(contrast.primary);
    final effectiveSurfaceTertiary = surfaceTertiary;
    final effectiveSurface = surfacePrimary;
    final effectiveError = error;

    return ZetaColorScheme(
      zetaColors: this,
      brightness: brightness,
      background: surfaceTertiary,
      error: effectiveError,
      onBackground: effectiveSurfaceTertiary.onColor,
      onError: effectiveError.onColor,
      onPrimary: effectivePrimary.onColor,
      onSecondary: effectiveSecondary.onColor,
      onSurface: effectiveSurface.onColor,
      primary: effectivePrimary,
      secondary: effectiveSecondary,
      surface: effectiveSurface,
    );
  }
}
