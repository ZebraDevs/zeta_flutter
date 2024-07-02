import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme/contrast.dart';
import 'theme/theme_data.dart';

/// An [InheritedWidget] that provides access to Zeta theme settings.
///
/// It holds information about the current contrast, theme mode, and theme data.
/// The [colors] getter provides the correct color set based on the current theme mode.
class Zeta extends InheritedWidget {
  /// Constructs a [Zeta] widget.
  ///
  /// The [contrast], [themeMode], [themeData], and [child] arguments are required.
  const Zeta({
    super.key,
    required Brightness mediaBrightness,
    required this.contrast,
    required this.themeMode,
    required this.themeData,
    required super.child,
    this.rounded = true,
  }) : _mediaBrightness = mediaBrightness;

  /// The current contrast setting for the app, which can be one of the predefined
  /// values in [ZetaContrast].
  final ZetaContrast contrast;

  /// Specifies the theme mode for the app, which determines how the UI is rendered.
  ///
  /// It can be one of the values: [ThemeMode.system], [ThemeMode.light], or [ThemeMode.dark].
  final ThemeMode themeMode;

  /// Provides the theme data for the app, which contains all the theming information.
  final ZetaThemeData themeData;

  /// Internal property to get the system brightness.
  /// Used to determine the theme mode when it's set to [ThemeMode.system].
  final Brightness _mediaBrightness;

  /// {@template zeta-component-rounded}
  /// Sets rounded or sharp border of the containing box and the icon style.
  ///
  /// Defaults to `true`.
  /// {@endtemplate}
  final bool rounded;

  /// Provides the color set based on the current theme mode.
  ///
  /// It determines the appropriate color set (light or dark) based on the theme mode
  /// and system brightness.
  ZetaColors get colors {
    if (themeMode == ThemeMode.system) {
      return _mediaBrightness == Brightness.light ? themeData.colorsLight : themeData.colorsDark;
    } else if (themeMode == ThemeMode.light) {
      return themeData.colorsLight;
    } else {
      return themeData.colorsDark;
    }
  }

  /// Gets the brightness setting for the current theme.
  ///
  /// If the theme mode is set to 'system', it will return the brightness that ties with the device's system theme setting.
  /// If the theme mode is set to 'light', it always returns `Brightness.light`.
  /// If neither, it returns `Brightness.dark` by default (i.e., when the theme mode is 'dark').
  Brightness get brightness {
    if (themeMode == ThemeMode.system) {
      return _mediaBrightness; // Return the current system brightness setting
    } else if (themeMode == ThemeMode.light) {
      return Brightness.light; // Return the light mode brightness
    } else {
      return Brightness.dark; // Default: Return the dark mode brightness
    }
  }

  @override
  bool updateShouldNotify(covariant Zeta oldWidget) {
    return oldWidget.contrast != contrast ||
        oldWidget.themeMode != themeMode ||
        oldWidget.themeData != themeData ||
        oldWidget._mediaBrightness != _mediaBrightness;
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
      ..add(EnumProperty<ZetaContrast>('contrast', contrast))
      ..add(EnumProperty<ThemeMode>('themeMode', themeMode))
      ..add(DiagnosticsProperty<ZetaThemeData>('themeData', themeData))
      ..add(DiagnosticsProperty<ZetaColors>('colors', colors))
      ..add(EnumProperty<Brightness>('mediaBrightness', _mediaBrightness))
      ..add(EnumProperty<Brightness>('brightness', brightness))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}
