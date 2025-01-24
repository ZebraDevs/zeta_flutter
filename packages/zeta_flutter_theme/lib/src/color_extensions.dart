import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../zeta_flutter_theme.dart';

/// Extensions on [Color] to brighten, lighten, darken and blend colors and
/// can get a shade for gradients.
///
/// Some of the extensions are rewrites of TinyColor's functions
/// https://pub.dev/packages/tinycolor. See LICENSE-3RD-PARTY.
///
/// The TinyColor algorithms have also
/// been modified to use Flutter's HSLColor class instead of the custom one in
/// the TinyColor lib. The functions from TinyColor re-implemented as Color
/// extensions here are [brighten], [lighten] and [darken]. They are used
/// for color calculations in ZetaColorScheme, but also exposed for reuse.
///
/// Another frequently used extension is [blend] and [blendAlpha] used to blend
/// two colors using alpha as a percentage or as an 8-bit int alpha value.
/// This extension is used to calculate branded surface
/// colors used by ZetaColorScheme's branded surfaces and for automatic dark
/// color schemes from a light scheme.
///
/// The [getShadeColor] extension is less frequently used and when used,
/// typically used to color makes colors shades for gradient AppBars, with
/// default setting to not change black and white.
extension ZetaColorExtensions on Color {
  /// {@macro zeta.color.color_to_swatch}
  ZetaColorSwatch get zetaColorSwatch => ZetaColorSwatch.fromColor(this);

  /// Brightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color brighten([int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;

    return Color.fromARGB(
      _intAlpha,
      math.max(0, math.min(255, _intRed - (255 * -(amount / 100)).round())),
      math.max(0, math.min(255, _intGreen - (255 * -(amount / 100)).round())),
      math.max(0, math.min(255, _intBlue - (255 * -(amount / 100)).round())),
    );
  }

  /// Lightens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color lighten([int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.white;
    // HSLColor returns saturation 1 for black, we want 0 instead to be able
    // lighten black color up along the grey scale from black.
    final HSLColor hsl =
        this == const Color(0xFF000000) ? HSLColor.fromColor(this).withSaturation(0) : HSLColor.fromColor(this);
    return hsl.withLightness(math.min(1, math.max(0, hsl.lightness + amount / 100))).toColor();
  }

  /// Darkens the color with the given integer percentage amount.
  /// Defaults to 10%.
  Color darken([int amount = 10]) {
    if (amount <= 0) return this;
    if (amount > 100) return Colors.black;
    final HSLColor hsl = HSLColor.fromColor(this);
    return hsl.withLightness(math.min(1, math.max(0, hsl.lightness - amount / 100))).toColor();
  }

  /// This getter returns appropriate contrast color based on a given color.
  /// It will return a color chosen according to the brightness of this color.
  ///
  /// * The [Color] instance on which this getter is called is used to determine the brightness based on [ThemeData.estimateBrightnessForColor] method.
  /// * If the estimated brightness is light, it will return a color [Colors.black87].
  /// * If the estimated brightness is not light (meaning it's dark), it will return [Colors.white].
  Color get onColor => isLight ? Colors.black87 : Colors.white;

  /// Returns true if the color's brightness is [Brightness.light], else false.
  bool get isLight => ThemeData.estimateBrightnessForColor(this) == Brightness.light;

  /// Returns true if the color's brightness is [Brightness.dark], else false.
  bool get isDark => ThemeData.estimateBrightnessForColor(this) == Brightness.dark;

  /// Blend in the given input Color with a percentage of alpha.
  ///
  /// You typically apply this on a background color, light or dark
  /// to create a background color with a hint of a color used in a theme.
  ///
  /// This is a use case of the alphaBlend static function that exists in
  /// dart:ui Color. It is used to create the branded surface colors in
  /// ZetaColorScheme and to calculate dark scheme colors from light ones,
  /// by blending in white color with light scheme color.
  ///
  /// Defaults to 10% alpha blend of the passed in Color value.
  Color blend(Color input, [int amount = 10]) {
    // Skip blending for impossible value and return the instance color value.
    if (amount <= 0) return this;
    // Blend amounts >= 100 results in the input Color.
    if (amount >= 100) return input;
    return Color.alphaBlend(input.withAlpha(255 * amount ~/ 100), this);
  }

  /// Blend in the given input Color with an alpha value.
  ///
  /// You typically apply this on a background color, light or dark
  /// to create a background color with a hint of a color used in a theme.
  ///
  /// This is a use case of the alphaBlend static function that exists in
  /// dart:ui Color. It is used to create the branded surface colors in
  /// ZetaColorScheme and to calculate dark scheme colors from light ones,
  /// by blending in white color with light scheme color.
  ///
  /// Defaults to alpha 0x0A alpha blend of the passed in Color value,
  /// which is 10% alpha blend.
  Color blendAlpha(Color input, [int alpha = 0x0A]) {
    // Skip blending for impossible value and return the instance color value.
    if (alpha <= 0) return this;
    // Blend amounts >= 255 results in the input Color.
    if (alpha >= 255) return input;
    return Color.alphaBlend(input.withAlpha(alpha), this);
  }

  /// The [getShadeColor] extension is used to make a color darker or lighter,
  /// the [shadeValue] defines the amount in % that the shade should be changed.
  ///
  /// It can be used to make a shade of a color to be used in a gradient.
  /// By default it makes a color that is 15% lighter. If lighten is false
  /// it makes a color that is 15% darker by default.
  ///
  /// By default it does not affect black and white colors, but
  /// if [keepWhite] is set to false, it will darken white color when [lighten]
  /// is false and return a grey color. Wise versa for black with [keepBlack]
  /// set to false, it will lighten black color, when [lighten] is true and
  /// return a grey shade.
  ///
  /// White cannot be made lighter and black cannot be made
  /// darker, the extension just returns white or black for such attempts, with
  /// a quick exist from the call.
  Color getShadeColor({
    int shadeValue = 15,
    bool lighten = true,
    bool keepBlack = true,
    bool keepWhite = true,
  }) {
    if (shadeValue <= 0) return this;
    int usedShadeValue = shadeValue;
    if (usedShadeValue > 100) usedShadeValue = 100;

    // Trying to make black darker, just return black
    if (this == Colors.black && !lighten) return this;
    // Black is defined to be kept as black.
    if (this == Colors.black && keepBlack) return this;
    // Make black lighter as lighten was set and we do not keepBlack
    if (this == Colors.black) return this.lighten(usedShadeValue);

    // Trying to make white lighter, just return white
    if (this == Colors.white && lighten) return this;
    // White is defined to be kept as white.
    if (this == Colors.white && keepWhite) return this;
    // Make white darker as we do not keep white.
    if (this == Colors.white) return darken(usedShadeValue);
    // We are dealing with some other color than white or black, so we
    // make it lighter or darker based on flag and requested shade %
    if (lighten) {
      return this.lighten(usedShadeValue);
    } else {
      return darken(usedShadeValue);
    }
  }

  /// Return uppercase Flutter style hex code string of the color.
  String get hexCode {
    return intValue.toRadixString(16).toUpperCase().padLeft(8, '0');
  }

  /// Applies lightness percentage to color.
  Color withLightness(double percentage) {
    final HSLColor hslColor = HSLColor.fromColor(this);

    return hslColor.withLightness(percentage).toColor();
  }

  /// Gets lightness of color.
  double get lightness => HSLColor.fromColor(this).lightness;

  /// Calculates the contrast ratio between the current color and the given color [b].
  ///
  /// The contrast ratio is computed based on the relative luminance of the two colors
  /// and is useful for ensuring readability and accessibility of text on backgrounds.
  ///
  /// Returns the computed contrast ratio.
  double contrastRatio(Color b) {
    final luminanceA = computeLuminance();
    final luminanceB = b.computeLuminance();
    if (luminanceA > luminanceB) {
      return (luminanceA + 0.05) / (luminanceB + 0.05);
    }
    return (luminanceB + 0.05) / (luminanceA + 0.05);
  }

  /// Adjusts the color to a specific contrast target.
  ///
  /// Parameters:
  /// - [target] The target contrast for the color adjustment.
  /// - [on] The color to compare contrast against. Defaults to [Colors.white].
  /// - [maxIterations] The maximum number of iterations for color adjustment. Defaults to 1000 iterations.
  /// - [epsilon] The difference tolerance for the contrast ratio. Defaults to 0.1.
  ///
  /// Returns:
  /// - A new color with adjusted contrast close to the target contrast.
  Color adjustContrast({
    required Color on,
    required double target,
    int maxIterations = 1000,
    double epsilon = 0.1,
  }) {
    int iteration = 0;
    Color adjustedColor = this;
    double adjustmentValue;

    while (iteration < maxIterations) {
      final currentContrast = adjustedColor.contrastRatio(on);

      if (currentContrast == target || (currentContrast - target).abs() < epsilon) {
        break;
      }

      final hslColor = HSLColor.fromColor(adjustedColor);
      adjustmentValue = (currentContrast - target).abs() * 0.02;

      var newLightness =
          (currentContrast < target) ? hslColor.lightness - adjustmentValue : hslColor.lightness + adjustmentValue;

      newLightness = newLightness.clamp(0.0, 1.0);

      adjustedColor = hslColor.withLightness(newLightness).toColor();
      iteration++;
    }

    return adjustedColor;
  }

  /// Generates a color swatch for this color.
  /// A color swatch is a map with integer keys indexing to [Color] objects,
  /// typically used for design themes.
  ///
  /// The function has optional parameters:
  ///
  /// * [primary] (Default = [kZetaSwatchPrimaryIndex]) - The primary color index for the swatch. This number should be a key in the swatch map.
  /// * [targetContrasts] (Default = [kZetaSwatchTargetContrasts]) - Map of target contrast values for each color index.
  /// * [background] (Default = [Colors.white]) - The color used to determine the contrast of the colors in the swatch. Generally, this should be the background color that the color swatch will be displayed on.
  /// * [adjustPrimary] (Default = true) - Determines whether to adjust the contrast of the primary color on the background color. Useful in cases the brand color is being used.
  ///
  /// Returns a `Map<int, Color>` object.
  Map<int, Color> generateSwatch({
    int primary = kZetaSwatchPrimaryIndex,
    Map<int, double> targetContrasts = kZetaSwatchTargetContrasts,
    Color background = Colors.white,
    bool adjustPrimary = true,
  }) {
    assert(
      targetContrasts.containsKey(primary),
      'Primary key not found in targetContrasts.',
    );

    assert(
      targetContrasts.values.every((v) => v > 0),
      'All values in targetContrasts should be positive and non-null.',
    );

    final swatch = <int, Color>{};

    final adjustedPrimary = adjustPrimary
        ? adjustContrast(
            on: background,
            target: targetContrasts[primary]!,
          )
        : this;

    swatch[primary] = adjustedPrimary;

    for (final shade in targetContrasts.keys) {
      if (shade != primary) {
        swatch[shade] = adjustedPrimary.adjustContrast(
          on: background,
          target: targetContrasts[shade]!,
        );
      }
    }

    return swatch;
  }

  /// Adjusts the current color to meet the specified accessibility standard [standard] when set against the [on] color.
  ///
  /// By default, the AA accessibility standard is targeted. You can optionally target AAA.
  /// AA: The contrast ratio should be at least 4.57:1
  /// AAA: The contrast ratio should be at least 8.33:1
  ///
  /// Returns the adjusted color that meets the specified accessibility standard.
  /// Adjusts the current color to meet a specified accessibility standard [standard] when set against the [on] color.
  Color ensureAccessibility({
    required Color on,
    ZetaContrast standard = ZetaContrast.aa,
  }) {
    return adjustContrast(on: on, target: standard.targetContrast);
  }

  int get _intAlpha => _floatToInt8(a);
  int get _intRed => _floatToInt8(r);
  int get _intGreen => _floatToInt8(g);
  int get _intBlue => _floatToInt8(b);

  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }

  /// Returns the integer value of the color.
  int get intValue {
    // TODO(UX-1353): Remove this method as int color values should be removed
    return _intAlpha << 24 | _intRed << 16 | _intGreen << 8 | _intBlue;
  }
}

/// Extensions on [ZetaColors] to provide additional functionality.
///
/// ZetaColors is a generated class, and so should not be manually edited.
/// Hence, any functions or properties needed should be added in this extension instead.
extension ZetaSemanticColorExtension on ZetaColors {
  /// List of colorful colors.
  List<ZetaColorSwatch> get rainbow => [
        primitives.red,
        primitives.orange,
        primitives.yellow,
        primitives.green,
        primitives.blue,
        primitives.teal,
        primitives.pink,
      ];

  /// Map of colorful colors.
  Map<String, ZetaColorSwatch> get rainbowMap => {
        'red': primitives.red,
        'orange': primitives.orange,
        'yellow': primitives.yellow,
        'green': primitives.green,
        'blue': primitives.blue,
        'teal': primitives.teal,
        'pink': primitives.pink,
      };

  /// Creates a [ColorScheme] based on the current semantic colors.
  ColorScheme get toColorScheme => ColorScheme(
        brightness: primitives.brightness,
        primary: mainPrimary,
        onPrimary: mainPrimary.onColor,
        secondary: mainSecondary,
        onSecondary: mainSecondary.onColor,
        error: mainNegative,
        onError: mainNegative.onColor,
        surface: surfaceDefault,
        onSurface: mainDefault,
      );
}

/// Extensions on [ThemeMode] to provide additional functionality.
extension ZetaThemeModeExtension on ThemeMode {
  /// Returns true if the theme mode is dark.
  bool get isDark => this == ThemeMode.system
      ? SchedulerBinding.instance.platformDispatcher.platformBrightness.isDark
      : this == ThemeMode.dark;

  /// Returns the brightness value based on the theme mode.
  Brightness get brightness => isDark ? Brightness.dark : Brightness.light;
}

extension on Brightness {
  bool get isDark => this == Brightness.dark;
}
