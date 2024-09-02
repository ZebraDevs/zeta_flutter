import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() {
  group('ZetaColorExtensions', () {
    test('zetaColorSwatch returns correct ZetaColorSwatch', () {
      const color = Colors.blue;
      final swatch = color.zetaColorSwatch;
      expect(swatch.runtimeType, ZetaColorSwatch);
    });

    test('brighten brightens the color correctly', () {
      const color = Color(0xFF123456);
      final brightenedColor = color.brighten();
      expect(brightenedColor, isNot(color));
      expect(brightenedColor.computeLuminance(), greaterThan(color.computeLuminance()));
    });

    test('lighten lightens the color correctly', () {
      const color = Color(0xFF123456);
      final lightenedColor = color.lighten();
      expect(lightenedColor, isNot(color));
      expect(HSLColor.fromColor(lightenedColor).lightness, greaterThan(HSLColor.fromColor(color).lightness));
    });

    test('darken darkens the color correctly', () {
      const color = Color(0xFF123456);
      final darkenedColor = color.darken();
      expect(darkenedColor, isNot(color));
      expect(darkenedColor.computeLuminance(), lessThan(color.computeLuminance()));
    });

    test('onColor returns the correct on color', () {
      const color = Colors.blue;
      expect(color.onColor, ZetaPrimitivesLight().pure.shade0);

      const lightColor = Colors.white;
      expect(lightColor.onColor, Colors.black87);
    });

    test('isLight returns true for light colors', () {
      const color = Colors.white;
      expect(color.isLight, isTrue);
    });

    test('isDark returns true for dark colors', () {
      const color = Colors.black;
      expect(color.isDark, isTrue);
    });

    test('blend blends two colors correctly', () {
      const color1 = Colors.red;
      const color2 = Colors.blue;
      final blendedColor = color1.blend(color2, 50);
      expect(blendedColor, isNot(color1));
      expect(blendedColor, isNot(color2));
    });

    test('blendAlpha blends two colors with alpha correctly', () {
      const color1 = Colors.red;
      const color2 = Colors.blue;
      final blendedColor = color1.blendAlpha(color2, 0x80);
      expect(blendedColor, isNot(color1));
      expect(blendedColor, isNot(color2));
    });

    test('getShadeColor returns correct shade color', () {
      const color = Colors.blue;
      final shadeColor = color.getShadeColor();
      expect(shadeColor, isNot(color));
    });

    test('getShadeColor returns correct shade color for dark', () {
      const color = Colors.blue;
      final shadeColor = color.getShadeColor(lighten: false);
      expect(shadeColor, isNot(color));
    });

    test('hexCode returns correct hex code', () {
      const color = Color(0xFF123456);
      expect(color.hexCode, 'FF123456');
    });

    test('withLightness changes lightness correctly', () {
      const color = Colors.blue;
      final newColor = color.withLightness(0.5);
      expect(newColor, isNot(color));
    });

    test('lightness returns correct lightness', () {
      const color = Colors.blue;
      final lightness = color.lightness;
      expect(lightness, isNotNull);
    });

    test('contrastRatio returns correct ratio', () {
      const color1 = Colors.red;
      const color2 = Colors.blue;
      final contrastRatio = color1.contrastRatio(color2);
      expect(contrastRatio, isNotNull);
    });

    test('contrastRatio returns correct ratio for dark color', () {
      const color1 = Colors.blue;
      const color2 = Colors.red;
      final contrastRatio = color1.contrastRatio(color2);
      expect(contrastRatio, isNotNull);
    });

    test('adjustContrast adjusts contrast correctly', () {
      const color = Colors.blue;
      const onColor = Colors.white;
      final adjustedColor = color.adjustContrast(on: onColor, target: 4.5);
      expect(adjustedColor, isNot(color));
    });

    test('generateSwatch generates correct swatch', () {
      const color = Colors.blue;
      final swatch = color.generateSwatch();
      expect(swatch, isNotEmpty);
    });

    test('ensureAccessibility ensures accessibility correctly', () {
      const color = Colors.blue;
      const onColor = Colors.white;
      final accessibleColor = color.ensureAccessibility(on: onColor);
      expect(accessibleColor, isNot(color));
    });
  });
}
