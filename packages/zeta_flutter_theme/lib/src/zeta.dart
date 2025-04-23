import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../zeta_flutter_theme.dart';

/// An [InheritedWidget] that provides access to Zeta theme settings.
///
/// It holds information about the current contrast, theme mode, and theme data.
/// The [colors] getter provides the correct color set based on the current theme mode.
class Zeta extends InheritedWidget {
  /// Constructs a [Zeta] widget.
  const Zeta({
    super.key,
    required super.child,
    this.rounded = true,
    this.contrast = ZetaContrast.aa,
    this.themeMode = ThemeMode.system,
    this.customThemeId,
    ZetaPrimitives? customPrimitives,
    ZetaSemantics? customSemantics,
    this.textStyles = const ZetaTextStyle(),
  })  : _customPrimitives = customPrimitives,
        _customSemantics = customSemantics;

  final ZetaPrimitives? _customPrimitives;

  final ZetaSemantics? _customSemantics;

  /// Primitives used for colors, spacing and radii in the Zeta theme.
  ZetaPrimitives get primitives =>
      _customPrimitives ?? (brightness == Brightness.light ? const ZetaPrimitivesLight() : const ZetaPrimitivesDark());

  /// Semantics used for colors, spacing and radii in the Zeta theme.
  ZetaSemantics get semantics =>
      _customSemantics ??
      (contrast == ZetaContrast.aa
          ? ZetaSemanticsAA(primitives: primitives)
          : ZetaSemanticsAAA(primitives: primitives));

  /// {@template zeta-component-rounded}
  /// Sets rounded or sharp border of the containing box and the icon style.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool rounded;

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
  final ZetaTextStyle textStyles;

  /// Provides the color set based on the current theme mode.
  ///
  /// It determines the appropriate color set (light or dark) based on the theme mode
  /// and system brightness.
  ZetaColors get colors => semantics.colors;

  /// Gets the brightness setting for the current theme.
  ///
  /// If the theme mode is set to 'system', it will return the brightness that ties with the device's system theme setting.
  /// If the theme mode is set to 'light', it always returns `Brightness.light`.
  /// If neither, it returns `Brightness.dark` by default (i.e., when the theme mode is 'dark').
  Brightness get brightness => themeMode.brightness;

  /// Gets the radius values based on the tokens.
  ZetaRadius get radius => semantics.radius;

  /// Gets the spacing values based on the tokens.
  ZetaSpacing get spacing => semantics.spacing;

  @override
  bool updateShouldNotify(covariant Zeta oldWidget) {
    return oldWidget.contrast != contrast ||
        oldWidget.rounded != rounded ||
        oldWidget.themeMode != themeMode ||
        oldWidget._customPrimitives != _customPrimitives ||
        oldWidget._customSemantics != _customSemantics ||
        oldWidget.customThemeId != customThemeId;
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
