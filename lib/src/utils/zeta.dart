import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../zeta_flutter.dart';

/// An [InheritedWidget] that provides access to Zeta theme settings.
///
/// It holds information about the current contrast, theme mode, and theme data.
/// The [colors] getter provides the correct color set based on the current theme mode.
/// {@category Utils}
class Zeta extends InheritedWidget {
  /// Constructs a [Zeta] widget.
  const Zeta({
    super.key,
    required super.child,
    this.rounded = true,
    this.contrast = ZetaContrast.aa,
    this.themeMode = ThemeMode.system,
    ZetaPrimitives? customPrimitives,
    ZetaSemantics? customSemantics,
    // String? fontFamily,
  })  : _customPrimitives = customPrimitives,
        _customSemantics = customSemantics;

  final ZetaPrimitives? _customPrimitives;

  final ZetaSemantics? _customSemantics;

  /// Primitives used for colors, spacing and radii in the Zeta theme.
  ZetaPrimitives get primitives =>
      _customPrimitives ?? (brightness == Brightness.light ? ZetaPrimitivesLight() : ZetaPrimitivesDark());

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

  /// Provides the color set based on the current theme mode.
  ///
  /// It determines the appropriate color set (light or dark) based on the theme mode
  /// and system brightness.
  ZetaColorSemantics get colors => semantics.colors;

  /// Gets the brightness setting for the current theme.
  ///
  /// If the theme mode is set to 'system', it will return the brightness that ties with the device's system theme setting.
  /// If the theme mode is set to 'light', it always returns `Brightness.light`.
  /// If neither, it returns `Brightness.dark` by default (i.e., when the theme mode is 'dark').
  Brightness get brightness {
    if (themeMode == ThemeMode.system) {
      return SchedulerBinding
          .instance.platformDispatcher.platformBrightness; // Return the current system brightness setting
    } else if (themeMode == ThemeMode.light) {
      return Brightness.light; // Return the light mode brightness
    } else {
      return Brightness.dark; // Default: Return the dark mode brightness
    }
  }

  /// Gets the radius values based on the tokens.
  ZetaRadiiSemantics get radius => semantics.radii;

  /// Gets the spacing values based on the tokens.
  ZetaSpacingSemantics get spacing => semantics.size;

  @override
  bool updateShouldNotify(covariant Zeta oldWidget) {
    return oldWidget.contrast != contrast ||
        oldWidget.rounded != rounded ||
        oldWidget.brightness != brightness ||
        oldWidget.themeMode != themeMode ||
        oldWidget._customPrimitives != _customPrimitives ||
        oldWidget._customSemantics != _customSemantics;
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
      throw FlutterError.fromParts(
        [
          ErrorDescription('Unable to find Zeta in the widget tree.'),
          ErrorHint(
            'Ensure that the context passed to Zeta.of() is a descendant of a ZetaProvider widget. This usually means that ZetaProviderState should be an ancestor of the widget which uses this context.',
          ),
          ErrorSpacer(),
          ErrorDescription('The widget for the context used was:'),
          DiagnosticsProperty<Widget>('widget', context.widget, showName: false),
          ErrorSpacer(),
          ErrorHint(
            'If you recently changed the type of that widget, or the widget tree, ensure the ZetaProvider widget is still an ancestor.',
          ),
        ],
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<ZetaColorSemantics>('colors', colors))
      ..add(EnumProperty<Brightness>('brightness', brightness))
      ..add(DiagnosticsProperty<ZetaRadiiSemantics>('radius', radius))
      ..add(DiagnosticsProperty<ZetaSpacingSemantics>('spacing', spacing))
      ..add(DiagnosticsProperty<ZetaPrimitives>('primitives', primitives))
      ..add(DiagnosticsProperty<ZetaSemantics>('semantics', semantics))
      ..add(EnumProperty<ZetaContrast>('contrast', contrast))
      ..add(EnumProperty<ThemeMode>('themeMode', themeMode));
  }
}
