import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme/contrast.dart';
import 'theme/theme_data.dart';
import 'theme/theme_service.dart';

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
      ..add(EnumProperty<Brightness>('brightness', brightness));
  }
}

/// A typedef for the ZetaAppBuilder function which takes [BuildContext], [ZetaThemeData],
/// and [ThemeMode] and returns a [Widget].
typedef ZetaAppBuilder = Widget Function(BuildContext context, ZetaThemeData themeData, ThemeMode themeMode);

/// A widget that provides Zeta theming and contrast data down the widget tree.
class ZetaProvider extends StatefulWidget with Diagnosticable {
  /// Constructs a [ZetaProvider] widget.
  ///
  /// The [builder] argument is required. The [initialThemeMode], [initialContrast],
  /// and [initialThemeData] arguments provide initial values.
  ZetaProvider({
    required this.builder,
    this.initialThemeMode = ThemeMode.system,
    this.initialContrast = ZetaContrast.aa,
    this.themeService,
    ZetaThemeData? initialThemeData,
    super.key,
  }) : initialThemeData = initialThemeData ?? ZetaThemeData();

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

  /// A `ZetaThemeService`
  ///
  /// It provides the structure for loading and saving themes in Zeta application.
  final ZetaThemeService? themeService;

  @override
  State<ZetaProvider> createState() => ZetaProviderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaThemeData>('themeData', initialThemeData))
      ..add(ObjectFlagProperty<ZetaAppBuilder>.has('builder', builder))
      ..add(EnumProperty<ThemeMode>('initialThemeMode', initialThemeMode))
      ..add(EnumProperty<ZetaContrast>('initialContrast', initialContrast))
      ..add(DiagnosticsProperty<ZetaThemeService?>('themeService', themeService));
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
class ZetaProviderState extends State<ZetaProvider> with Diagnosticable, WidgetsBindingObserver {
  // Fields for ZetaThemeManager.

  /// Represents the late initialization of the ZetaContrast value.
  late ZetaContrast _contrast;

  /// Represents the late initialization of the ThemeMode value.
  late ThemeMode _themeMode;

  /// Represents the late initialization of the ZetaThemeData object.
  late ZetaThemeData _themeData;

  /// Represents the late initialization of the system's current brightness (dark or light mode).
  late Brightness _platformBrightness;

  /// Represents a nullable brightness value to be used for brightness change debouncing.
  Brightness? _debounceBrightness;

  /// Timer used for debouncing brightness changes.
  Timer? _debounceTimer;

  /// Represents the duration for the debounce timer.
  static const _debounceDuration = Duration(milliseconds: 500);

  /// This method is called when this object is inserted into the tree.
  ///
  /// Here, it also adds this object as an observer in [WidgetsBinding] instance
  /// and initializes various fields related to the theme, contrast, and brightness of the app.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Set the initial brightness with the system's current brightness from the first view of the platform dispatcher.
    _platformBrightness = MediaQueryData.fromView(PlatformDispatcher.instance.views.first).platformBrightness;

    // Set the initial theme mode.
    _themeMode = widget.initialThemeMode;

    // Set the initial contrast.
    _contrast = widget.initialContrast;

    // Apply the initial contrast to the theme data.
    _themeData = widget.initialThemeData.apply(contrast: _contrast);
  }

  /// Clean up function to be called when this object is removed from the tree.
  ///
  /// This also removes this object as an observer from the [WidgetsBinding] instance.
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Overrides the [didChangePlatformBrightness] method from the parent class.
  ///
  /// This method gets information about the platform's brightness and updates the app if it ever changes.
  /// The changes are debounced with a timer to avoid them being too frequent.
  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    // Get the platform brightness from the first view of the platform dispatcher
    // `_debounceBrightness` will then hold the new brightness
    _debounceBrightness = MediaQueryData.fromView(PlatformDispatcher.instance.views.first).platformBrightness;

    // If the current stored brightness value is different from the newly fetched value
    if (_platformBrightness != _debounceBrightness) {
      // If brightness has changed, cancel the existing timer and start a new one

      // Cancel existing timer if any
      _debounceTimer?.cancel();

      // Start a new timer with `_debounceDuration` delay
      _debounceTimer = Timer(_debounceDuration, () {
        // Once timer fires, check if brightness is still different and not null
        if (_debounceBrightness != null && _platformBrightness != _debounceBrightness) {
          // If brightness value has indeed changed, update the state
          setState(() {
            // Set the new brightness value
            _platformBrightness = _debounceBrightness!;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Zeta(
      themeMode: _themeMode,
      themeData: _themeData,
      contrast: _contrast,
      mediaBrightness: _platformBrightness,
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
      _saveThemeChange();
    });
  }

  /// Updates the current theme data.
  void updateThemeData(ZetaThemeData data) {
    setState(() {
      _themeData = data.apply(contrast: _contrast);
      _saveThemeChange();
    });
  }

  /// Updates the current contrast.
  void updateContrast(ZetaContrast contrast) {
    setState(() {
      _contrast = contrast;
      _themeData = _themeData.apply(contrast: contrast);
      _saveThemeChange();
    });
  }

  void _saveThemeChange() {
    unawaited(
      widget.themeService?.saveTheme(
        themeData: _themeData,
        themeMode: _themeMode,
        contrast: _contrast,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaThemeData>('themeData', _themeData))
      ..add(EnumProperty<ZetaContrast>('contrast', _contrast))
      ..add(EnumProperty<ThemeMode>('themeMode', _themeMode));
  }
}
