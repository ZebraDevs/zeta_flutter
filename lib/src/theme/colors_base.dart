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
/// * [greyWarm]
/// * [greyCool].
class ZetaColorBase {
  ZetaColorBase._();

  /// Blue swatch.
  ///
  /// {@template zeta-colors-swatch}
  /// Contains shades from 10 (light) to 100 (dark).
  ///
  /// See also:
  /// * [ZetaColorSwatch].
  /// {@endtemplate}
  static const ZetaColorSwatch blue = ZetaColorSwatch(
    primary: 0xFF0073e6,
    swatch: {
      100: Color(0xFF101B25),
      90: Color(0xFF002C58),
      80: Color(0xFF004D99),
      70: Color(0xFF0061C2),
      60: Color(0xFF0073E6),
      50: Color(0xFF599FE5),
      40: Color(0xFF7EBEFF),
      30: Color(0xFFB7DBFF),
      20: Color(0xFFE2F1FF),
      10: Color(0xFFF1F8FF),
    },
  );

  /// Green swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch green = ZetaColorSwatch(
    primary: 0xFF00864F,
    swatch: {
      100: Color(0xFF081711),
      90: Color(0xFF00331E),
      80: Color(0xFF005F38),
      70: Color(0xFF006D3F),
      60: Color(0xFF00864F),
      50: Color(0xFF67B796),
      40: Color(0xFF84DAB6),
      30: Color(0xFFBEEFDB),
      20: Color(0xFFD8FFEF),
      10: Color(0xFFECFFF7),
    },
  );

  /// Red swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch red = ZetaColorSwatch(
    primary: 0xFFD70015,
    swatch: {
      100: Color(0xFF220F11),
      90: Color(0xFF520008),
      80: Color(0xFF8F000E),
      70: Color(0xFFB50012),
      60: Color(0xFFD70015),
      50: Color(0xFFF36170),
      40: Color(0xFFF98C97),
      30: Color(0xFFFFB3BB),
      20: Color(0xFFFFE1E4),
      10: Color(0xFFFFF0F1),
    },
  );

  /// Orange swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch orange = ZetaColorSwatch(
    primary: 0xFFC87500,
    swatch: {
      100: Color(0xFF1E1100),
      90: Color(0xFF402600),
      80: Color(0xFF764502),
      70: Color(0xFF965802),
      60: Color(0xFFAE6500),
      50: Color(0xFFD78E26),
      40: Color(0xFFF5A230),
      30: Color(0xFFFFB348),
      20: Color(0xFFFFD292),
      10: Color(0xFFFFE7C6),
    },
  );

  /// Purple swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch purple = ZetaColorSwatch(
    primary: 0xFF6400D6,
    swatch: {
      100: Color(0xFF180F22),
      90: Color(0xFF260052),
      80: Color(0xFF43008F),
      70: Color(0xFF6400D6),
      60: Color(0xFF7E0CFF),
      50: Color(0xFF9B71DF),
      40: Color(0xFFCEA4FF),
      30: Color(0xFFDCC1FB),
      20: Color(0xFFEFE1FF),
      10: Color(0xFFF7F0FF),
    },
  );

  /// Yellow swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch yellow = ZetaColorSwatch(
    primary: 0xFFA38600,
    swatch: {
      100: Color(0xFF181400),
      90: Color(0xFF352B00),
      80: Color(0xFF564908),
      70: Color(0xFF766200),
      60: Color(0xFF8D7400),
      50: Color(0xFFC2A728),
      40: Color(0xFFDBB91C),
      30: Color(0xFFF3D961),
      20: Color(0xFFFFEA89),
      10: Color(0xFFFFF7D4),
    },
  );

  /// Teal swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch teal = ZetaColorSwatch(
    primary: 0xFF018786,
    swatch: {
      100: Color(0xFF0A1616),
      90: Color(0xFF003535),
      80: Color(0xFF005B5B),
      70: Color(0xFF017474),
      60: Color(0xFF1A8080),
      50: Color(0xFF65C5C5),
      40: Color(0xFF91E1E1),
      30: Color(0xFFBCFBFB),
      20: Color(0xFFD9FFFF),
      10: Color(0xFFECFFFF),
    },
  );

  /// Pink swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch pink = ZetaColorSwatch(
    primary: 0xFFAB006D,
    swatch: {
      100: Color(0xFF2E001E),
      90: Color(0xFF640040),
      80: Color(0xFF840054),
      70: Color(0xFFAB006D),
      60: Color(0xFFD30589),
      50: Color(0xFFEE78C3),
      40: Color(0xFFFF94D8),
      30: Color(0xFFFFBEE7),
      20: Color(0xFFFFE3F5),
      10: Color(0xFFFFF7FC),
    },
  );

  /// Grey warm swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch greyWarm = ZetaColorSwatch(
    primary: 0xFF858585,
    swatch: {
      100: Color(0xFF151519),
      90: Color(0xFF202020),
      80: Color(0xFF313131),
      70: Color(0xFF585858),
      60: Color(0xFF858585),
      50: Color(0xFFB9B9B9),
      40: Color(0xFFDEDEDE),
      30: Color(0xFFEDEDED),
      20: Color(0xFFF7F7F7),
      10: Color(0xFFFAFAFA),
    },
  );

  /// Grey cool swatch.
  ///
  /// {@macro zeta-colors-swatch}
  static const ZetaColorSwatch greyCool = ZetaColorSwatch(
    primary: 0xFF7A8190,
    swatch: {
      100: Color(0xFF0C0D0E),
      90: Color(0xFF1D1E23),
      80: Color(0xFF2C2F36),
      70: Color(0xFF545963),
      60: Color(0xFF7A8190),
      50: Color(0xFF8D95A3),
      40: Color(0xFFCED2DB),
      30: Color(0xFFE0E3E9),
      20: Color(0xFFF3F6FA),
      10: Color(0xFFF8FBFF),
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

  /// Link color for light mode.
  static const Color linkLight = Color(0xFF0257AC);

  /// Visited link color for light mode.
  static const Color linkVisitedLight = Color(0xFF205386);

  /// Link color for dark mode.
  static const Color linkDark = Color(0xFF7ABDFF);

  /// Visited link color for dark mode.
  static const Color linkVisitedDark = Color(0xFF47A3FF);

  /// Default shadow color.
  static const Color shadowLight = Color(0x1A49505E);

  /// Default shadow color.
  static const Color shadowDark = Color(0x1A49505E);
}
