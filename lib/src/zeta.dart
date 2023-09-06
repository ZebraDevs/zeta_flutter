import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

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
  final ZetaColors? colors;

  /// Builder for the app.
  ///
  /// Returns theme and colors.
  final Widget Function(BuildContext, ThemeData, ZetaColors) builder;

  /// Constructor for [Zeta].
  const Zeta({required this.builder, this.theme, this.colors, super.key});
  @override
  State<Zeta> createState() => ZetaState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZetaThemeData?>('theme', theme));
    properties.add(DiagnosticsProperty<ZetaColors?>('colors', colors));
    properties
        .add(ObjectFlagProperty<Widget Function(BuildContext p1, ThemeData p2, ZetaColors p3)>.has('builder', builder));
  }
}

/// State for [Zeta].
class ZetaState extends State<Zeta> {
  ZetaColors _colors = ZetaColors();
  late ThemeData _theme;
  late ZetaThemeData _zetaTheme;

  /// Theme used by zeta.
  ZetaThemeData get zetaTheme => _zetaTheme;
  set zetaTheme(ZetaThemeData value) {
    _zetaTheme = value;
    setState(() {
      _theme = ZetaTheme.builder(initialTheme: zetaTheme);
    });
  }

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
        _theme = ZetaTheme.builder(initialTheme: zetaTheme.copyWith(zetaColors: value));
      });
    }
  }

  @override
  void initState() {
    super.initState();

    zetaTheme = (widget.theme ?? const ZetaThemeData()).copyWith(zetaColors: colors);
    colors = widget.colors ?? ZetaColors();
    _ready = true;
  }

  @override
  void didUpdateWidget(Zeta oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.colors != widget.colors) {
      colors = widget.colors ?? ZetaColors();
      zetaTheme = (widget.theme ?? const ZetaThemeData()).copyWith(zetaColors: colors);
    }
    if (oldWidget.theme != widget.theme) {
      zetaTheme = (widget.theme ?? const ZetaThemeData()).copyWith(zetaColors: colors);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_ready) {
      return Theme(
        data: _theme,
        child: Builder(
          builder: (context) => widget.builder(context, _theme, colors),
        ),
      );
    }

    return const SizedBox();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ZetaColors>('colors', colors));
    properties.add(DiagnosticsProperty<ZetaThemeData>('zetaTheme', zetaTheme));
  }
}
