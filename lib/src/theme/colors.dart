import 'dart:math';

import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Colors.
///
/// A customizable, token-based color palette, adapting Zeta colors to Flutter's colorScheme.
class ZetaColors {
  /// Sets dark mode to colors.
  ///
  /// If using a default theme, this sets all the parameters needed, otherwise dark colors must be provided.
  final bool isDarkMode;

  /// Sets whether colors should meet AAA requirements for accessability when using built in colors.
  ///
  /// Typically, when true, default color shade is 80, rather than 60.
  final bool isAAA;

  /// Shadow color.
  ///
  /// Maps to [ColorScheme.shadow].
  ///
  /// Defaults to #49505E at 10% opacity.
  final Color shadow;

  final Color _linkLight;
  final Color _linkVisitedLight;
  final Color _linkDark;
  final Color _linkVisitedDark;

  final ZetaColorSwatch _primary;
  final ZetaColorSwatch _secondary;
  final ZetaColorSwatch _cool;
  final ZetaColorSwatch _warm;
  final ZetaColorSwatch _blue;
  final ZetaColorSwatch _green;
  final ZetaColorSwatch _red;
  final ZetaColorSwatch _orange;
  final ZetaColorSwatch _purple;
  final ZetaColorSwatch _yellow;
  final ZetaColorSwatch _teal;
  final ZetaColorSwatch _pink;

  final Color? _background;
  final Color? _surface;
  final Color? _white;
  final Color? _black;

  final Color? _onPrimary;
  final Color? _onSecondary;
  final Color? _onNegative;
  final Color? _onBackground;
  final Color? _onSurface;

  final Map<String, Color> _generatedColors;

  static const _minShade = 10;

  /// Generated color for use on [primary].
  ///
  /// {@template zeta-color-on-X}
  /// If [secondary] is dark, [onSecondary] will be [textDarkMode].
  ///
  /// If [secondary] is light, [onSecondary] will be [textLightMode].
  /// {@endtemplate}
  Color get onPrimary {
    if (_onPrimary != null) return _onPrimary!;
    // if (_generatedColors['onPrimary'] != null) return _generatedColors['onPrimary']!;
    _generatedColors['onPrimary'] = computeForegroundFromTheme(input: primary);

    return _generatedColors['onPrimary']!;
  }

  /// Generated color for use on [secondary].
  ///
  /// {@macro zeta-color-on-X}
  Color get onSecondary {
    if (_onSecondary != null) return _onSecondary!;
    if (_generatedColors['onSecondary'] != null) return _generatedColors['onSecondary']!;
    _generatedColors['onSecondary'] = computeForegroundFromTheme(input: secondary);

    return _generatedColors['onSecondary']!;
  }

  /// Generated color for use on [negative].
  ///
  /// {@macro zeta-color-on-X}
  Color get onNegative {
    if (_onNegative != null) return _onNegative!;
    if (_generatedColors['onNegative'] != null) return _generatedColors['onNegative']!;
    _generatedColors['onNegative'] = computeForegroundFromTheme(input: negative);

    return _generatedColors['onNegative']!;
  }

  /// On surface color.
  ///
  /// {@macro zeta-color-on-X}
  Color get onSurface => _onSurface ?? textDefault;

  // Text / icons.

  /// Default text /icon color.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// {@template zeta-color-dark}
  /// Color swatches are inverted if [ZetaColors.isDarkMode].
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
  /// Used for text that is not on [ColorScheme.background] or [ColorScheme.surface].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  ///
  /// {@macro zeta-color-dark}
  Color get textInverse => cool.shade20;

  // Border variants.

  /// Default border color.
  ///
  /// Defaults to `ZetaColors.warm.50`.
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

  // Backdrop colors.

  /// Surface color.
  ///
  /// Maps to [ColorScheme.background].
  ///
  /// * Light mode: `ZetaColors.cool.10`
  /// * Dark mode: `ZetaColors.white`.
  Color get surfacePrimary => isDarkMode ? cool.shade10 : ZetaColorBase.white;

  /// Background color.
  ///
  /// See [ColorScheme.background].
  Color get background => _background ?? warm.shade10;

  /// On background color.
  ///
  /// See [ColorScheme.onBackground].
  Color get onBackground => _onBackground ?? textSubtle;

  /// Surface color.
  ///
  /// See [ColorScheme.surface].
  Color get surface => _surface ?? surfaceSecondary;

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

  /// Secondary surface color.
  ///
  /// * Light mode: `ZetaColors.cool.10`.
  /// * Dark mode: `ZetaColors.warm.30`.
  Color get surfaceSecondary => isDarkMode ? cool.shade10 : white;

  /// Tertiary surface color.
  ///
  /// Maps to [ColorScheme.background].
  ///
  /// * Light mode: `ZetaColors.warm.10`.
  /// * Dark mode: `ZetaColors.cool.30`.
  Color get surfaceTertiary => isDarkMode ? cool.shade30 : warm.shade10;

  /// Selected hover surface color.
  ///
  /// Defaults to: `ZetaColors.blue.20`.
  Color get surfaceSelectedHovered => blue.shade20;

  /// Selected surface color.
  ///
  /// Defaults to: `ZetaColors.blue.10`.
  Color get surfaceSelected => blue.shade10;

  /// Green positive color.
  ///
  /// Defaults to `ZetaColors.green.60`.
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get positive => green.shade60;

  /// Red negative color.
  ///
  /// Defaults to `ZetaColors.red.60`.
  ///
  /// Maps to [ColorScheme.error].
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get negative => red.shade60;

  /// Orange warning color.
  ///
  /// Defaults to `ZetaColors.orange.60`.
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get warning => orange.primary;

  /// Purple info color.
  ///
  /// Defaults to `ZetaColors.purple.60`.
  ///
  /// {@macro zeta-color-dark}
  ///
  /// {@macro zeta-color-aaa}
  Color get info => purple.primary;

  /// Pure white color.
  ///
  /// `ZetaColors.white`.
  Color get white => _white ?? ZetaColorBase.white;

  /// Pure black color.
  ///
  /// `ZetaColors.black`.
  Color get black => _black ?? ZetaColorBase.black;

  /// Link color.
  ///
  /// Defaults to [ZetaColorBase.linkLight] or [ZetaColorBase.linkDark].
  Color get link => isDarkMode ? _linkDark : _linkLight;

  /// Link color.
  ///
  /// Defaults to [ZetaColorBase.linkVisitedLight] or [ZetaColorBase.linkVisitedDark].
  Color get linkVisited => isDarkMode ? _linkVisitedDark : _linkVisitedLight;

  /// Static text color for light mode. Does not change based on [isDarkMode].
  ///
  /// Defaults to `ZetaColors.cool.90`.
  Color get textLightMode => ZetaColorBase.greyCool.shade90;

  /// Static text color for dark mode. Does not change based on [isDarkMode].
  ///
  /// Defaults to `ZetaColors.cool.20`.
  Color get textDarkMode => ZetaColorBase.greyCool.shade20;

  /// Primary color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get primary => _primary.copyWith(isDarkMode: isDarkMode, isAAA: isAAA);

  /// Secondary color used in app.
  ///
  /// Defaults to `ZetaColors.cool.90`.
  ///
  /// Maps to [ColorScheme.secondary].
  ZetaColorSwatch get secondary => _secondary.copyWith(isDarkMode: isDarkMode, isAAA: isAAA);

  /// Cool grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyCool].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get cool => _cool.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Warm grey color swatch.
  ///
  /// Defaults to [ZetaColorBase.greyWarm].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get warm => _warm.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Blue color swatch.
  ///
  /// Defaults to [ZetaColorBase.blue].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get blue => _blue.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Green color swatch.
  ///
  /// Defaults to [ZetaColorBase.green].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get green => _green.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Red color swatch.
  ///
  /// Defaults to [ZetaColorBase.red].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get red => _red.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Orange color swatch.
  ///
  /// Defaults to [ZetaColorBase.orange].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get orange => _orange.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Purple color swatch.
  ///
  /// Defaults to [ZetaColorBase.purple].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get purple => _purple.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Yellow color swatch.
  ///
  /// Defaults to [ZetaColorBase.yellow].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get yellow => _yellow.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Teal color swatch.
  ///
  /// Defaults to [ZetaColorBase.teal].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get teal => _teal.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Pink color swatch.
  ///
  /// Defaults to [ZetaColorBase.pink].
  ///
  /// {@macro zeta-color-dark}
  ZetaColorSwatch get pink => _pink.copyWith(isAAA: isAAA, isDarkMode: isDarkMode);

  /// Generates a [ColorScheme] based on current instance of [ZetaColors].
  ///
  /// Colors correspond to the following values:
  ///
  /// * [ColorScheme.brightness] : [isDarkMode].
  /// * [ColorScheme.primary] : [ZetaColors.primary].
  /// * [ColorScheme.onPrimary] : [onPrimary].
  /// * [ColorScheme.secondary] : [ZetaColors.secondary].
  /// * [ColorScheme.error] : [negative].
  /// * [ColorScheme.onError] : [ZetaColorBase.white].
  /// * [ColorScheme.background] : [surfaceSecondary].
  /// * [ColorScheme.onBackground] : [textSubtle].
  /// * [ColorScheme.surface] : [surfacePrimary].
  /// * [ColorScheme.onSurface] : [textDefault].
  /// * [ColorScheme.shadow] : [shadow].
  ColorScheme get toColorScheme {
    return ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: primary.primary,
      onPrimary: onPrimary,
      secondary: secondary.primary,
      onSecondary: onSecondary,
      error: negative,
      onError: onNegative,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      shadow: shadow,

      // TODO(colors): Consider adding the following colors:

      // errorContainer:
      // onErrorContainer:
      // inversePrimary:
      // inverseSurface:
      // onInverseSurface:
      // primaryContainer:
      // onPrimaryContainer:
      // secondaryContainer:
      // onSecondaryContainer:
      // surfaceVariant:
      // onSurfaceVariant:
      // tertiary:
      // onTertiary:
      // tertiaryContainer:
      // onTertiaryContainer:
      // outline:
      // outlineVariant:
      // scrim:
      // surfaceTint:
    );
  }

  /// Colorful colors.
  List<ZetaColorSwatch> get rainbow => [red, orange, yellow, green, blue, teal, pink];

  /// Default constructor for instance of [ZetaColors].
  ZetaColors({
    ZetaColorSwatch primary = ZetaColorBase.blue,
    ZetaColorSwatch secondary = ZetaColorBase.blue,
    ZetaColorSwatch cool = ZetaColorBase.greyCool,
    ZetaColorSwatch warm = ZetaColorBase.greyWarm,
    ZetaColorSwatch blue = ZetaColorBase.blue,
    ZetaColorSwatch green = ZetaColorBase.green,
    ZetaColorSwatch red = ZetaColorBase.red,
    ZetaColorSwatch orange = ZetaColorBase.orange,
    ZetaColorSwatch purple = ZetaColorBase.purple,
    ZetaColorSwatch yellow = ZetaColorBase.yellow,
    ZetaColorSwatch teal = ZetaColorBase.teal,
    ZetaColorSwatch pink = ZetaColorBase.pink,
    Color linkLight = ZetaColorBase.linkLight,
    Color linkVisitedLight = ZetaColorBase.linkVisitedLight,
    Color linkDark = ZetaColorBase.linkDark,
    Color linkVisitedDark = ZetaColorBase.linkVisitedDark,
    this.shadow = ZetaColorBase.shadow,
    this.isDarkMode = false,
    this.isAAA = false,
    Color? onPrimary,
    Color? onSecondary,
    Color? onNegative,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? black,
    Color? white,
  })  : _primary = primary,
        _secondary = secondary,
        _cool = cool,
        _warm = warm,
        _blue = blue,
        _green = green,
        _red = red,
        _orange = orange,
        _purple = purple,
        _yellow = yellow,
        _teal = teal,
        _pink = pink,
        _linkLight = linkLight,
        _linkVisitedLight = linkVisitedLight,
        _linkDark = linkDark,
        _linkVisitedDark = linkVisitedDark,
        _onPrimary = onPrimary,
        _onSecondary = onSecondary,
        _onNegative = onNegative,
        _background = background,
        _onBackground = onBackground,
        _surface = surface,
        _onSurface = onSurface,
        _black = black,
        _white = white,
        _generatedColors = {};

  /// Creates a [ZetaColors] from individual colors and generates their full swatches with [ZetaColorSwatch.fromColor]
  ZetaColors.fromColors({
    Color? primary,
    Color? secondary,
    Color? cool,
    Color? warm,
    Color? blue,
    Color? green,
    Color? red,
    Color? orange,
    Color? purple,
    Color? yellow,
    Color? teal,
    Color? pink,
    Color? linkLight,
    Color? linkVisitedLight,
    Color? linkDark,
    Color? linkVisitedDark,
    Color? onPrimary,
    Color? onSecondary,
    Color? onNegative,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? black,
    Color? white,
    this.shadow = ZetaColorBase.shadow,
    this.isDarkMode = false,
    this.isAAA = false,
  })  : _primary = primary?.zetaColorSwatch ?? ZetaColorBase.blue,
        _secondary = secondary?.zetaColorSwatch ?? ZetaColorBase.blue,
        _cool = cool?.zetaColorSwatch ?? ZetaColorBase.greyCool,
        _warm = warm?.zetaColorSwatch ?? ZetaColorBase.greyWarm,
        _blue = blue?.zetaColorSwatch ?? ZetaColorBase.blue,
        _green = green?.zetaColorSwatch ?? ZetaColorBase.green,
        _red = red?.zetaColorSwatch ?? ZetaColorBase.red,
        _orange = orange?.zetaColorSwatch ?? ZetaColorBase.orange,
        _purple = purple?.zetaColorSwatch ?? ZetaColorBase.purple,
        _yellow = yellow?.zetaColorSwatch ?? ZetaColorBase.yellow,
        _teal = teal?.zetaColorSwatch ?? ZetaColorBase.teal,
        _pink = pink?.zetaColorSwatch ?? ZetaColorBase.pink,
        _linkLight = linkLight ?? ZetaColorBase.linkLight,
        _linkVisitedLight = linkVisitedLight ?? ZetaColorBase.linkVisitedLight,
        _linkDark = linkDark ?? ZetaColorBase.linkDark,
        _linkVisitedDark = linkVisitedDark ?? ZetaColorBase.linkVisitedDark,
        _onPrimary = onPrimary,
        _onSecondary = onSecondary,
        _onNegative = onNegative,
        _background = background,
        _onBackground = onBackground,
        _surface = surface,
        _onSurface = onSurface,
        _black = black,
        _white = white,
        _generatedColors = {};

  /// Returns a new ZetaColors instance, with the copied fields applied.
  ZetaColors copyWith({
    bool? isDarkMode,
    bool? isAAA,
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    ZetaColorSwatch? cool,
    ZetaColorSwatch? warm,
    ZetaColorSwatch? blue,
    ZetaColorSwatch? green,
    ZetaColorSwatch? red,
    ZetaColorSwatch? orange,
    ZetaColorSwatch? purple,
    ZetaColorSwatch? yellow,
    ZetaColorSwatch? teal,
    ZetaColorSwatch? pink,
    Color? linkLight,
    Color? linkVisitedLight,
    Color? linkDark,
    Color? linkVisitedDark,
  }) {
    return ZetaColors(
      primary: primary ?? _primary,
      secondary: secondary ?? this.secondary,
      cool: cool ?? _cool,
      warm: warm ?? _warm,
      blue: blue ?? _blue,
      green: green ?? _green,
      red: red ?? _red,
      orange: orange ?? _orange,
      purple: purple ?? _purple,
      yellow: yellow ?? _yellow,
      teal: teal ?? _teal,
      pink: pink ?? _pink,
      linkLight: linkLight ?? _linkLight,
      linkVisitedLight: linkVisitedLight ?? _linkVisitedLight,
      linkDark: linkDark ?? _linkDark,
      linkVisitedDark: linkVisitedDark ?? _linkVisitedDark,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isAAA: isAAA ?? this.isAAA,
    );
  }

  /// Calculates foreground color based on luminance of input.
  static Color computeForeground({
    required Color input,
    Color light = ZetaColorBase.white,
    Color dark = ZetaColorBase.black,
  }) =>
      input.isLight ? dark : light;

  /// Calculates foreground color based on luminance of input.
  Color computeForegroundFromTheme({required Color input}) => input.isLight ? textDefault : textInverse;

  /// Setter for updating ZetaColors instance based on current context.
  static void setColors(BuildContext context, ZetaColors colors) {
    final ZetaState? state = context.findAncestorStateOfType<ZetaState>();
    if (state != null) {
      state.colors = colors;
    }
  }

  /// Setter for updating if dark mode is activated for ZetaColors instance based on current context.
  static void setDarkMode(BuildContext context, bool val) {
    final ZetaState? state = context.findAncestorStateOfType<ZetaState>();
    if (state != null) {
      state.colors = state.colors.copyWith(isDarkMode: val);
    }
  }

  /// Returns instance of [ZetaColors] from the current context.
  ///
  /// For this function to work properly, it is required that the current context is beneath a [ZetaColors] widget
  /// otherwise a new default instance of [ZetaColors] will be returned.
  static ZetaColors of(BuildContext context) {
    final ZetaState? state = context.findAncestorStateOfType<ZetaState>();

    // ignore: prefer_const_constructors
    return state?.colors ?? ZetaColors();
  }
}

/// A swatch of colors with values from 10 (light) to 100 (dark).
class ZetaColorSwatch extends ColorSwatch<int> {
  /// Returns an element of the swatch table.
  @override
  Color? operator [](int index) => super[isDarkMode ? (-1 * index) + 110 : index];

  /// True if swatch should be generated for dark mode.
  ///
  /// {@macro zeta-color-dark}
  final bool isDarkMode;

  /// True if swatch should be generated for AAA accessability mode.
  ///
  /// {@macro zeta-color-aaa}
  final bool isAAA;

  /// The lightest shade.
  Color get shade10 => this[10]!;

  /// The second lightest shade.
  Color get shade20 => this[20]!;

  /// The third lightest shade.
  Color get shade30 => this[30]!;

  /// The fourth lightest shade.
  Color get shade40 => this[40]!;

  /// The fifth lightest shade.
  Color get shade50 => this[50]!;

  /// The default shade.
  Color get shade60 => this[60]!;

  /// The fourth darkest shade.
  Color get shade70 => this[70]!;

  /// The third darkest shade.
  Color get shade80 => this[80]!;

  /// The second darkest shade.
  Color get shade90 => this[90]!;

  /// The darkest shade.
  Color get shade100 => this[100]!;

  /// Selected color: 80.
  Color get selected => isAAA ? shade100 : shade80;

  /// Hover color: 70.
  Color get hover => shade70;

  /// Text color: 60, or [ZetaColors.textDarkMode] if [isAAA].
  ///
  /// This color should be used for foreground text when [surface] is the background.
  Color get text {
    if (isAAA) return isDarkMode ? ZetaColorBase.white : ZetaColorBase.text;

    return shade60;
  }

  /// Default color for the swatch.
  ///
  /// Defaults to [shade60].
  ///
  /// {@macro zeta-color-aaa}
  Color get primary => isAAA ? shade80 : shade60;

  /// Icon color: 60.
  ///
  /// This color should be used for foreground icons or graphics when [surface] is the background.
  Color get icon => shade60;

  /// Border color: 60.
  Color get border => shade60;

  /// Subtle border color: 40.
  Color get borderSubtle => shade40;

  /// Surface color: 10.
  ///
  /// Used for component backgrounds. Use [text] and [icon] for foreground components.
  Color get surface => shade10;

  /// Returns the subtle color for the swatch.
  Color get subtle => shade10;

  /// Generates foreground color to be used on [primary].
  Color get on => ZetaColors.computeForeground(input: primary);

  /// Gets color for disabled mode.
  Color get disabled => isDarkMode ? shade30 : shade10;

  /// Constructs a [ZetaColorSwatch].
  ///
  /// See also:
  /// * [MaterialColor].
  const ZetaColorSwatch(super.primary, super._swatch, {this.isDarkMode = false, this.isAAA = false});

  /// {@template zeta.color.color_to_swatch}
  /// Returns a color swatch from a single color.
  ///
  /// This function does NOT guarantee color swatches will meet accessibility criteria AA or AAA.
  /// {@endtemplate}
  ZetaColorSwatch.fromColor(Color color, {this.isAAA = false, this.isDarkMode = false})
      : super(
          color.value,
          color._mapFromColor,
        );

  /// Creates a new instance of [ZetaColors] with the fields applied.
  ZetaColorSwatch copyWith({bool isDarkMode = false, bool isAAA = false}) {
    return ZetaColorSwatch(
      isAAA ? shade80.value : shade60.value,
      {
        for (final v in List.generate(ZetaColors._minShade, (index) => (index + 1) * ZetaColors._minShade)) v: this[v]!,
      },
      isDarkMode: isDarkMode,
      isAAA: isAAA,
    );
  }
}

/// Extensions on [Color].
extension ColorExtension on Color {
  /// {@macro zeta.color.color_to_swatch}
  ZetaColorSwatch get zetaColorSwatch => ZetaColorSwatch.fromColor(this);

  /// Applies lightness percentage to color.
  Color withLightness(double percentage) {
    final HSLColor hslColor = HSLColor.fromColor(this);

    return hslColor.withLightness(percentage).toColor();
  }

  /// Uses [computeLuminance] to determine if a color if light.
  bool get isLight => computeLuminance() > 0.5;

  /// Gets lightness of color.
  double get lightness => HSLColor.fromColor(this).lightness;

  /// Calculates the contrast of a color.
  double contrast({Color background = Colors.white}) {
    final l1 = computeLuminance();
    final l2 = background.computeLuminance();
    const offset = 0.05;

    return (max(l1, l2) + offset) / (min(l1, l2) + offset);
  }

  /// Rudimentary algorithm to generate a color swatch from a single color.
  ///
  /// Attempts to ensure 60 will pass AA against white and 80 will pass AAA against white.
  /// This is NOT guaranteed to work.
  ///
  // TODO(colors): Improve this.
  Map<int, Color> get _mapFromColor {
    final initialContrast = contrast();

    double findX(Color c, double minContrast) {
      double min = 0;
      double max = 1;
      bool found = false;
      double val;

      do {
        val = (min + max) / 2;

        final con = c.withLightness(val).contrast();

        if (con < minContrast) {
          max = val;
        } else if (con > minContrast + 0.1) {
          min = val;
        } else {
          found = true;
        }
      } while (!found);

      return val;
    }

    final double col60 = initialContrast < 4.6 && initialContrast > 4.5 ? lightness : findX(this, 4.5);
    final double col80 = findX(this, 7);

    final double darkGap = col80 / 3;
    final double lightGap = (1 - col60) / 6;

    return {
      100: withLightness(col80 - (darkGap * 2)),
      90: withLightness(col80 - (darkGap * 1)),
      80: withLightness(col80),
      70: withLightness((col80 + col60) / 2),
      60: withLightness(col60),
      50: withLightness(col60 + (lightGap * 1)),
      40: withLightness(col60 + (lightGap * 2)),
      30: withLightness(col60 + (lightGap * 3)),
      20: withLightness(col60 + (lightGap * 4)),
      10: withLightness(col60 + (lightGap * 5)),
    };
  }
}
