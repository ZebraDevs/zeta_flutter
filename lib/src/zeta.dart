// ignore_for_file: avoid_setters_without_getters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'theme/contrast.dart';
import 'theme/theme.dart';

/// An {@immutable} class that holds the contrast and theme mode settings.
///
/// This class is used to create a new instance of [ZetaDefaults] with
/// the provided contrast and theme mode settings.
/// If no settings are provided, the default ones are used.
class ZetaDefaults extends InheritedWidget {
  /// A [ZetaContrast] attribute that holds the current contrast setting.
  final ZetaContrast contrast;

  /// A [ThemeMode] attribute that holds the current theme mode setting.
  final ThemeMode themeMode;

  final ZetaThemeData themeData;

  ZetaColors get colors {
    if (themeMode == ThemeMode.light) {
      return themeData.colorsLight;
    } else {
      return themeData.colorsDark;
    }
  }

  ZetaDefaults({
    required this.contrast,
    required this.themeMode,
    required this.themeData,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant ZetaDefaults oldWidget) {
    return oldWidget.contrast != contrast || oldWidget.themeMode != themeMode || oldWidget.themeData != themeData;
  }

  static ZetaDefaults of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ZetaDefaults>()!;
  }
}

/// A typedef for the ZetaAppBuilder function.
typedef ZetaAppBuilder = Widget Function(BuildContext, ZetaThemeData, ThemeMode);

/// Zeta is a StatefulWidget which builds the app based on the [ZetaThemeData] and theme mode.
class Zeta extends StatefulWidget with Diagnosticable {
  /// ZetaThemeData provides the base styling for the app.
  final ZetaThemeData themeData;

  /// ZetaAppBuilder function is the function which build the app.
  final ZetaAppBuilder builder;

  /// Constructor for the Zeta StatefulWidget.
  Zeta({required this.builder, ZetaThemeData? themeData, super.key}) : themeData = themeData ?? ZetaThemeData();

  /// Create immutable state for this widget.
  @override
  State<Zeta> createState() => ZetaState();

  /// Diagnostic information for debugging.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZetaThemeData>('themeData', themeData));
    properties.add(ObjectFlagProperty<ZetaAppBuilder>.has('builder', builder));
  }

  /// Fetches the [ZetaState] from the given [context].
  ///
  /// Throws a [FlutterError] if the [ZetaState] is not found in the widget tree.
  static ZetaState of(BuildContext context) {
    final zetaState = context.findAncestorStateOfType<ZetaState>();
    if (zetaState != null) {
      return zetaState;
    } else {
      throw FlutterError.fromParts(
        [
          ErrorDescription('Unable to find ZetaState in the widget tree.'),
          ErrorHint(
            'Ensure that the context passed to ZetaState.of() is a descendant of a ZetaState widget. This usually means that ZetaState should be an ancestor of the widget which uses this context.',
          ),
          ErrorSpacer(),
          ErrorDescription('The widget for the context used was:'),
          DiagnosticsProperty<Widget>('widget', context.widget, showName: false),
          ErrorSpacer(),
          ErrorHint(
            'If you recently changed the type of that widget, or the widget tree, ensure the ZetaState widget is still an ancestor.',
          ),
        ],
      );
    }
  }
}

/// ZetaState is a mutable state for the Zeta StatefulWidget.
class ZetaState extends State<Zeta> with Diagnosticable {
  /// A [ZetaContrast] attribute that holds the current contrast setting.
  ZetaContrast _contrast = ZetaContrast.aa;

  /// A [ThemeMode] attribute that holds the current theme mode setting.
  ThemeMode _themeMode = ThemeMode.system;

  /// Root theme data for the Zeta App
  late ZetaThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _themeData = widget.themeData.apply(contrast: _contrast);
  }

  /// Returns the widget which defines this component.
  @override
  Widget build(BuildContext context) {
    return ZetaDefaults(
      themeMode: _themeMode,
      themeData: _themeData,
      contrast: _contrast,
      child: widget.builder(context, _themeData, _themeMode),
    );
  }

  void updateThemeMode(ThemeMode themeMode) {
    setState(() {
      this._themeMode = themeMode;
    });
  }

  void updateContrast(ZetaContrast contrast) {
    setState(() {
      this._contrast = contrast;
      _themeData = _themeData.apply(contrast: contrast);
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZetaThemeData>('themeData', _themeData));
    properties.add(EnumProperty<ZetaContrast>('contrast', _contrast));
    properties.add(EnumProperty<ThemeMode>('themeMode', _themeMode));
    properties.add(DiagnosticsProperty<ZetaThemeData>('themeData', _themeData));
  }
}
