import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../generated/generated.dart';
import 'color_extensions.dart';
import 'color_scheme.dart';
import 'color_swatch.dart';
import 'colors_base.dart';
import 'contrast.dart';

/// A customizable, token-based color palette, adapting Zeta colors to Flutter's colorScheme.
/// {@category Theme}
@immutable
@Deprecated('Removed in v1.0.0')
class ZetaColors extends Equatable implements ZetaColorSemantics {
  /// Default constructor for instance of [ZetaColors].
  @Deprecated('Removed in v1.0.0')
  ZetaColors({
    @Deprecated('Removed in v1.0.0') this.brightness = Brightness.light,
    @Deprecated('Removed in v1.0.0') this.contrast = ZetaContrast.aa,
    @Deprecated('Removed in v1.0.0') this.white = ZetaColorBase.white,
    @Deprecated('Removed in v1.0.0') this.black = ZetaColorBase.black,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    ZetaColorSwatch? pure,
    Color? surfacePrimary,
    Color? surfaceSecondary,
    Color? surfaceTertiary,
    bool adjust = true,
  })  : primary = _adjustedValue(primary, ZetaColorBase.blue, adjust, brightness, contrast),
        secondary = _adjustedValue(secondary, primary ?? ZetaColorBase.yellow, adjust, brightness, contrast),
        error = _adjustedValue(error, ZetaColorBase.red, adjust, brightness, contrast),
        cool = _adjustedValue(cool, ZetaColorBase.cool, adjust, brightness, ZetaContrast.aa),
        warm = _adjustedValue(warm, ZetaColorBase.warm, adjust, brightness, ZetaContrast.aa),
        pure = _adjustedValue(pure, ZetaColorBase.pure, adjust, brightness, ZetaContrast.aa),
        surfacePrimary = surfacePrimary ?? white,
        surfaceSecondary = surfaceSecondary ??
            _adjustedValue(
              cool,
              ZetaColorBase.cool,
              adjust,
              brightness,
              ZetaContrast.aa,
            ).shade10,
        surfaceTertiary = surfaceTertiary ??
            _adjustedValue(
              warm,
              ZetaColorBase.warm,
              adjust,
              brightness,
              ZetaContrast.aa,
            ).shade10,
        blue = _adjustedBase(ZetaColorBase.blue, adjust, brightness, contrast),
        green = _adjustedBase(ZetaColorBase.green, adjust, brightness, contrast),
        red = _adjustedBase(ZetaColorBase.red, adjust, brightness, contrast),
        orange = _adjustedBase(ZetaColorBase.orange, adjust, brightness, contrast),
        purple = _adjustedBase(ZetaColorBase.purple, adjust, brightness, contrast),
        yellow = _adjustedBase(ZetaColorBase.yellow, adjust, brightness, contrast),
        teal = _adjustedBase(ZetaColorBase.teal, adjust, brightness, contrast),
        pink = _adjustedBase(ZetaColorBase.pink, adjust, brightness, contrast);

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
  @Deprecated('Removed in v1.0.0')
  factory ZetaColors.light({
    ZetaContrast contrast = ZetaContrast.aa,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    Color? white,
    Color? black,
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
  @Deprecated('Removed in v1.0.0')
  factory ZetaColors.dark({
    ZetaContrast contrast = ZetaContrast.aa,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? error,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    Color? white,
    Color? black,
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
    );
  }

  /// Constructor Fields

  /// Represents the brightness value.
  @Deprecated('Removed in v1.0.0')
  final Brightness brightness;

  /// Represents the Zeta accessibility standard.
  @Deprecated('Removed in v1.0.0')
  final ZetaContrast contrast;

  /// Primary color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch primary;

  /// Secondary color used in app.
  ///
  /// Defaults to [ZetaColorBase.yellow]
  ///
  /// Maps to [ColorScheme.secondary].
  final ZetaColorSwatch secondary;

  /// Secondary color used in app.
  ///
  /// Defaults to `ZetaColors.red.60`.
  ///
  /// Maps to [ColorScheme.error].
  final ZetaColorSwatch error;

  /// Cool  color swatch.
  ///
  /// Defaults to [ZetaColorBase.cool].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch cool;

  /// Warm  color swatch.
  ///
  /// Defaults to [ZetaColorBase.warm].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch warm;

  /// Pure color swatch.
  ///
  /// Defaults to [ZetaColorBase.pure].
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch pure;

  /// White color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// Defaults to [ZetaColorBase.white].
  @Deprecated('Removed in v1.0.0')
  final Color white;

  /// Shadow color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// Defaults to [ZetaColorBase.black].
  @Deprecated('Removed in v1.0.0')
  final Color black;

  /// Surface color.
  ///
  /// Maps to [ColorScheme.surface].
  ///
  /// * Light mode: `ZetaColors.black`
  /// * Dark mode: `ZetaColors.white`.
  final Color surfacePrimary;

  /// Secondary surface color.
  ///
  /// * `ZetaColors.cool.10`.
  final Color surfaceSecondary;

  /// Tertiary surface color.
  ///
  /// Maps to [ColorScheme.surface] and [ThemeData.scaffoldBackgroundColor]
  ///
  /// * `ZetaColors.warm.10`.
  final Color surfaceTertiary;

  // Text / icons.

  /// Default text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@template zeta-color-dark}
  /// Color swatches are inverted if [ZetaColors.brightness] is Dark.
  /// {@endtemplate}
  Color get textDefault => cool.shade90;

  /// Subtle text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onSurface].
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
  /// Used for text that is not on [ColorScheme.surface] or [ThemeData.scaffoldBackgroundColor].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get textInverse => cool.shade20;

  /// Default icon color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@macro zeta-color-dark}
  Color get iconDefault => cool.shade90;

  /// Subtle icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onSurface].
  ///
  /// {@macro zeta-color-dark}
  Color get iconSubtle => cool.shade70;

  /// Disabled icon color.
  ///
  /// Defaults to `ZetaColors.cool.50`.
  ///
  /// {@macro zeta-color-dark}
  Color get iconDisabled => cool.shade50;

  /// Inverse icon color.
  ///
  /// Used for text that is not on [ColorScheme.surface] or [ThemeData.scaffoldBackgroundColor].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get iconInverse => cool.shade20;

  ///  Default Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceDefault => pure.shade(0);

  ///  Default-inverse Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceDefaultInverse => warm.shade(100);

  ///  Hover Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceHover => cool.shade(20);

  ///  Selected Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceSelected => primary.shade(10);

  ///  Selected-hover Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceSelectedHover => primary.shade(20);

  ///  Disabled Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceDisabled => cool.shade(30);

  ///  Cool Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceCool => cool.shade(10);

  ///  Warm Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceWarm => warm.shade(10);

  ///  Primary-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfacePrimarySubtle => primary.shade(10);

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceAvatarBlue => blue.shade(80);

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get surfaceAvatarGreen => green;

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceAvatarOrange => orange.shade(50);

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceAvatarPink => pink.shade(80);

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceAvatarPurple => purple.shade(80);

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceAvatarTeal => teal.shade(80);

  /// Avatar Avatar Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceAvatarYellow => yellow.shade(50);

  ///  Secondary-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceSecondarySubtle => secondary.shade(10);

  ///  Positive Surface Color
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get surfacePositive => green;

  ///  Positive-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfacePositiveSubtle => green.shade(10);

  ///  Warning Surface Color
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get surfaceWarning => orange;

  ///  Warning-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceWarningSubtle => orange.shade(10);

  ///  Negative Surface Color
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get surfaceNegative => red;

  ///  Negative-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceNegativeSubtle => red.shade(10);

  ///  Info Surface Color
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get surfaceInfo => purple;

  ///  Info-subtle Surface Color
  ///
  /// {@macro zeta-color-dark}
  Color get surfaceInfoSubtle => purple.shade(10);

  ///  Default Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderDefault => cool.shade(40);

  ///  Subtle Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderSubtle => cool.shade(30);

  ///  Hover Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderHover => cool.shade(90);

  ///  Selected Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderSelected => cool.shade(90);

  ///  Disabled Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderDisabled => cool.shade(20);

  ///  Pure Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderPure => pure.shade(0);

  ///  Primary-main Border Color
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get borderPrimaryMain => primary;

  ///  Primary Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderPrimary => primary.shade(50);

  ///  Secondary Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderSecondary => secondary.shade(50);

  ///  Positive Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderPositive => green.shade(50);

  ///  Warning Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderWarning => orange.shade(50);

  ///  Negative Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderNegative => red.shade(50);

  ///  Info Border Color
  ///
  /// {@macro zeta-color-dark}
  Color get borderInfo => purple.shade(50);

  /// Blue color swatch
  ///
  /// Defaults to [ZetaColorBase.blue]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch blue;

  /// Green color swatch
  ///
  /// Defaults to [ZetaColorBase.green]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch green;

  /// Red color swatch
  ///
  /// Defaults to [ZetaColorBase.red]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch red;

  /// Orange color swatch
  ///
  /// Defaults to [ZetaColorBase.orange]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch orange;

  /// Purple color swatch
  ///
  /// Defaults to [ZetaColorBase.purple]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch purple;

  /// Yellow color swatch
  ///
  /// Defaults to [ZetaColorBase.yellow]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch yellow;

  /// Teal color swatch
  ///
  /// Defaults to [ZetaColorBase.teal]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch teal;

  /// Pink color swatch
  ///
  /// Defaults to [ZetaColorBase.pink]
  ///
  /// {@macro zeta-color-dark}
  final ZetaColorSwatch pink;

  /// True if current [ZetaColors] object uses dark mode colors.
  @Deprecated('Removed in v1.0.0')
  bool get isDarkMode => brightness == Brightness.dark;

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

  /// Applies new property values to [ZetaColors] and returns a new copy.
  ///
  /// Each property defaults to the previous value if not specified.
  ///
  @Deprecated('Removed in v1.0.0')
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
      surfacePrimary: surfacePrimary ?? this.surfacePrimary,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      surfaceTertiary: surfaceTertiary ?? this.surfaceTertiary,
      adjust: (brightness != null && brightness != this.brightness) || (contrast != null && contrast != this.contrast),
    );
  }

  /// Apply the given contrast to the color scheme and return a new color scheme.
  ///
  /// If the contrast is the same as the current one, this method will return the current color scheme.
  @Deprecated('Removed in v1.0.0')
  ZetaColors apply({
    required ZetaContrast contrast,
  }) {
    if (contrast == this.contrast) return this;
    return copyWith(
      contrast: contrast,
    );
  }

  /// Returns a [ZetaColorScheme] based on the properties of the current [ZetaColors].
  @Deprecated('Removed in v1.0.0')
  ZetaColorScheme toScheme() {
    final effectivePrimary = primary.shade(contrast.primary);
    final effectiveSecondary = secondary.shade(contrast.primary);
    final effectiveSurface = surfacePrimary;
    final effectiveError = error;

    return ZetaColorScheme(
      zetaColors: this,
      brightness: brightness,
      error: effectiveError,
      onError: effectiveError.onColor,
      onPrimary: effectivePrimary.onColor,
      onSecondary: effectiveSecondary.onColor,
      onSurface: textDefault,
      primary: effectivePrimary,
      secondary: effectiveSecondary,
      surface: effectiveSurface,
    );
  }

  @override
  List<Object?> get props => [
        brightness,
        contrast,
        primary,
        secondary,
        error,
        cool,
        warm,
        white,
        black,
        surfacePrimary,
        surfaceSecondary,
        surfaceTertiary,
      ];

  @override
  ZetaSemanticBorderColors get border => ZetaSemanticBorderColorsAA(primitives: primitives);

  @override
  ZetaSemanticMainColors get main => ZetaSemanticMainColorsAA(primitives: primitives);

  @override
  ZetaPrimitives get primitives => brightness == Brightness.dark ? ZetaDarkPrimitive() : ZetaLightPrimitive();

  @override
  ZetaSemanticStateColors get state => ZetaSemanticStateColorsAA(primitives: primitives);

  @override
  ZetaSemanticSurfaceColors get surface => ZetaSemanticSurfaceColorsAA(primitives: primitives);
}

enum _ZetaColorProperties {
  primarySwatch,
  secondarySwatch,
  cool,
  warm,
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
  surfaceSelectedHover,
  surfaceHover,
  surfaceDisabled,
  surfaceTertiary,
  surfaceSecondary,
  surfacePrimary,
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
@Deprecated('Removed in v1.0.0')
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

  /// Cool color swatch.
  ///
  /// Defaults to [ZetaColorBase.cool].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get cool => _resolve?.zetaColors.cool ?? _resolveDefault(_ZetaColorProperties.cool);

  /// Warm color swatch.
  ///
  /// Defaults to [ZetaColorBase.warm].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get warm => _resolve?.zetaColors.warm ?? _resolveDefault(_ZetaColorProperties.warm);

  /// Cool  color swatch.
  ///
  /// Defaults to [ZetaColorBase.cool].
  ///
  /// {@macro zeta-color-dark}
  Color get textDefault => _resolve?.zetaColors.textDefault ?? _resolveDefault(_ZetaColorProperties.textDefault);

  /// Subtle text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.70`.
  ///
  /// Maps to [ColorScheme.onSurface].
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
  /// Used for text that is not on [ColorScheme.surface] or [ThemeData.scaffoldBackgroundColor].
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
  /// Maps to [ThemeData.scaffoldBackgroundColor].
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
  Color get surfaceHover => _resolve?.zetaColors.surfaceHover ?? _resolveDefault(_ZetaColorProperties.surfaceHover);

  /// Selected hover surface color.
  ///
  /// Defaults to: `ZetaColors.blue.20`.
  Color get surfaceSelectedHover =>
      _resolve?.zetaColors.surfaceSelectedHover ?? _resolveDefault(_ZetaColorProperties.surfaceSelectedHover);

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
  /// {@template zeta-color-aaa}
  /// When changing from AA to AAA, the color will increase by 2 stops on the swatch.
  /// {@endtemplate}
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
        return ZetaColorBase.blue.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.secondarySwatch:
        return ZetaColorBase.yellow.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.cool:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.warm:
        return ZetaColorBase.warm.apply(brightness: brightness, contrast: contrast) as T;
      case _ZetaColorProperties.textDefault:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade90 as T;
      case _ZetaColorProperties.textSubtle:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade70 as T;
      case _ZetaColorProperties.textInverse:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade20 as T;
      case _ZetaColorProperties.textDisabled:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade50 as T;
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
      case _ZetaColorProperties.surfaceSelectedHover:
        return ZetaColorBase.blue.apply(brightness: brightness, contrast: contrast).shade20 as T;
      case _ZetaColorProperties.surfaceHover:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade20 as T;
      case _ZetaColorProperties.surfaceDisabled:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade30 as T;
      case _ZetaColorProperties.surfaceTertiary:
        return ZetaColorBase.warm.apply(brightness: brightness, contrast: contrast).shade10 as T;
      case _ZetaColorProperties.surfaceSecondary:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade10 as T;
      case _ZetaColorProperties.borderSelected:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade90 as T;
      case _ZetaColorProperties.borderDisabled:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade30 as T;
      case _ZetaColorProperties.borderSubtle:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade40 as T;
      case _ZetaColorProperties.borderDefault:
        return ZetaColorBase.cool.apply(brightness: brightness, contrast: contrast).shade50 as T;
      case _ZetaColorProperties.surfacePrimary:
        return (brightness == Brightness.light ? ZetaColorBase.white : ZetaColorBase.black) as T;
    }
  }
}
