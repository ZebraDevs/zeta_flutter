// ignore_for_file: avoid_setters_without_getters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme/contrast.dart';
import 'theme/theme.dart';

/// An [InheritedWidget] that provides access to Zeta theme settings.
///
/// It holds information about the current contrast, theme mode, and theme data.
/// The [colors] getter provides the correct color set based on the current theme mode.
class Zeta extends InheritedWidget {
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
  final Brightness mediaBrightness;

  /// Provides the color set based on the current theme mode.
  ///
  /// It determines the appropriate color set (light or dark) based on the theme mode
  /// and system brightness.
  ZetaColors get colors {
    if (themeMode == ThemeMode.light) {
      return themeData.colorsLight;
    } else {
      return themeData.colorsDark;
    }
  }

  /// Constructs a [Zeta] widget.
  ///
  /// The [contrast], [themeMode], [themeData], and [child] arguments are required.
  const Zeta({
    super.key,
    required this.mediaBrightness,
    required this.contrast,
    required this.themeMode,
    required this.themeData,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant Zeta oldWidget) {
    return oldWidget.contrast != contrast || oldWidget.themeMode != themeMode || oldWidget.themeData != themeData;
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
    properties.add(EnumProperty<ZetaContrast>('contrast', contrast));
    properties.add(EnumProperty<ThemeMode>('themeMode', themeMode));
    properties.add(DiagnosticsProperty<ZetaThemeData>('themeData', themeData));
    properties.add(DiagnosticsProperty<ZetaColors>('colors', colors));
    properties.add(EnumProperty<Brightness>('mediaBrightness', mediaBrightness));
  }
}

/// A typedef for the ZetaAppBuilder function which takes [BuildContext], [ZetaThemeData],
/// and [ThemeMode] and returns a [Widget].
typedef ZetaAppBuilder = Widget Function(BuildContext, ZetaThemeData, ThemeMode);

/// A widget that provides Zeta theming and contrast data down the widget tree.
class ZetaProvider extends StatefulWidget with Diagnosticable {
  /// Specifies the initial theme mode for the app.
  ///
  /// It can be one of the values: [ThemeMode.system], [ThemeMode.light], or [ThemeMode.dark].
  /// Defaults to [ThemeMode.system].
  final ThemeMode initialThemeMode;

  /// Provides the initial theme data for the app.
  ///
  /// This contains all the theming information. If not provided,
  /// it defaults to a basic [ZetaThemeData] instance.
  final ZetaThemeData initialThemeData;

  /// Specifies the initial contrast setting for the app.
  ///
  /// Defaults to [ZetaContrast.aa].
  final ZetaContrast initialContrast;

  /// A builder function to construct the widget tree using the provided theming information.
  ///
  /// It receives the [BuildContext], [ZetaThemeData], and [ThemeMode] as arguments
  /// and is expected to return a [Widget].
  final ZetaAppBuilder builder;

  /// Constructs a [ZetaProvider] widget.
  ///
  /// The [builder] argument is required. The [initialThemeMode], [initialContrast],
  /// and [themeData] arguments provide initial values.
  ZetaProvider({
    required this.builder,
    this.initialThemeMode = ThemeMode.system,
    this.initialContrast = ZetaContrast.aa,
    ZetaThemeData? themeData,
    super.key,
  }) : initialThemeData = themeData ?? ZetaThemeData();

  @override
  State<ZetaProvider> createState() => ZetaProviderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZetaThemeData>('themeData', initialThemeData));
    properties.add(ObjectFlagProperty<ZetaAppBuilder>.has('builder', builder));
    properties.add(EnumProperty<ThemeMode>('initialThemeMode', initialThemeMode));
    properties.add(EnumProperty<ZetaContrast>('initialContrast', initialContrast));
  }

  /// Retrieves the [ZetaProviderState] from the provided context.
  static ZetaProviderState of(BuildContext context) {
    final zetaState = context.findAncestorStateOfType<ZetaProviderState>();
    if (zetaState != null) {
      return zetaState;
    } else {
      throw FlutterError.fromParts(
        [
          ErrorDescription('Unable to find ZetaProviderState in the widget tree.'),
          ErrorHint(
            'Ensure that the context passed to ZetaProvider.of() is a descendant of a ZetaProvider widget. This usually means that ZetaProviderState should be an ancestor of the widget which uses this context.',
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
}

/// The state associated with [ZetaProvider].
class ZetaProviderState extends State<ZetaProvider> with Diagnosticable {
  late ZetaContrast _contrast;
  late ThemeMode _themeMode;
  late ZetaThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
    _contrast = widget.initialContrast;
    _themeData = widget.initialThemeData.apply(contrast: _contrast);
  }

  @override
  Widget build(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      if (MediaQuery.of(context).platformBrightness == Brightness.light) {
        _themeMode = ThemeMode.light;
      } else {
        _themeMode = ThemeMode.dark;
      }
    }
    return Zeta(
      themeMode: _themeMode,
      themeData: _themeData,
      contrast: _contrast,
      mediaBrightness: MediaQuery.of(context).platformBrightness,
      child: widget.builder(context, _themeData, _themeMode),
    );
  }

  @override
  void didUpdateWidget(ZetaProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialContrast != widget.initialContrast ||
        oldWidget.initialThemeMode != widget.initialThemeMode ||
        oldWidget.initialThemeData != widget.initialThemeData) {
      setState(() {
        _themeMode = widget.initialThemeMode;
        _contrast = widget.initialContrast;
        _themeData = widget.initialThemeData.apply(contrast: _contrast);
      });
    }
  }

  /// Updates the current theme mode.
  void updateThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  /// Updates the current contrast.
  void updateContrast(ZetaContrast contrast) {
    setState(() {
      _contrast = contrast;
      _themeData = _themeData.apply(contrast: contrast);
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZetaThemeData>('themeData', _themeData));
    properties.add(EnumProperty<ZetaContrast>('contrast', _contrast));
    properties.add(EnumProperty<ThemeMode>('themeMode', _themeMode));
  }
}