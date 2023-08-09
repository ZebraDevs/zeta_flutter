import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../zeta_flutter.dart';

/// Wrapper widget for apps using zeta.
///
/// Please place this widget at the top level of the application.
/// Typically this would be wrapping a [MaterialApp], [WidgetsApp] or [CupertinoApp].
///
/// Without this widget in the tree, theming and colors may not work.
class Zeta extends StatefulWidget {
  /// Base theme for the app. Zeta styles will be applied on top of this.
  final ZetaThemeData? theme;

  /// Override for custom colors.
  final ZetaColors colors;

  /// Builder for the app.
  ///
  /// Returns theme and colors.
  final Widget Function(BuildContext, ThemeData, ZetaColors) builder;

  /// Constructor for [Zeta].
  const Zeta({required this.builder, this.theme, this.colors = const ZetaColors(), super.key});
  @override
  State<Zeta> createState() => ZetaState();
}

/// State for [Zeta].
class ZetaState extends State<Zeta> {
  ZetaColors _colors = const ZetaColors();
  GlobalKey _key = GlobalKey();
  ThemeData _theme = ThemeData();
  bool _ready = false;

  /// Colors for app.
  ///
  /// Access using `ZetaColors.of(context)`.
  ZetaColors get colors => _colors;

  /// Sets colors for app.
  ///
  /// Access using `ZetaColors.setColors(context, colors)`.
  ///
  /// When called, resets top-level key to force UI rebuild of app.
  set colors(ZetaColors value) {
    if (_colors != value) {
      setState(() {
        _colors = value;
        _key = GlobalKey();
        _theme = ZetaTheme.builder(initialTheme: (widget.theme ?? const ZetaThemeData()).copyWith(zetaColors: value));
      });
    }
  }

  @override
  void initState() {
    super.initState();

    colors = widget.colors;
    _theme = ZetaTheme.zetaLight(initialTheme: widget.theme);
    _ready = true;
  }

  @override
  void didUpdateWidget(Zeta oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colors != widget.colors) {
      colors = widget.colors;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_ready) {
      return Material(
        child: DefaultTextStyle(
          style: ZetaText.zetaBodyMedium.copyWith(
            decoration: TextDecoration.none,
          ),
          child: Theme(
            key: _key,
            data: _theme,
            child: Builder(builder: (context) => widget.builder(context, _theme, colors)),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
