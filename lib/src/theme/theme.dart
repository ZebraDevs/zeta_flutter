import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';
import '../tokens.dart' as tokens;

export 'breakpoints.dart';
export 'colors.dart';
export 'constants.dart';

/// Theme for Zeta.
class ZetaTheme {
  /// Zeta theme.
  ///
  /// {@template zeta-theme}
  /// For apps using Zeta components to be properly themed, [zeta] ThemeData should be placed in the widget tree using one of the following methods:
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
  static ThemeData get zeta {
    return ThemeData(
      fontFamily: tokens.Typography.fontFamily,
      textTheme: ZetaText.textTheme,
    );
  }
}
