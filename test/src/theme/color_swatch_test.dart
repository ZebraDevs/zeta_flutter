import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() {
  group('ZetaColorSwatch', () {
    late ZetaColorSwatch zetaColorSwatch;

    setUp(() {
      zetaColorSwatch = ZetaColorSwatch(
        primary: Colors.blue.toARGB32(),
        swatch: {
          10: Colors.blue.shade100,
          20: Colors.blue.shade200,
          30: Colors.blue.shade300,
          40: Colors.blue.shade400,
          50: Colors.blue.shade500,
          60: Colors.blue,
          70: Colors.blue.shade700,
          80: Colors.blue.shade800,
          90: Colors.blue.shade900,
          100: Colors.blue.shade900,
        },
      );
    });

    test('initialization of properties', () {
      expect(zetaColorSwatch.brightness, Brightness.light);
      expect(zetaColorSwatch.contrast, ZetaContrast.aa);
      expect(zetaColorSwatch.shade10, Colors.blue.shade100);
      expect(zetaColorSwatch.shade20, Colors.blue.shade200);
      expect(zetaColorSwatch.shade30, Colors.blue.shade300);
      expect(zetaColorSwatch.shade40, Colors.blue.shade400);
      expect(zetaColorSwatch.shade50, Colors.blue.shade500);
      expect(zetaColorSwatch.shade60, Colors.blue);
      expect(zetaColorSwatch.shade70, Colors.blue.shade700);
      expect(zetaColorSwatch.shade80, Colors.blue.shade800);
      expect(zetaColorSwatch.shade90, Colors.blue.shade900);
      expect(zetaColorSwatch.shade100, Colors.blue.shade900);
    });

    test('fromColor factory constructor', () {
      final swatch = ZetaColorSwatch.fromColor(
        Colors.blue,
      );

      expect(swatch.toARGB32, Colors.blue.toARGB32);
      expect(swatch.brightness, Brightness.light);
      expect(swatch.contrast, ZetaContrast.aa);
    });

    test('apply method', () {
      final appliedSwatch = zetaColorSwatch.apply(
        brightness: Brightness.dark,
        contrast: ZetaContrast.aaa,
      );

      expect(appliedSwatch.brightness, Brightness.dark);
      expect(appliedSwatch.contrast, ZetaContrast.aaa);
      expect(appliedSwatch.shade10, zetaColorSwatch.shade100);
      expect(appliedSwatch.shade20, zetaColorSwatch.shade90);
      expect(appliedSwatch.shade30, zetaColorSwatch.shade80);
      expect(appliedSwatch.shade40, zetaColorSwatch.shade70);
      expect(appliedSwatch.shade50, zetaColorSwatch.shade60);
      expect(appliedSwatch.shade60, zetaColorSwatch.shade50);
      expect(appliedSwatch.shade70, zetaColorSwatch.shade40);
      expect(appliedSwatch.shade80, zetaColorSwatch.shade30);
      expect(appliedSwatch.shade90, zetaColorSwatch.shade20);
      expect(appliedSwatch.shade100, zetaColorSwatch.shade10);
    });

    test('equality operator works as expected', () {
      final identicalSwatch = ZetaColorSwatch(
        primary: Colors.blue.toARGB32(),
        swatch: {
          10: Colors.blue.shade100,
          20: Colors.blue.shade200,
          30: Colors.blue.shade300,
          40: Colors.blue.shade400,
          50: Colors.blue.shade500,
          60: Colors.blue,
          70: Colors.blue.shade700,
          80: Colors.blue.shade800,
          90: Colors.blue.shade900,
          100: Colors.blue.shade900,
        },
      );

      expect(zetaColorSwatch, identicalSwatch);
      expect(zetaColorSwatch == identicalSwatch, isTrue);
    });

    test('hashCode method works as expected', () {
      final identicalSwatch = ZetaColorSwatch(
        primary: Colors.blue.toARGB32(),
        swatch: {
          10: Colors.blue.shade100,
          20: Colors.blue.shade200,
          30: Colors.blue.shade300,
          40: Colors.blue.shade400,
          50: Colors.blue.shade500,
          60: Colors.blue,
          70: Colors.blue.shade700,
          80: Colors.blue.shade800,
          90: Colors.blue.shade900,
          100: Colors.blue.shade900,
        },
      );

      expect(zetaColorSwatch.hashCode, identicalSwatch.hashCode);
    });

    test('shade getters works as expected', () {
      expect(zetaColorSwatch.shade10, Colors.blue.shade100);
      expect(zetaColorSwatch.shade20, Colors.blue.shade200);
      expect(zetaColorSwatch.shade30, Colors.blue.shade300);
      expect(zetaColorSwatch.shade40, Colors.blue.shade400);
      expect(zetaColorSwatch.shade50, Colors.blue.shade500);
      expect(zetaColorSwatch.shade60, Colors.blue);
      expect(zetaColorSwatch.shade70, Colors.blue.shade700);
      expect(zetaColorSwatch.shade80, Colors.blue.shade800);
      expect(zetaColorSwatch.shade90, Colors.blue.shade900);
      expect(zetaColorSwatch.shade100, Colors.blue.shade900);
    });

    test('token getters works as expected', () {
      expect(zetaColorSwatch.text.toARGB32, Colors.blue.toARGB32);
      expect(zetaColorSwatch.icon.toARGB32, Colors.blue.toARGB32);
      expect(zetaColorSwatch.hover.toARGB32, Colors.blue.shade700.toARGB32);
      expect(zetaColorSwatch.selected.toARGB32, Colors.blue.shade800.toARGB32);
      expect(zetaColorSwatch.focus.toARGB32, Colors.blue.shade800.toARGB32);
      expect(zetaColorSwatch.border.toARGB32, Colors.blue.toARGB32);
      expect(zetaColorSwatch.subtle.toARGB32, Colors.blue.shade400.toARGB32);
      expect(zetaColorSwatch.surface.toARGB32, Colors.blue.shade100.toARGB32);

      final aaaSwatch = ZetaColorSwatch(
        contrast: ZetaContrast.aaa,
        primary: Colors.blue.toARGB32(),
        swatch: {
          10: Colors.blue.shade100,
          20: Colors.blue.shade200,
          30: Colors.blue.shade300,
          40: Colors.blue.shade400,
          50: Colors.blue.shade500,
          60: Colors.blue,
          70: Colors.blue.shade700,
          80: Colors.blue.shade800,
          90: Colors.blue.shade900,
          100: Colors.blue.shade900,
        },
      );

      expect(aaaSwatch.text.toARGB32, Colors.blue.shade800.toARGB32);
      expect(aaaSwatch.icon.toARGB32, Colors.blue.shade800.toARGB32);
      expect(aaaSwatch.hover.toARGB32, Colors.blue.shade900.toARGB32);
      expect(aaaSwatch.selected.toARGB32, Colors.blue.shade900.toARGB32);
      expect(aaaSwatch.focus.toARGB32, Colors.blue.shade900.toARGB32);
      expect(aaaSwatch.border.toARGB32, Colors.blue.shade800.toARGB32);
      expect(aaaSwatch.subtle.toARGB32, Colors.blue.shade500.toARGB32);
      expect(aaaSwatch.surface.toARGB32, Colors.blue.shade100.toARGB32);
    });
  });

  testWidgets('Light / Dark mode are inverted', (tester) async {
    final ZetaColors light = ZetaColors();
    final ZetaColors dark = ZetaColors(brightness: Brightness.dark);

    expect(light.primary.shade10, dark.primary.shade100);
    expect(light.primary.shade20, dark.primary.shade90);
    expect(light.primary.shade30, dark.primary.shade80);
    expect(light.primary.shade40, dark.primary.shade70);
    expect(light.primary.shade50, dark.primary.shade60);
  });

  testWidgets('AAA mode value colors are 2 shades darker', (tester) async {
    final ZetaColors aa = ZetaColors();
    final ZetaColors aaa = ZetaColors(brightness: Brightness.dark, contrast: ZetaContrast.aaa);

    expect(aa.primary.toARGB32, aa.primary.shade60.toARGB32);
    expect(aaa.primary.toARGB32, aaa.primary.shade80.toARGB32);
  });
}
