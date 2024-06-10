import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() {
  group('ZetaColorScheme', () {
    const String fontFamily = 'TestFontFamily';
    final ZetaColors zetaColors = ZetaColors(
      primary: ZetaColorBase.blue,
      secondary: ZetaColorBase.green,
      surfacePrimary: ZetaColorBase.white,
      surfaceTertiary: ZetaColorBase.white,
      error: ZetaColorBase.red,
    );

    final ZetaColorScheme zetaColorScheme = ZetaColorScheme(
      zetaColors: zetaColors,
      fontFamily: fontFamily,
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.green,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.grey,
      onSurface: Colors.black,
    );

    test('initialization of properties', () {
      expect(zetaColorScheme.zetaColors, zetaColors);
      expect(zetaColorScheme.fontFamily, fontFamily);
      expect(zetaColorScheme.brightness, Brightness.light);
      expect(zetaColorScheme.primary, Colors.blue);
      expect(zetaColorScheme.onPrimary, Colors.white);
      expect(zetaColorScheme.secondary, Colors.green);
      expect(zetaColorScheme.onSecondary, Colors.white);
      expect(zetaColorScheme.error, Colors.red);
      expect(zetaColorScheme.onError, Colors.white);
      expect(zetaColorScheme.surface, Colors.grey);
      expect(zetaColorScheme.onSurface, Colors.black);
    });

    test('copyWith copies and overrides properties correctly', () {
      final newZetaColors = ZetaColors(
        primary: ZetaColorBase.purple,
        secondary: ZetaColorBase.orange,
        surfacePrimary: ZetaColorBase.yellow,
        surfaceTertiary: ZetaColorBase.yellow,
        error: ZetaColorBase.pink,
      );
      const newFontFamily = 'NewTestFontFamily';

      final copied = zetaColorScheme.copyWith(
        zetaColors: newZetaColors,
        fontFamily: newFontFamily,
        primary: Colors.purple,
        onPrimary: Colors.black,
      );

      expect(copied.zetaColors, newZetaColors);
      expect(copied.fontFamily, newFontFamily);
      expect(copied.primary, Colors.purple);
      expect(copied.onPrimary, Colors.black);
      expect(copied.secondary, zetaColorScheme.secondary); // Unchanged property
    });

    test('equality operator works as expected', () {
      final identicalColorScheme = ZetaColorScheme(
        zetaColors: zetaColors,
        fontFamily: fontFamily,
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.white,
        secondary: Colors.green,
        onSecondary: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.grey,
        onSurface: Colors.black,
      );

      expect(zetaColorScheme, identicalColorScheme);
      expect(zetaColorScheme.hashCode, identicalColorScheme.hashCode);
      expect(zetaColorScheme == identicalColorScheme, isTrue);
    });

    test('debugFillProperties includes correct properties', () {
      final DiagnosticPropertiesBuilder properties = DiagnosticPropertiesBuilder();
      zetaColorScheme.debugFillProperties(properties);

      final zetaColorsProperty = properties.properties.firstWhere(
        (prop) => prop is DiagnosticsProperty<ZetaColors> && prop.name == 'zetaColors',
      ) as DiagnosticsProperty<ZetaColors>?;

      final fontFamilyProperty = properties.properties.firstWhere(
        (prop) => prop is StringProperty && prop.name == 'fontFamily',
      ) as StringProperty?;

      expect(zetaColorsProperty, isNotNull);
      expect(zetaColorsProperty?.value, zetaColors);

      expect(fontFamilyProperty, isNotNull);
      expect(fontFamilyProperty?.value, fontFamily);
    });
  });
}
