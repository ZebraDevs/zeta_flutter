import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// A typedef for the ZetaAppBuilder function which passes [BuildContext], [ZetaThemeData],
/// and [ThemeMode] and returns a [Widget].
typedef ZetaAppBuilder = Widget Function(BuildContext context, ZetaThemeData themeData, ThemeMode themeMode);

/// A typedef for the ZetaAppBuilder function which passes [BuildContext], light [ThemeData],
/// dark [ThemeData] and [ThemeMode] and returns a [Widget].
typedef ZetaBaseAppBuilder = Widget Function(
  BuildContext context,
  ThemeData light,
  ThemeData dark,
  ThemeMode themeMode,
);

Nothing _emptyBuilder(dynamic _, dynamic __, dynamic ___) => const Nothing();

Nothing _emptyBase(dynamic _, dynamic __, dynamic ___, dynamic ____) => const Nothing();

/// A widget that provides Zeta theming and contrast data down the widget tree.
/// {@category Utils}
class ZetaProvider extends StatefulWidget with Diagnosticable {
  /// Constructs a [ZetaProvider] widget.
  ///
  /// The [builder] argument is required. The [initialThemeMode], [initialContrast],
  /// and [initialThemeData] arguments provide initial values.
  ZetaProvider({
    super.key,
    required this.builder,
    this.initialThemeMode = ThemeMode.system,
    this.initialContrast = ZetaContrast.aa,
    ZetaThemeData? initialThemeData,
    this.themeService,
    this.initialRounded = true,
  })  : initialZetaThemeData = initialThemeData ?? ZetaThemeData(),
        baseBuilder = _emptyBase,
        initialLightThemeData = null,
        initialDarkThemeData = null;

  /// ZetaProvider constructor that returns light and dark [ThemeData]s ready to be consumed.
  ///
  /// The [builder] argument is required. The [initialThemeMode], [initialContrast],
  /// and [initialLightThemeData] arguments provide initial values.
  ZetaProvider.base({
    super.key,
    required ZetaBaseAppBuilder builder,
    this.initialThemeMode = ThemeMode.system,
    this.initialContrast = ZetaContrast.aa,
    ZetaThemeData? initialZetaThemeData,
    this.initialLightThemeData,
    this.initialDarkThemeData,
    this.initialRounded = true,
  })  : baseBuilder = builder,
        initialZetaThemeData = initialZetaThemeData ?? ZetaThemeData(),
        builder = _emptyBuilder,
        themeService = null;

  /// Specifies the initial theme mode for the app.
  ///
  /// It can be one of the values: [ThemeMode.system], [ThemeMode.light], or [ThemeMode.dark].
  /// Defaults to [ThemeMode.system].
  final ThemeMode initialThemeMode;

  /// Provides the initial theme data for the app.
  ///
  /// This contains all the theming information. If not provided,
  /// it defaults to a basic [ZetaThemeData] instance.
  final ZetaThemeData initialZetaThemeData;

  /// Specifies the initial contrast setting for the app.
  ///
  /// Defaults to [ZetaContrast.aa].
  final ZetaContrast initialContrast;

  /// A builder function to construct the widget tree using the provided theming information.
  ///
  /// It receives the [BuildContext], [ZetaThemeData], and [ThemeMode] as arguments
  /// and is expected to return a [Widget].
  final ZetaAppBuilder builder;

  /// A builder function to construct the widget tree using the provided theming information.
  ///
  /// This builder returns light and dark [ThemeData]s ready to be consumed.
  final ZetaBaseAppBuilder baseBuilder;

  /// A `ZetaThemeService`
  ///
  /// It provides the structure for loading and saving themes in Zeta application.
  final ZetaThemeService? themeService;

  /// Light [ThemeData] used in [ZetaProvider.base] constructor as the foundation for a custom theme.
  final ThemeData? initialLightThemeData;

  /// Dark [ThemeData] used in [ZetaProvider.base] constructor as the foundation for a custom theme.
  final ThemeData? initialDarkThemeData;

  /// Sets whether app should start with components in their rounded or sharp variants.
  final bool initialRounded;

  @override
  State<ZetaProvider> createState() => ZetaProviderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaThemeData>('themeData', initialZetaThemeData))
      ..add(ObjectFlagProperty<ZetaAppBuilder>.has('builder', builder))
      ..add(EnumProperty<ThemeMode>('initialThemeMode', initialThemeMode))
      ..add(EnumProperty<ZetaContrast>('initialContrast', initialContrast))
      ..add(DiagnosticsProperty<ZetaThemeService?>('themeService', themeService))
      ..add(ObjectFlagProperty<ZetaBaseAppBuilder?>.has('customBuilder', baseBuilder))
      ..add(DiagnosticsProperty<ThemeData?>('initialThemeData', initialLightThemeData))
      ..add(DiagnosticsProperty<bool?>('initialRounded', initialRounded))
      ..add(DiagnosticsProperty<ThemeData?>('initialDarkThemeData', initialDarkThemeData));
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
/// {@category Utils}
class ZetaProviderState extends State<ZetaProvider> with Diagnosticable, WidgetsBindingObserver {
  // Fields for ZetaThemeManager.

  /// Represents the late initialization of the ZetaContrast value.
  late ZetaContrast _contrast;

  /// Represents the late initialization of the ThemeMode value.
  late ThemeMode _themeMode;

  /// Represents the late initialization of the ZetaThemeData object.
  late ZetaThemeData _zetaThemeData;

  /// Represents the late initialization of the system's current brightness (dark or light mode).
  late Brightness _platformBrightness;

  /// {@macro zeta-component-rounded}
  late bool _rounded;

  /// Represents the late initialization of the light [ThemeData] object.
  late ThemeData? _lightThemeData;

  /// Represents the late initialization of the dark [ThemeData] object.
  late ThemeData? _darkThemeData;

  /// Represents a nullable brightness value to be used for brightness change debouncing.
  Brightness? _debounceBrightness;

  /// Timer used for debouncing brightness changes.
  Timer? _debounceTimer;

  /// Represents the duration for the debounce timer.
  static const _debounceDuration = Duration(milliseconds: 250);

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

    // Sets the initial rounded.
    _rounded = widget.initialRounded;

    // Apply the initial contrast to the theme data.
    _zetaThemeData = widget.initialZetaThemeData.apply(contrast: _contrast);

    // Set the initial light [ThemeData].
    _lightThemeData = widget.initialLightThemeData;

    // Set the initial light [ThemeData].
    _darkThemeData = widget.initialDarkThemeData;
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

    // Get the binding instance
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Get the platform brightness from the PlatformDispatcher
    // `_debounceBrightness` will then hold the new brightness
    _debounceBrightness = binding.platformDispatcher.platformBrightness;

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
    if (widget.baseBuilder != _emptyBase) {
      return Zeta(
        themeMode: _themeMode,
        themeData: _zetaThemeData,
        contrast: _contrast,
        mediaBrightness: _platformBrightness,
        rounded: _rounded,
        child: widget.baseBuilder(
          context,
          generateZetaTheme(
            brightness: Brightness.light,
            existingTheme: _lightThemeData,
            colorScheme: _lightThemeData?.colorScheme ?? _zetaThemeData.colorsLight.toScheme(),
          ),
          generateZetaTheme(
            brightness: Brightness.dark,
            existingTheme: _darkThemeData,
            colorScheme: _darkThemeData?.colorScheme ?? _zetaThemeData.colorsDark.toScheme(),
          ),
          _themeMode,
        ),
      );
    }

    return Zeta(
      themeMode: _themeMode,
      themeData: _zetaThemeData,
      contrast: _contrast,
      rounded: _rounded,
      mediaBrightness: _platformBrightness,
      child: widget.builder(context, _zetaThemeData, _themeMode),
    );
  }

  @override
  void didUpdateWidget(ZetaProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialContrast != widget.initialContrast ||
        oldWidget.initialThemeMode != widget.initialThemeMode ||
        oldWidget.initialLightThemeData != widget.initialLightThemeData ||
        oldWidget.initialZetaThemeData != widget.initialZetaThemeData ||
        oldWidget.initialRounded != widget.initialRounded) {
      setState(() {
        _themeMode = widget.initialThemeMode;
        _contrast = widget.initialContrast;
        _zetaThemeData = widget.initialZetaThemeData.apply(contrast: _contrast);
        _lightThemeData = widget.initialLightThemeData;
        _rounded = widget.initialRounded;
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
      _zetaThemeData = data.apply(contrast: _contrast);
      _saveThemeChange();
    });
  }

  /// Updates the current contrast.
  void updateContrast(ZetaContrast contrast) {
    setState(() {
      _contrast = contrast;
      _zetaThemeData = _zetaThemeData.apply(contrast: contrast);
      _saveThemeChange();
    });
  }

  /// Updates the current rounded.
  // ignore: avoid_positional_boolean_parameters
  void updateRounded(bool rounded) {
    setState(() {
      _rounded = rounded;
      _saveThemeChange();
    });
  }

  void _saveThemeChange() {
    unawaited(
      widget.themeService?.saveTheme(
        themeData: _zetaThemeData,
        themeMode: _themeMode,
        contrast: _contrast,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaThemeData>('themeData', _zetaThemeData))
      ..add(EnumProperty<ZetaContrast>('contrast', _contrast))
      ..add(EnumProperty<ThemeMode>('themeMode', _themeMode));
  }
}

/// Creates a variant of [ThemeData] with added [Zeta] styles.
ThemeData generateZetaTheme({
  required Brightness brightness,
  required ColorScheme colorScheme,
  ThemeData? existingTheme,
  String? fontFamily,
  ZetaThemeData? zetaThemeData,
}) {
  if (existingTheme != null) {
    final baseThemeData = ThemeData();

    // Apply the Zeta styles to the existing theme, ignoring fields that are the same as the default ThemeData.
    return ThemeData(
      brightness: brightness,
      useMaterial3: existingTheme.useMaterial3,
      fontFamily: fontFamily ??
          (existingTheme.textTheme.bodyMedium?.fontFamily == baseThemeData.textTheme.bodyMedium?.fontFamily
              ? kZetaFontFamily
              : existingTheme.textTheme.bodyMedium?.fontFamily),
      scaffoldBackgroundColor: [
        Colors.grey[850]!,
        Colors.grey[50]!,
        baseThemeData.scaffoldBackgroundColor,
        baseThemeData.colorScheme.surface,
      ].any((e) => e == existingTheme.scaffoldBackgroundColor)
          ? colorScheme.surfaceTertiary
          : existingTheme.scaffoldBackgroundColor,
      colorScheme:
          ((existingTheme.colorScheme == baseThemeData.colorScheme ? null : existingTheme.colorScheme) ?? colorScheme)
              .copyWith(brightness: brightness),
      textTheme: (existingTheme.textTheme == baseThemeData.textTheme ? null : existingTheme.textTheme) ?? zetaTextTheme,
      iconTheme: (existingTheme.iconTheme == baseThemeData.iconTheme ? null : existingTheme.iconTheme) ??
          const IconThemeData(size: kZetaIconSize),
      actionIconTheme: existingTheme.actionIconTheme,
      applyElevationOverlayColor: existingTheme.applyElevationOverlayColor,
      cupertinoOverrideTheme: existingTheme.cupertinoOverrideTheme,
      inputDecorationTheme: existingTheme.inputDecorationTheme,
      materialTapTargetSize: existingTheme.materialTapTargetSize,
      pageTransitionsTheme: existingTheme.pageTransitionsTheme,
      platform: existingTheme.platform,
      scrollbarTheme: existingTheme.scrollbarTheme,
      splashFactory: existingTheme.splashFactory,
      visualDensity: existingTheme.visualDensity,
      canvasColor: existingTheme.canvasColor,
      cardColor: existingTheme.cardColor,
      disabledColor: existingTheme.disabledColor,
      dividerColor: existingTheme.dividerColor,
      focusColor: existingTheme.focusColor,
      highlightColor: existingTheme.highlightColor,
      hintColor: existingTheme.hintColor,
      hoverColor: existingTheme.hoverColor,
      primaryColor: existingTheme.primaryColor,
      primaryColorDark: existingTheme.primaryColorDark,
      primaryColorLight: existingTheme.primaryColorLight,
      secondaryHeaderColor: existingTheme.secondaryHeaderColor,
      shadowColor: existingTheme.shadowColor,
      splashColor: existingTheme.splashColor,
      unselectedWidgetColor: existingTheme.unselectedWidgetColor,
      primaryIconTheme: existingTheme.primaryIconTheme,
      primaryTextTheme: existingTheme.primaryTextTheme,
      typography: existingTheme.typography,
      appBarTheme: existingTheme.appBarTheme,
      badgeTheme: existingTheme.badgeTheme,
      bannerTheme: existingTheme.bannerTheme,
      bottomAppBarTheme: existingTheme.bottomAppBarTheme,
      bottomNavigationBarTheme: existingTheme.bottomNavigationBarTheme,
      bottomSheetTheme: existingTheme.bottomSheetTheme,
      buttonTheme: existingTheme.buttonTheme,
      cardTheme: existingTheme.cardTheme,
      checkboxTheme: existingTheme.checkboxTheme,
      chipTheme: existingTheme.chipTheme,
      dataTableTheme: existingTheme.dataTableTheme,
      datePickerTheme: existingTheme.datePickerTheme,
      dialogTheme: existingTheme.dialogTheme,
      dividerTheme: existingTheme.dividerTheme,
      drawerTheme: existingTheme.drawerTheme,
      dropdownMenuTheme: existingTheme.dropdownMenuTheme,
      elevatedButtonTheme: existingTheme.elevatedButtonTheme,
      expansionTileTheme: existingTheme.expansionTileTheme,
      filledButtonTheme: existingTheme.filledButtonTheme,
      floatingActionButtonTheme: existingTheme.floatingActionButtonTheme,
      iconButtonTheme: existingTheme.iconButtonTheme,
      listTileTheme: existingTheme.listTileTheme,
      menuBarTheme: existingTheme.menuBarTheme,
      menuButtonTheme: existingTheme.menuButtonTheme,
      menuTheme: existingTheme.menuTheme,
      navigationBarTheme: existingTheme.navigationBarTheme,
      navigationDrawerTheme: existingTheme.navigationDrawerTheme,
      navigationRailTheme: existingTheme.navigationRailTheme,
      outlinedButtonTheme: existingTheme.outlinedButtonTheme,
      popupMenuTheme: existingTheme.popupMenuTheme,
      progressIndicatorTheme: existingTheme.progressIndicatorTheme,
      radioTheme: existingTheme.radioTheme,
      searchBarTheme: existingTheme.searchBarTheme,
      searchViewTheme: existingTheme.searchViewTheme,
      segmentedButtonTheme: existingTheme.segmentedButtonTheme,
      sliderTheme: existingTheme.sliderTheme,
      snackBarTheme: existingTheme.snackBarTheme,
      switchTheme: existingTheme.switchTheme,
      tabBarTheme: existingTheme.tabBarTheme,
      textButtonTheme: existingTheme.textButtonTheme,
      textSelectionTheme: existingTheme.textSelectionTheme,
      timePickerTheme: existingTheme.timePickerTheme,
      toggleButtonsTheme: existingTheme.toggleButtonsTheme,
      tooltipTheme: existingTheme.tooltipTheme,
    );
  }
  return ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily ?? kZetaFontFamily,
    brightness: brightness,
    scaffoldBackgroundColor: colorScheme.surfaceTertiary,
    colorScheme: colorScheme.copyWith(brightness: brightness),
    textTheme: zetaTextTheme,
    iconTheme: IconThemeData(
      size: kZetaIconSize,
      color: (zetaThemeData != null
          ? (brightness == Brightness.dark ? zetaThemeData.colorsDark : zetaThemeData.colorsLight).iconDefault
          : colorScheme.onSurface),
    ),
  );
}
