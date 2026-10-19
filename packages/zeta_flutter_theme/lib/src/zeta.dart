import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../zeta_flutter_theme.dart';

/// An [InheritedWidget] that provides access to Zeta theme settings.
///
/// It holds information about the current contrast, theme mode, and theme data.
/// The [tokens] getter provides the design tokens for the current layer themes, color mode and breakpoint.
class Zeta extends InheritedWidget {
  /// Constructs a [Zeta] widget.
  Zeta({
    super.key,
    required super.child,
    bool? rounded,
    this.contrast = ZetaContrast.aa,
    this.themeMode = ThemeMode.system,
    this.customThemeId,
    this.colorMode,
    this.primitivesTheme = ZetaPrimitivesTheme.zeta,
    this.paletteTheme = ZetaPaletteTheme.zeta,
    this.sizeTheme = ZetaSizeTheme.zeta,
    this.typographyTheme = ZetaTypographyTheme.zeta,
    this.breakpoint = ZetaBreakpoint.mobile,
    ZetaPrimitives? customPrimitives,
    ZetaSemantics? customSemantics,
    ZetaTextStyle? textStyles,
  })  : rounded = rounded ?? true,
        roundedOverride = rounded,
        tokens = ZetaTokens.resolve(
          primitivesTheme: primitivesTheme,
          paletteTheme: paletteTheme,
          sizeTheme: sizeTheme,
          typographyTheme: typographyTheme,
          colorMode: colorMode ?? (themeMode.brightness == Brightness.dark ? ZetaColorMode.dark : ZetaColorMode.light),
          breakpoint: breakpoint,
          rounded: rounded,
        ),
        _textStyles = textStyles ??
            ZetaTextStyle(
              textColor: (customSemantics ??
                      (contrast == ZetaContrast.aa
                          ? ZetaSemanticsAA(
                              primitives: customPrimitives ??
                                  (themeMode.brightness == Brightness.light
                                      ? const ZetaPrimitivesLight()
                                      : const ZetaPrimitivesDark()),
                            )
                          : ZetaSemanticsAAA(
                              primitives: customPrimitives ??
                                  (themeMode.brightness == Brightness.light
                                      ? const ZetaPrimitivesLight()
                                      : const ZetaPrimitivesDark()),
                            )))
                  .colors
                  .mainDefault,
            ),
        _customPrimitives = customPrimitives,
        _customSemantics = customSemantics;

  final ZetaPrimitives? _customPrimitives;

  final ZetaSemantics? _customSemantics;

  /// Primitives used for colors, spacing and radii in the Zeta theme.
  @Deprecated('Use tokens.primitives instead. This will be removed in the next major release.')
  ZetaPrimitives get primitives =>
      _customPrimitives ?? (brightness == Brightness.light ? const ZetaPrimitivesLight() : const ZetaPrimitivesDark());

  /// Semantics used for colors, spacing and radii in the Zeta theme.
  @Deprecated('Use tokens instead. This will be removed in the next major release.')
  ZetaSemantics get semantics =>
      _customSemantics ??
      (contrast == ZetaContrast.aa
          ? ZetaSemanticsAA(primitives: primitives)
          : ZetaSemanticsAAA(primitives: primitives));

  /// The design tokens for the current layer themes, [colorMode] and [breakpoint].
  final ZetaTokens tokens;

  /// {@template zeta-component-rounded}
  /// Sets rounded or sharp border of the containing box and the icon style.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool rounded;

  /// The explicitly selected rounded value.
  ///
  /// When null, [tokens] follow the `size.shape` token and [rounded] is `true`.
  final bool? roundedOverride;

  /// The explicitly selected color mode of [tokens].
  ///
  /// When null, [tokens] follow [themeMode] (light or dark).
  final ZetaColorMode? colorMode;

  /// The theme of the `primitives` token layer.
  final ZetaPrimitivesTheme primitivesTheme;

  /// The theme of the `palette` token layer.
  final ZetaPaletteTheme paletteTheme;

  /// The theme of the `size` token layer.
  final ZetaSizeTheme sizeTheme;

  /// The theme of the `typography` token layer.
  final ZetaTypographyTheme typographyTheme;

  /// The breakpoint of the `size` and `typography` token layers.
  final ZetaBreakpoint breakpoint;

  /// The contrast level of the Zeta theme.
  ///
  /// This will determine the color contrast level of the theme when using default semantics.
  final ZetaContrast contrast;

  /// The theme mode of the Zeta theme.
  /// It can be set to 'system', 'light', or 'dark'.
  /// The default value is 'system'.
  final ThemeMode themeMode;

  /// The ID of the current custom theme.
  /// Set to null if no custom theme is being used.
  final String? customThemeId;

  /// Font family.
  final ZetaTextStyle _textStyles;

  /// Provides the color set based on the current theme mode.
  ///
  /// It determines the appropriate color set (light or dark) based on the theme mode
  /// and system brightness.
  @Deprecated(
    'Use the color categories on tokens (surface, foreground, border, interactive, ...) instead. '
    'This will be removed in the next major release.',
  )
  ZetaColors get colors => semantics.colors;

  /// Gets the brightness setting for the current theme.
  ///
  /// If the theme mode is set to 'system', it will return the brightness that ties with the device's system theme setting.
  /// If the theme mode is set to 'light', it always returns `Brightness.light`.
  /// If neither, it returns `Brightness.dark` by default (i.e., when the theme mode is 'dark').
  Brightness get brightness => themeMode.brightness;

  /// Gets the radius values based on the tokens.
  @Deprecated('Use tokens.radius instead. This will be removed in the next major release.')
  ZetaRadius get radius => semantics.radius;

  /// Gets the spacing values based on the tokens.
  @Deprecated('Use tokens.space instead. This will be removed in the next major release.')
  ZetaSpacing get spacing => semantics.spacing;

  /// Gets the text styles based on the tokens.
  @Deprecated('Use tokens.text instead. This will be removed in the next major release.')
  ZetaTextStyle get textStyles => _textStyles;

  @override
  bool updateShouldNotify(covariant Zeta oldWidget) {
    return oldWidget.contrast != contrast ||
        oldWidget.rounded != rounded ||
        oldWidget.themeMode != themeMode ||
        oldWidget._customPrimitives != _customPrimitives ||
        oldWidget._customSemantics != _customSemantics ||
        oldWidget.customThemeId != customThemeId ||
        oldWidget.colorMode != colorMode ||
        oldWidget.tokens != tokens;
  }

  /// Returns the default [Zeta] values; used if [Zeta] is not found in the widget tree.
  // ignore: prefer_constructors_over_static_methods
  static Zeta defaultZetaValues(BuildContext context) {
    // Try to get the brightness from the closest MaterialApp theme
    Brightness brightness;
    try {
      brightness = Theme.of(context).brightness;
    } catch (_) {
      // If we can't find a MaterialApp theme, use the platform brightness
      brightness = MediaQuery.platformBrightnessOf(context);
    }

    // Create a default Zeta with the determined brightness
    return Zeta(
      themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      breakpoint: ZetaBreakpoint.fromWidth(MediaQuery.maybeSizeOf(context)?.width ?? 0),
      child: const SizedBox(), // Empty widget as we're just creating defaults
    );
  }

  /// Fetches the [Zeta] instance from the provided [context].
  ///
  /// It ensures that the context has access to the [Zeta] theming information.
  /// Throws a [FlutterError] if the [Zeta] is not found in the widget tree.
  static Zeta of(BuildContext context) {
    final defaults = context.dependOnInheritedWidgetOfExactType<Zeta>();
    if (defaults != null) {
      return defaults;
    } else {
      return defaultZetaValues(context);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaTokens>('tokens', tokens))
      ..add(EnumProperty<ZetaColorMode?>('colorMode', colorMode))
      ..add(EnumProperty<ZetaPrimitivesTheme>('primitivesTheme', primitivesTheme))
      ..add(EnumProperty<ZetaPaletteTheme>('paletteTheme', paletteTheme))
      ..add(EnumProperty<ZetaSizeTheme>('sizeTheme', sizeTheme))
      ..add(EnumProperty<ZetaTypographyTheme>('typographyTheme', typographyTheme))
      ..add(EnumProperty<ZetaBreakpoint>('breakpoint', breakpoint))
      ..add(DiagnosticsProperty<bool?>('roundedOverride', roundedOverride))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<ZetaColors>('colors', colors))
      ..add(EnumProperty<Brightness>('brightness', brightness))
      ..add(DiagnosticsProperty<ZetaRadius>('radius', radius))
      ..add(DiagnosticsProperty<ZetaSpacing>('spacing', spacing))
      ..add(DiagnosticsProperty<ZetaPrimitives>('primitives', primitives))
      ..add(DiagnosticsProperty<ZetaSemantics>('semantics', semantics))
      ..add(EnumProperty<ZetaContrast>('contrast', contrast))
      ..add(EnumProperty<ThemeMode>('themeMode', themeMode))
      ..add(StringProperty('customThemeId', customThemeId))
      ..add(DiagnosticsProperty<ZetaTextStyle>('textStyles', textStyles));
  }
}

/// Shortcut for `Zeta.of(context).tokens`.
extension ZetaTokensContext on BuildContext {
  /// The [ZetaTokens] of the nearest [Zeta] ancestor.
  ZetaTokens get zetaTokens => Zeta.of(this).tokens;
}
