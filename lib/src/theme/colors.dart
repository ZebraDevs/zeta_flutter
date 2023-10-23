import 'package:flutter/material.dart';

import 'color_extensions.dart';
import 'color_scheme.dart';
import 'color_swatch.dart';
import 'colors_base.dart';
import 'contrast.dart';

/// Zeta Colors.
///
/// A customizable, token-based color palette, adapting Zeta colors to Flutter's colorScheme.
@immutable
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
  Color get surfaceSelectedHovered => primary.shade20;

  /// Selected surface color.
  ///
  /// Defaults to: `ZetaColors.blue.10`.
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

  /// Factory constructor for a light theme for [ZetaColors].
  ///
  /// All color options are nullable and default to a pre-defined contrast color if null.
  ///
  /// [contrast] The primary contrast color. If not supplied, defaults to [ZetaContrast.aa].
  /// [primary] A color swatch for primary color accent. Defaults to null.
  /// [secondary] A color swatch for secondary color accent. Defaults to null.
  /// [error] A color swatch for error states. Defaults to null.
  /// [cool] A color swatch for cooler color tones. Defaults to null.
  /// [warm] A color swatch for warmer color tones. Defaults to null.
  /// [white] A color option for white color. Defaults to null.
  /// [black] A color option for black color. Defaults to null.
  /// [link] A color option for links. Defaults to null.
  /// [linkVisited] A color option for visited links. Defaults to null.
  /// [shadow] A color option for shadows. Defaults to null.
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

  /// Factory constructor for a dark theme for [ZetaColors].
  ///
  /// All color options are nullable and default to a pre-defined contrast color if null.
  ///
  /// [contrast] The primary contrast color. If not supplied, defaults to [ZetaContrast.aa].
  /// [primary] A color swatch for primary color accent. Defaults to null.
  /// [secondary] A color swatch for secondary color accent. Defaults to null.
  /// [error] A color swatch for error states. Defaults to null.
  /// [cool] A color swatch for cooler color tones. Defaults to null.
  /// [warm] A color swatch for warmer color tones. Defaults to null.
  /// [white] A color option for white color. Defaults to null.
  /// [black] A color option for black color. Defaults to null.
  /// [link] A color option for links. Defaults to null.
  /// [linkVisited] A color option for visited links. Defaults to null.
  /// [shadow] A color option for shadows. Defaults to null.
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

  /// Applies new property values to [ZetaColors] and returns a new copy.
  ///
  /// Each property defaults to the previous value if not specified.
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

  /// Apply the given contrast to the color scheme and return a new color scheme.
  ///
  /// If the contrast is the same as the current one, this method will return the current color scheme.
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

  /// Returns a [ZetaColorScheme] based on the properties of the current [ZetaColors].
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZetaColors &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          contrast == other.contrast &&
          primary == other.primary &&
          secondary == other.secondary &&
          error == other.error &&
          cool == other.cool &&
          warm == other.warm &&
          shadow == other.shadow &&
          white == other.white &&
          black == other.black &&
          link == other.link &&
          linkVisited == other.linkVisited &&
          surfacePrimary == other.surfacePrimary &&
          surfaceSecondary == other.surfaceSecondary &&
          surfaceTertiary == other.surfaceTertiary &&
          blue == other.blue &&
          green == other.green &&
          red == other.red &&
          orange == other.orange &&
          purple == other.purple &&
          yellow == other.yellow &&
          teal == other.teal &&
          pink == other.pink;

  @override
  int get hashCode =>
      brightness.hashCode ^
      contrast.hashCode ^
      primary.hashCode ^
      secondary.hashCode ^
      error.hashCode ^
      cool.hashCode ^
      warm.hashCode ^
      shadow.hashCode ^
      white.hashCode ^
      black.hashCode ^
      link.hashCode ^
      linkVisited.hashCode ^
      surfacePrimary.hashCode ^
      surfaceSecondary.hashCode ^
      surfaceTertiary.hashCode ^
      blue.hashCode ^
      green.hashCode ^
      red.hashCode ^
      orange.hashCode ^
      purple.hashCode ^
      yellow.hashCode ^
      teal.hashCode ^
      pink.hashCode;
}

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
