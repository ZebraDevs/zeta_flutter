import 'package:flutter/material.dart';
// Ignored import due to file being generated
// ignore: prefer_relative_imports
import 'package:zeta_flutter_theme/zeta_flutter_theme.dart';

// This file is automatically generated by the zeta repository
// DO NOT MODIFY

// const zetaTokensVersion = 'TODO:'

/// Interface used for zeta color primitives
abstract interface class ZetaPrimitives {
  const ZetaPrimitives({
    ZetaColorSwatch? primary,
    ZetaColorSwatch? secondary,
    required this.brightness,
  })  : _primary = primary,
        _secondary = secondary;

  final ZetaColorSwatch? _primary;

  final ZetaColorSwatch? _secondary;

  /// Primary color
  ZetaColorSwatch get primary => _primary ?? blue;

  /// Secondary color
  ZetaColorSwatch get secondary => _secondary ?? yellow;

  /// The brightness of the primitives
  final Brightness brightness;

  /// Blue
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get blue;

  /// Cool
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get cool;

  /// Green
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get green;

  /// Orange
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get orange;

  /// Pink
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get pink;

  /// Pure
  ///
  /// {@macro zeta-color-swatch}
  ZetaPureColorSwatch get pure;

  /// Purple
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get purple;

  /// Red
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get red;

  /// Teal
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get teal;

  /// Warm
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get warm;

  /// Yellow
  ///
  /// {@macro zeta-color-swatch}
  ZetaColorSwatch get yellow;

  /// 0dp space
  double get x0;

  /// 4dp space
  double get x1;

  /// 8dp space
  double get x2;

  /// 12dp space
  double get x3;

  /// 16dp space
  double get x4;

  /// 20dp space
  double get x5;

  /// 24dp space
  double get x6;

  /// 28dp space
  double get x7;

  /// 32dp space
  double get x8;

  /// 36dp space
  double get x9;

  /// 40dp space
  double get x10;

  /// 44dp space
  double get x11;

  /// 48dp space
  double get x12;

  /// 64dp space
  double get x13;

  /// 80dp space
  double get x14;

  /// 96dp space
  double get x15;

  /// 0dp radius
  Radius get r_0;

  /// 4dp radius
  Radius get s;

  /// 8dp radius
  Radius get m;

  /// 16dp radius
  Radius get l;

  /// 24dp radius
  Radius get xl;

  /// 32dp radius
  Radius get xl_2;

  /// 128dp radius
  Radius get xl_3;

  /// 360dp radius
  Radius get xl_4;
}

/// Dark primitives
final class ZetaPrimitivesDark extends ZetaPrimitives {
  /// Constructs a new ZetaPrimitivesDark instance with the (optional) primary and secondary colors.
  const ZetaPrimitivesDark({super.primary, super.secondary}) : super(brightness: Brightness.dark);
  @override
  ZetaColorSwatch get blue => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF101b25),
          20: Color(0xFF002c58),
          30: Color(0xFF004d99),
          40: Color(0xFF0061c2),
          50: Color(0xFF0073e6),
          60: Color(0xFF599fe5),
          70: Color(0xFF7ebeff),
          80: Color(0xFFb7dbff),
          90: Color(0xFFe2f1ff),
          100: Color(0xFFf1f8ff),
        },
        primary: 0xFF599fe5,
      );
  @override
  ZetaColorSwatch get cool => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF0c0d0e),
          20: Color(0xFF1d1e23),
          30: Color(0xFF2c2f36),
          40: Color(0xFF545963),
          50: Color(0xFF7a8190),
          60: Color(0xFF8d95a3),
          70: Color(0xFFbbc1cb),
          80: Color(0xFFe0e3e9),
          90: Color(0xFFf3f6fa),
          100: Color(0xFFf8fbff),
        },
        primary: 0xFF8d95a3,
      );
  @override
  ZetaColorSwatch get green => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF081711),
          20: Color(0xFF00331e),
          30: Color(0xFF005f38),
          40: Color(0xFF006d3f),
          50: Color(0xFF00864f),
          60: Color(0xFF67b796),
          70: Color(0xFF84dab6),
          80: Color(0xFFbeefdb),
          90: Color(0xFFd8ffef),
          100: Color(0xFFecfff7),
        },
        primary: 0xFF67b796,
      );
  @override
  ZetaColorSwatch get orange => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF1e1100),
          20: Color(0xFF402600),
          30: Color(0xFF764502),
          40: Color(0xFF965802),
          50: Color(0xFFae6500),
          60: Color(0xFFd78d26),
          70: Color(0xFFffb348),
          80: Color(0xFFffd292),
          90: Color(0xFFffe7c6),
          100: Color(0xFFfef2e2),
        },
        primary: 0xFFd78d26,
      );
  @override
  ZetaColorSwatch get pink => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF2e001e),
          20: Color(0xFF640040),
          30: Color(0xFF840054),
          40: Color(0xFFab006d),
          50: Color(0xFFd30589),
          60: Color(0xFFee78c3),
          70: Color(0xFFff94d8),
          80: Color(0xFFffbee7),
          90: Color(0xFFffe3f5),
          100: Color(0xFFfff7fc),
        },
        primary: 0xFFee78c3,
      );
  @override
  ZetaPureColorSwatch get pure => const ZetaPureColorSwatch(
        swatch: {
          0: Color(0xFF151519),
          500: Color(0xFF1d1e23),
          1000: Color(0xFFffffff),
        },
        primary: 0xFF1d1e23,
      );
  @override
  ZetaColorSwatch get purple => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF180f22),
          20: Color(0xFF260052),
          30: Color(0xFF43008f),
          40: Color(0xFF6400d6),
          50: Color(0xFF7e0cff),
          60: Color(0xFF9b71df),
          70: Color(0xFFcea4ff),
          80: Color(0xFFdcc1fb),
          90: Color(0xFFefe1ff),
          100: Color(0xFFf7f0ff),
        },
        primary: 0xFF9b71df,
      );
  @override
  ZetaColorSwatch get red => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF220f11),
          20: Color(0xFF520008),
          30: Color(0xFF8f000e),
          40: Color(0xFFb50012),
          50: Color(0xFFd70015),
          60: Color(0xFFf36170),
          70: Color(0xFFf98c97),
          80: Color(0xFFffb3bb),
          90: Color(0xFFffe1e4),
          100: Color(0xFFfff0f1),
        },
        primary: 0xFFf36170,
      );
  @override
  ZetaColorSwatch get teal => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF0a1616),
          20: Color(0xFF003535),
          30: Color(0xFF005b5b),
          40: Color(0xFF017474),
          50: Color(0xFF1a8080),
          60: Color(0xFF65c4c4),
          70: Color(0xFF91e1e1),
          80: Color(0xFFbcfbfb),
          90: Color(0xFFd9ffff),
          100: Color(0xFFecffff),
        },
        primary: 0xFF65c4c4,
      );
  @override
  ZetaColorSwatch get warm => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF151519),
          20: Color(0xFF1d1e23),
          30: Color(0xFF313131),
          40: Color(0xFF585858),
          50: Color(0xFF858585),
          60: Color(0xFFb9b9b9),
          70: Color(0xFFdedede),
          80: Color(0xFFececec),
          90: Color(0xFFf6f6f6),
          100: Color(0xFFfafafa),
        },
        primary: 0xFFb9b9b9,
      );
  @override
  ZetaColorSwatch get yellow => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFF181400),
          20: Color(0xFF352b00),
          30: Color(0xFF564908),
          40: Color(0xFF766200),
          50: Color(0xFF8d7400),
          60: Color(0xFFc2a728),
          70: Color(0xFFdbb91c),
          80: Color(0xFFf3d961),
          90: Color(0xFFffea89),
          100: Color(0xFFfff7d4),
        },
        primary: 0xFFc2a728,
      );
  @override
  double get x0 => 0;
  @override
  double get x1 => 4;
  @override
  double get x2 => 8;
  @override
  double get x3 => 12;
  @override
  double get x4 => 16;
  @override
  double get x5 => 20;
  @override
  double get x6 => 24;
  @override
  double get x7 => 28;
  @override
  double get x8 => 32;
  @override
  double get x9 => 36;
  @override
  double get x10 => 40;
  @override
  double get x11 => 44;
  @override
  double get x12 => 48;
  @override
  double get x13 => 64;
  @override
  double get x14 => 80;
  @override
  double get x15 => 96;
  @override
  Radius get r_0 => Radius.zero;
  @override
  Radius get s => const Radius.circular(4);
  @override
  Radius get m => const Radius.circular(8);
  @override
  Radius get l => const Radius.circular(16);
  @override
  Radius get xl => const Radius.circular(24);
  @override
  Radius get xl_2 => const Radius.circular(32);
  @override
  Radius get xl_3 => const Radius.circular(128);
  @override
  Radius get xl_4 => const Radius.circular(360);
}

/// Light primitives
final class ZetaPrimitivesLight extends ZetaPrimitives {
  /// Constructs a new ZetaPrimitivesLight instance with the (optional) primary and secondary colors.
  const ZetaPrimitivesLight({super.primary, super.secondary}) : super(brightness: Brightness.light);
  @override
  ZetaColorSwatch get blue => const ZetaColorSwatch(
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
        primary: 0xFF0073e6,
      );
  @override
  ZetaColorSwatch get cool => const ZetaColorSwatch(
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
        primary: 0xFF7a8190,
      );
  @override
  ZetaColorSwatch get green => const ZetaColorSwatch(
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
        primary: 0xFF00864f,
      );
  @override
  ZetaColorSwatch get orange => const ZetaColorSwatch(
        swatch: {
          10: Color(0xFFfef2e2),
          20: Color(0xFFffe7c6),
          30: Color(0xFFffd292),
          40: Color(0xFFffb348),
          50: Color(0xFFd78d26),
          60: Color(0xFFae6500),
          70: Color(0xFF965802),
          80: Color(0xFF764502),
          90: Color(0xFF402600),
          100: Color(0xFF1e1100),
        },
        primary: 0xFFae6500,
      );
  @override
  ZetaColorSwatch get pink => const ZetaColorSwatch(
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
        primary: 0xFFd30589,
      );
  @override
  ZetaPureColorSwatch get pure => const ZetaPureColorSwatch(
        swatch: {
          0: Color(0xFFffffff),
          500: Color(0xFF151519),
          1000: Color(0xFF151519),
        },
        primary: 0xFF151519,
      );
  @override
  ZetaColorSwatch get purple => const ZetaColorSwatch(
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
        primary: 0xFF7e0cff,
      );
  @override
  ZetaColorSwatch get red => const ZetaColorSwatch(
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
        primary: 0xFFd70015,
      );
  @override
  ZetaColorSwatch get teal => const ZetaColorSwatch(
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
        primary: 0xFF1a8080,
      );
  @override
  ZetaColorSwatch get warm => const ZetaColorSwatch(
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
        primary: 0xFF858585,
      );
  @override
  ZetaColorSwatch get yellow => const ZetaColorSwatch(
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
        primary: 0xFF8d7400,
      );
  @override
  double get x0 => 0;
  @override
  double get x1 => 4;
  @override
  double get x2 => 8;
  @override
  double get x3 => 12;
  @override
  double get x4 => 16;
  @override
  double get x5 => 20;
  @override
  double get x6 => 24;
  @override
  double get x7 => 28;
  @override
  double get x8 => 32;
  @override
  double get x9 => 36;
  @override
  double get x10 => 40;
  @override
  double get x11 => 44;
  @override
  double get x12 => 48;
  @override
  double get x13 => 64;
  @override
  double get x14 => 80;
  @override
  double get x15 => 96;
  @override
  Radius get r_0 => Radius.zero;
  @override
  Radius get s => const Radius.circular(4);
  @override
  Radius get m => const Radius.circular(8);
  @override
  Radius get l => const Radius.circular(16);
  @override
  Radius get xl => const Radius.circular(24);
  @override
  Radius get xl_2 => const Radius.circular(32);
  @override
  Radius get xl_3 => const Radius.circular(128);
  @override
  Radius get xl_4 => const Radius.circular(360);
}

/// All primitives
Map<String, Type> allPrimitives = {
  'dark': ZetaPrimitivesDark,
  'light': ZetaPrimitivesLight,
};
