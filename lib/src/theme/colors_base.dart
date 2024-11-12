import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

/// Default set of Zeta Colors that can be used to make a [ZetaColors] instance.
///
/// One of more of these can be overridden when constructing a [ZetaColors] instance.
///
/// * [blue]
/// * [green]
/// * [red]
/// * [orange]
/// * [purple]
/// * [yellow]
/// * [teal]
/// * [pink]
/// * [warm]
/// * [pure]
/// * [cool].
/// {@category Theme}
abstract final class ZetaColorBase {
  /// Link color for light mode.
  @Deprecated('This color has been deprecated as of v0.10.0')
  static const Color linkLight = Color(0xFF0257AC);

  /// Visited link color for light mode.
  @Deprecated('This color has been deprecated as of v0.10.0')
  static const Color linkVisitedLight = Color(0xFF205386);

  /// Link color for dark mode.
  @Deprecated('This color has been deprecated as of v0.10.0')
  static const Color linkDark = Color(0xFF7ABDFF);

  /// Visited link color for dark mode.
  @Deprecated('This color has been deprecated as of v0.10.0')
  static const Color linkVisitedDark = Color(0xFF47A3FF);

  /// Default shadow color.
  @Deprecated('This color has been deprecated as of v0.10.0')
  static const Color shadowLight = Color(0x1A49505E);

  /// Default shadow color.
  @Deprecated('This color has been deprecated as of v0.10.0')
  static const Color shadowDark = Color(0x1A49505E);

  /// Grey warm swatch
  @Deprecated('Use warm instead. ' 'This color has been deprecated as of v0.10.0.')
  static const ZetaColorSwatch greyWarm = ZetaColorBase.warm;

  /// Grey cool swatch
  @Deprecated('Use cool instead. ' 'This color has been deprecated as of v0.10.0.')
  static const ZetaColorSwatch greyCool = ZetaColorBase.cool;

  /// Pure
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch pure = ZetaColorSwatch(
    primary: 0xFF151519,
    swatch: {
      0: Color(0xFFffffff),
      500: Color(0xFF151519),
      1000: Color(0xFF151519),
    },
  );

  /// Cool
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch cool = ZetaColorSwatch(
    primary: 0xFF7a8190,
    swatch: {
      10: Color(0xFFf8fbff),
      20: Color(0xFFf3f6fa),
      30: Color(0xFFe0e3e9),
      40: Color(0xFFced2db),
      50: Color(0xFF8d95a3),
      60: Color(0xFF7a8190),
      70: Color(0xFF545963),
      80: Color(0xFF2c2f36),
      90: Color(0xFF1d1e23),
      100: Color(0xFF0c0d0e),
    },
  );

  /// Warm
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch warm = ZetaColorSwatch(
    primary: 0xFF858585,
    swatch: {
      10: Color(0xFFfafafa),
      20: Color(0xFFf6f6f6),
      30: Color(0xFFececec),
      40: Color(0xFFdedede),
      50: Color(0xFFb9b9b9),
      60: Color(0xFF858585),
      70: Color(0xFF585858),
      80: Color(0xFF313131),
      90: Color(0xFF1d1e23),
      100: Color(0xFF151519),
    },
  );

  /// Blue
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch blue = ZetaColorSwatch(
    primary: 0xFF0073e6,
    swatch: {
      10: Color(0xFFf1f8ff),
      20: Color(0xFFe2f1ff),
      30: Color(0xFFb7dbff),
      40: Color(0xFF7ebeff),
      50: Color(0xFF599fe5),
      60: Color(0xFF0073e6),
      70: Color(0xFF0061c2),
      80: Color(0xFF004d99),
      90: Color(0xFF002c58),
      100: Color(0xFF101b25),
    },
  );

  /// Green
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch green = ZetaColorSwatch(
    primary: 0xFF00864f,
    swatch: {
      10: Color(0xFFecfff7),
      20: Color(0xFFd8ffef),
      30: Color(0xFFbeefdb),
      40: Color(0xFF84dab6),
      50: Color(0xFF67b796),
      60: Color(0xFF00864f),
      70: Color(0xFF006d3f),
      80: Color(0xFF005f38),
      90: Color(0xFF00331e),
      100: Color(0xFF081711),
    },
  );

  /// Red
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch red = ZetaColorSwatch(
    primary: 0xFFd70015,
    swatch: {
      10: Color(0xFFfff0f1),
      20: Color(0xFFffe1e4),
      30: Color(0xFFffb3bb),
      40: Color(0xFFf98c97),
      50: Color(0xFFf36170),
      60: Color(0xFFd70015),
      70: Color(0xFFb50012),
      80: Color(0xFF8f000e),
      90: Color(0xFF520008),
      100: Color(0xFF220f11),
    },
  );

  /// Orange
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch orange = ZetaColorSwatch(
    primary: 0xFFae6500,
    swatch: {
      10: Color(0xFFfef2e2),
      20: Color(0xFFffe7c6),
      30: Color(0xFFffd292),
      40: Color(0xFFffb348),
      50: Color(0xFFf5a230),
      60: Color(0xFFae6500),
      70: Color(0xFF965802),
      80: Color(0xFF764502),
      90: Color(0xFF402600),
      100: Color(0xFF1e1100),
    },
  );

  /// Purple
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch purple = ZetaColorSwatch(
    primary: 0xFF7e0cff,
    swatch: {
      10: Color(0xFFf7f0ff),
      20: Color(0xFFefe1ff),
      30: Color(0xFFdcc1fb),
      40: Color(0xFFcea4ff),
      50: Color(0xFF9b71df),
      60: Color(0xFF7e0cff),
      70: Color(0xFF6400d6),
      80: Color(0xFF43008f),
      90: Color(0xFF260052),
      100: Color(0xFF180f22),
    },
  );

  /// Yellow
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch yellow = ZetaColorSwatch(
    primary: 0xFF8d7400,
    swatch: {
      10: Color(0xFFfff7d4),
      20: Color(0xFFffea89),
      30: Color(0xFFf3d961),
      40: Color(0xFFdbb91c),
      50: Color(0xFFc2a728),
      60: Color(0xFF8d7400),
      70: Color(0xFF766200),
      80: Color(0xFF564908),
      90: Color(0xFF352b00),
      100: Color(0xFF181400),
    },
  );

  /// Teal
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch teal = ZetaColorSwatch(
    primary: 0xFF1a8080,
    swatch: {
      10: Color(0xFFecffff),
      20: Color(0xFFd9ffff),
      30: Color(0xFFbcfbfb),
      40: Color(0xFF91e1e1),
      50: Color(0xFF65c4c4),
      60: Color(0xFF1a8080),
      70: Color(0xFF017474),
      80: Color(0xFF005b5b),
      90: Color(0xFF003535),
      100: Color(0xFF0a1616),
    },
  );

  /// Pink
  ///
  /// {@macro zeta-color-swatch}
  static const ZetaColorSwatch pink = ZetaColorSwatch(
    primary: 0xFFd30589,
    swatch: {
      10: Color(0xFFfff7fc),
      20: Color(0xFFffe3f5),
      30: Color(0xFFffbee7),
      40: Color(0xFFff94d8),
      50: Color(0xFFee78c3),
      60: Color(0xFFd30589),
      70: Color(0xFFab006d),
      80: Color(0xFF840054),
      90: Color(0xFF640040),
      100: Color(0xFF2e001e),
    },
  );

  /// Pure white.
  ///
  /// Typically reserved for backgrounds.
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black.
  ///
  /// Sparingly used.
  static const Color black = Color(0xFF000000);

  /// Default text color.
  static const Color text = Color(0xFF1D1E23);
}
