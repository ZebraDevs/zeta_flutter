import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'color_extensions.dart';
import 'constants.dart';
import 'contrast.dart';
import 'custom_theme.dart';
import 'generated/tokens/primitives.g.dart';
import 'theme_service.dart';
import 'typography.dart';
import 'zeta.dart';

/// A typedef for the ZetaAppBuilder function which passes [BuildContext], light [ThemeData],
/// dark [ThemeData] and [ThemeMode] and returns a [Widget].
///
/// This function is used to build the app with the provided theming information.
///
typedef ZetaAppBuilder = Widget Function(
  BuildContext context,
  ThemeData light,
  ThemeData dark,
  ThemeMode themeMode,
);

/// A widget that provides Zeta theming and contrast data down the widget tree.
class ZetaProvider extends StatefulWidget with Diagnosticable {
  /// Constructs a [ZetaProvider] widget.
  ///
  /// The [builder] argument is required. The [initialThemeMode], [initialContrast],
  ZetaProvider({
    super.key,
    required this.builder,
    this.initialThemeMode,
    this.initialContrast,
    this.themeService = const ZetaDefaultThemeService(),
    this.initialRounded = true,
    this.customThemes = const [],
    this.initialTheme,
    this.customLoadingWidget,
    this.fontFamily,
    this.customTextColor,
  });

  /// Specifies the initial theme mode for the app.
  ///
  /// It can be one of the values: [ThemeMode.system], [ThemeMode.light], or [ThemeMode.dark].
  /// Defaults to [ThemeMode.system].
  final ThemeMode? initialThemeMode;

  /// Specifies the initial contrast setting for the app.
  ///
  /// Defaults to [ZetaContrast.aa].
  final ZetaContrast? initialContrast;

  /// A builder function to construct the widget tree using the provided theming information.
  final ZetaAppBuilder builder;

  /// A `ZetaThemeService`
  ///
  /// It provides the structure for loading and saving themes in Zeta application.
  final ZetaThemeService themeService;

  /// Sets whether app should start with components in their rounded or sharp variants.
  final bool initialRounded;

  /// A list of custom themes to be used in the app.
  final List<ZetaCustomTheme> customThemes;

  /// Specifies the id of the initial custom theme to be used in the app.
  final String? initialTheme;

  /// A custom loading widget to be displayed while the theme is being loaded.
  final Widget? customLoadingWidget;

  /// A custom font to be used in the app.
  ///
  /// The default font is IBM Plex Sans.
  final String? fontFamily;

  /// A custom text color to be used in the app.
  ///
  /// Leave as null to use the default text color.
  final Color? customTextColor;

  @override
  State<ZetaProvider> createState() => ZetaProviderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<ZetaAppBuilder>.has('builder', builder))
      ..add(EnumProperty<ThemeMode>('initialThemeMode', initialThemeMode))
      ..add(EnumProperty<ZetaContrast>('initialContrast', initialContrast))
      ..add(DiagnosticsProperty<ZetaThemeService?>('themeService', themeService))
      ..add(DiagnosticsProperty<bool?>('initialRounded', initialRounded))
      ..add(IterableProperty<ZetaCustomTheme>('customThemes', customThemes))
      ..add(StringProperty('initialTheme', initialTheme))
      ..add(StringProperty('fontFamily', fontFamily))
      ..add(ColorProperty('customTextColor', customTextColor));
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
  bool _gotTheme = false;

  /// Represents the late initialization of the ZetaContrast value.
  late ZetaContrast _contrast;

  /// Represents the late initialization of the ThemeMode value.
  late ThemeMode _themeMode;

  Map<String, ZetaCustomTheme> _customThemes = {};

  /// The list of custom themes in the app
  List<ZetaCustomTheme> get customThemes => _customThemes.values.toList();

  ZetaCustomTheme? _customTheme;

  /// Represents the late initialization of the system's current brightness (dark or light mode).
  late Brightness _platformBrightness;

  /// {@macro zeta-component-rounded}
  late bool _rounded;

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

    // Sets the initial rounded.
    _rounded = widget.initialRounded;

    setCustomThemes(widget.customThemes);

    _customTheme = _customThemes[widget.initialTheme];

    if (widget.initialThemeMode != null) {
      _themeMode = widget.initialThemeMode!;
    }
    if (widget.initialContrast != null) {
      _contrast = widget.initialContrast!;
    }
  }

  /// Sets the custom themes in the app.
  void setCustomThemes(List<ZetaCustomTheme> themes) {
    setState(() {
      _customThemes = Map.fromEntries(themes.map((theme) => MapEntry(theme.id, theme)));
    });
  }

  /// Retrieves the theme values from the shared preferences.
  Future<void> getThemeValuesFromPreferences() async {
    final ZetaThemeServiceData themeServiceData = await widget.themeService.loadTheme();

    // Set the initial theme mode.
    _themeMode = widget.initialThemeMode ?? themeServiceData.themeMode ?? ThemeMode.system;

    // Set the initial contrast.
    _contrast = widget.initialContrast ?? themeServiceData.contrast ?? ZetaContrast.aa;

    final loadedTheme = _customThemes[themeServiceData.themeId ?? widget.initialTheme];

    if (loadedTheme != null) {
      _customTheme = loadedTheme;
    }

    // Ensure this is only triggered once.
    _gotTheme = true;
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
    if ((widget.initialContrast != null &&
            widget.initialThemeMode != null &&
            (widget.customThemes.isEmpty || _customThemes[widget.initialTheme] != null)) ||
        _gotTheme) {
      return _getChild();
    }

    return FutureBuilder<dynamic>(
      //  Ignore this lint as the async is performed in FutureBuilder
      future: getThemeValuesFromPreferences(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.customLoadingWidget ?? const Center(child: CircularProgressIndicator());
        }

        return _getChild();
      },
    );
  }

  Widget _getChild() {
    return InternalProvider(
      contrast: _contrast,
      themeMode: _themeMode,
      rounded: _rounded,
      widget: widget.builder,
      customTheme: _customTheme,
      customThemes: customThemes,
      fontFamily: widget.fontFamily ?? kZetaFontFamily,
      customTextColor: widget.customTextColor,
    );
  }

  @override
  void didUpdateWidget(ZetaProvider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialContrast != widget.initialContrast ||
        oldWidget.initialThemeMode != widget.initialThemeMode ||
        oldWidget.initialRounded != widget.initialRounded) {
      setState(() {
        _themeMode = widget.initialThemeMode ?? _themeMode;
        _contrast = widget.initialContrast ?? _contrast;
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

  /// Updates the current custom theme.
  /// The id of the theme must correspond to a [ZetaCustomTheme] object in the [customThemes] list.
  /// If [themeId] is null or a corresponding theme cannot be found, the default theme is used.
  void updateCustomTheme({
    required String? themeId,
  }) {
    setState(() {
      _customTheme = _customThemes[themeId];
      _saveThemeChange();
    });
  }

  /// Updates the current contrast.
  void updateContrast(ZetaContrast contrast) {
    setState(() {
      _contrast = contrast;
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
      widget.themeService.saveTheme(
        themeData: ZetaThemeServiceData(
          themeMode: _themeMode,
          contrast: _contrast,
          themeId: _customTheme?.id,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaContrast>('contrast', _contrast))
      ..add(EnumProperty<ThemeMode>('themeMode', _themeMode))
      ..add(IterableProperty<ZetaCustomTheme>('customThemes', customThemes))
      ..add(DiagnosticsProperty<ZetaCustomTheme?>('customTheme', _customTheme));
  }
}

/// Provider used within ZetaProvider, placed within FutureBuilder to allow time for theme data to be pulled from async function
///
/// For internal use only.
@visibleForTesting
class InternalProvider extends StatefulWidget {
  /// Constructs an [InternalProvider].
  ///
  /// For internal use only.

  @visibleForTesting
  const InternalProvider({
    super.key,
    required this.contrast,
    required this.themeMode,
    required this.rounded,
    required this.widget,
    required this.customTheme,
    required this.customThemes,
    required this.fontFamily,
    this.customTextColor,
  });

  ///  Current custom theme.
  final ZetaCustomTheme? customTheme;

  /// List of all custom themes.
  final List<ZetaCustomTheme> customThemes;

  /// Represents the late initialization of the ZetaContrast value.
  final ZetaContrast contrast;

  /// Current theme mode.
  final ThemeMode themeMode;

  /// Current rounded value.
  final bool rounded;

  /// Builder
  final ZetaAppBuilder widget;

  /// A font to be used in the app.
  final String fontFamily;

  /// A custom text color to be used in the app.
  ///
  /// Leave as null to use the default text color.
  final Color? customTextColor;

  @override
  State<InternalProvider> createState() => InternalProviderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ThemeMode>('themeMode', themeMode))
      ..add(EnumProperty<ZetaContrast>('contrast', contrast))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<ZetaAppBuilder>.has('widget', widget))
      ..add(DiagnosticsProperty<ZetaCustomTheme?>('customTheme', customTheme))
      ..add(IterableProperty<ZetaCustomTheme>('customThemes', customThemes))
      ..add(StringProperty('fontFamily', fontFamily))
      ..add(ColorProperty('customTextColor', customTextColor));
  }
}

/// State for [InternalProvider].
///
/// For internal use only.
@visibleForTesting
class InternalProviderState extends State<InternalProvider> {
  @override
  Widget build(BuildContext context) {
    final textStyles = ZetaTextStyle(fontFamily: widget.fontFamily);
    return Zeta(
      themeMode: widget.themeMode,
      contrast: widget.contrast,
      customThemeId: widget.customTheme?.id,
      rounded: widget.rounded,
      textStyles: textStyles,
      customPrimitives: widget.themeMode.isDark
          ? ZetaPrimitivesDark(
              primary: widget.customTheme?.primaryDark,
              secondary: widget.customTheme?.secondaryDark,
            )
          : ZetaPrimitivesLight(
              primary: widget.customTheme?.primary,
              secondary: widget.customTheme?.secondary,
            ),
      child: Builder(
        builder: (context) {
          return widget.widget(
            context,
            generateZetaTheme(
              brightness: Brightness.light,
              colorScheme: Zeta.of(context).colors.toColorScheme,
              fontFamily: widget.fontFamily,
              textTheme: textStyles.textTheme,
            ),
            generateZetaTheme(
              brightness: Brightness.dark,
              colorScheme: Zeta.of(context).colors.toColorScheme,
              fontFamily: widget.fontFamily,
              textTheme: textStyles.textTheme,
            ),
            widget.themeMode,
          );
        },
      ),
    );
  }
}

/// Creates a variant of [ThemeData] with added [Zeta] styles.
@visibleForTesting
ThemeData generateZetaTheme({
  required Brightness brightness,
  required ColorScheme colorScheme,
  ThemeData? existingTheme,
  String? fontFamily,
  required TextTheme textTheme,
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
      scaffoldBackgroundColor: existingTheme.scaffoldBackgroundColor,
      colorScheme:
          ((existingTheme.colorScheme == baseThemeData.colorScheme ? null : existingTheme.colorScheme) ?? colorScheme)
              .copyWith(brightness: brightness),
      textTheme: (existingTheme.textTheme == baseThemeData.textTheme ? null : existingTheme.textTheme) ?? textTheme,
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
    colorScheme: colorScheme.copyWith(brightness: brightness),
    textTheme: textTheme,
    iconTheme: const IconThemeData(size: kZetaIconSize),
  );
}
