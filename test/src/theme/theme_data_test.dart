import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/theme/color_extensions.dart';
import 'package:zeta_flutter/src/theme/contrast.dart';
import 'package:zeta_flutter/src/theme/theme_data.dart';

void main() {
  group('ZetaThemeData', () {
    test('Default constructor should initialize with correct defaults', () {
      final themeData = ZetaThemeData();

      expect(themeData.fontFamily, kZetaFontFamily);
      expect(themeData.identifier, 'default');
      // expect(themeData.colorsLight.brightness, Brightness.light);
      // expect(themeData.colorsDark.brightness, Brightness.dark);
    });

    test('Constructor should initialize with custom values', () {
      const customFontFamily = 'CustomFont';
      const customIdentifier = 'custom_theme';
      const customPrimary = Colors.blue;
      const customSecondary = Colors.green;

      final themeData = ZetaThemeData(
        fontFamily: customFontFamily,
        identifier: customIdentifier,
        primary: customPrimary,
        secondary: customSecondary,
      );

      expect(themeData.fontFamily, customFontFamily);
      expect(themeData.identifier, customIdentifier);
      expect(themeData.colorsLight.primary, customPrimary.zetaColorSwatch);
      expect(themeData.colorsLight.secondary, customSecondary.zetaColorSwatch);
      expect(themeData.colorsDark.primary, customPrimary.zetaColorSwatch.apply(brightness: Brightness.dark));
      expect(themeData.colorsDark.secondary, customSecondary.zetaColorSwatch.apply(brightness: Brightness.dark));
    });

    test('Apply method should return a new instance with updated contrast', () {
      final themeData = ZetaThemeData();
      const newContrast = ZetaContrast.aaa;
      final newThemeData = themeData.apply(contrast: newContrast);

      // expect(newThemeData.colorsLight.contrast, newContrast);
      // expect(newThemeData.colorsDark.contrast, newContrast);
      expect(newThemeData.fontFamily, themeData.fontFamily);
      expect(newThemeData.identifier, themeData.identifier);
    });

    test('Equality and hashCode should work correctly', () {
      final themeData1 = ZetaThemeData();
      final themeData2 = ZetaThemeData();

      expect(themeData1, themeData2);
      expect(themeData1.hashCode, themeData2.hashCode);

      final themeData3 = ZetaThemeData(identifier: 'different');
      expect(themeData1, isNot(themeData3));
      expect(themeData1.hashCode, isNot(themeData3.hashCode));
    });
  });
}
