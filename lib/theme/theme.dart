import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

export 'breakpoints.dart';
export 'colors.dart';
export 'colors_base.dart';
export 'constants.dart';

/// Theme for Zeta.
class ZetaTheme {
  /// Default theme in light mode.
  ///
  /// {@template zeta-theme}
  /// For apps using Zeta components to be properly themed, [Zeta] ThemeData should be placed in the widget tree using one of the following methods:
  ///
  ///
  /// dart```
  ///   MaterialApp(
  ///     theme: zeta,
  ///     ...
  ///   )
  /// ```
  ///
  /// ```
  ///   Theme(
  ///     data: zeta,
  ///     child: ...
  ///   )
  /// ```
  ///
  /// This adds all the appropriate tokens into the app to render correctly.
  ///
  /// {@endtemplate}
  static ThemeData zetaLight({ZetaThemeData? initialTheme}) {
    return ThemeData(
      colorScheme:
          initialTheme?.colorScheme ?? initialTheme?.zetaColors?.toColorScheme ?? const ZetaColors().toColorScheme,
      fontFamily: initialTheme?.fontFamily ?? 'packages/zeta_flutter/IBMPlexSans',
      // TODO(tokens): reinstate tokens.Typography.fontFamily when we have a plan for tokens
      textTheme: initialTheme?.textTheme ?? ZetaText.textTheme,
    );
  }

  /// Default theme with dark mode.
  ///
  /// {@macro zeta-theme}
  static ThemeData zetaDark({ZetaThemeData? initialTheme}) {
    return ThemeData(
      colorScheme: initialTheme?.colorScheme ??
          initialTheme?.zetaColors?.copyWith(isDarkMode: true).toColorScheme ??
          const ZetaColors().toColorScheme,
      fontFamily: initialTheme?.fontFamily ?? 'packages/zeta_flutter/IBMPlexSans',
      textTheme: initialTheme?.textTheme ?? ZetaText.textTheme,
    );
  }

  /// Builds a [ThemeData] based off of some initial data.
  ///
  /// If `initialTheme.zetaColors` is not defined, colors will default to light mode.
  ///
  /// {@macro zeta-theme}
  static ThemeData builder({ZetaThemeData? initialTheme}) {
    final ZetaColors colors = initialTheme?.zetaColors ?? const ZetaColors();

    return ThemeData(
      colorScheme: initialTheme?.colorScheme ?? colors.toColorScheme,
      fontFamily: initialTheme?.fontFamily ?? 'packages/zeta_flutter/IBMPlexSans',
      textTheme: initialTheme?.textTheme ?? ZetaText.textThemeBuilder(colors),
    );
  }
}

/// Basic theme information used to create a ZetaTheme.
class ZetaThemeData {
  /// Font family.
  ///
  /// If null, defaults to  `packages/zeta_flutter/IBMPlexSans`;
  final String? fontFamily;

  /// Color scheme.
  ///
  /// If null, defaults to `ZetaColors().toColorScheme`.
  final ColorScheme? colorScheme;

  /// ZetaColors
  ///
  /// If null, defaults to `ZetaColors()` - which builds a light mode color palette with default Zeta Colors.
  final ZetaColors? zetaColors;

  /// TextTheme. If null, defaults to [ZetaText.textTheme].
  final TextTheme? textTheme;

  /// Constructs a [ZetaThemeData].
  const ZetaThemeData({
    this.fontFamily,
    this.colorScheme,
    this.zetaColors,
    this.textTheme,
  });

  /// Returns a new [ZetaThemeData] with fields replaced with the passed parameters.
  ZetaThemeData copyWith({
    String? fontFamily,
    ColorScheme? colorScheme,
    ZetaColors? zetaColors,
    TextTheme? textTheme,
  }) {
    return ZetaThemeData(
      fontFamily: fontFamily ?? this.fontFamily,
      colorScheme: colorScheme ?? this.colorScheme,
      zetaColors: zetaColors ?? this.zetaColors,
      textTheme: textTheme ?? this.textTheme,
    );
  }
}
