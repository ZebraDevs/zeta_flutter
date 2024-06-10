import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

void main() {
  group('ZetaColors', () {
    test('default constructor initializes correctly', () {
      final zetaColors = ZetaColors();

      expect(zetaColors.brightness, Brightness.light);
      expect(zetaColors.contrast, ZetaContrast.aa);
      expect(zetaColors.white, ZetaColorBase.white);
      expect(zetaColors.black, ZetaColorBase.black);
      expect(zetaColors.primary, isNotNull);
      expect(zetaColors.secondary, isNotNull);
      expect(zetaColors.error, isNotNull);
      expect(zetaColors.cool, isNotNull);
      expect(zetaColors.warm, isNotNull);
      expect(zetaColors.pure, isNotNull);
      expect(zetaColors.surfacePrimary, ZetaColorBase.white);
      expect(zetaColors.surfaceSecondary, isNotNull);
      expect(zetaColors.surfaceTertiary, isNotNull);
    });

    test('light constructor initializes correctly', () {
      final zetaColors = ZetaColors.light();

      expect(zetaColors.brightness, Brightness.light);
      expect(zetaColors.contrast, ZetaContrast.aa);
      expect(zetaColors.white, ZetaColorBase.white);
      expect(zetaColors.black, ZetaColorBase.black);
      expect(zetaColors.primary, isNotNull);
      expect(zetaColors.secondary, isNotNull);
      expect(zetaColors.error, isNotNull);
      expect(zetaColors.cool, isNotNull);
      expect(zetaColors.warm, isNotNull);
      expect(zetaColors.pure, isNotNull);
      expect(zetaColors.surfacePrimary, ZetaColorBase.white);
      expect(zetaColors.surfaceSecondary, isNotNull);
      expect(zetaColors.surfaceTertiary, isNotNull);
    });

    test('dark constructor initializes correctly', () {
      final zetaColors = ZetaColors.dark();

      expect(zetaColors.brightness, Brightness.dark);
      expect(zetaColors.contrast, ZetaContrast.aa);
      expect(zetaColors.white, ZetaColorBase.white);
      expect(zetaColors.black, ZetaColorBase.black);
      expect(zetaColors.primary, isNotNull);
      expect(zetaColors.secondary, isNotNull);
      expect(zetaColors.error, isNotNull);
      expect(zetaColors.cool, isNotNull);
      expect(zetaColors.warm, isNotNull);
      expect(zetaColors.pure, isNotNull);
      expect(zetaColors.surfacePrimary, ZetaColorBase.black);
      expect(zetaColors.surfaceSecondary, isNotNull);
      expect(zetaColors.surfaceTertiary, isNotNull);
    });

    test('copyWith creates a new instance with updated properties', () {
      final zetaColors = ZetaColors();
      final newColors = zetaColors.copyWith(
        brightness: Brightness.dark,
        contrast: ZetaContrast.aaa,
        primary: ZetaColorBase.green,
        secondary: ZetaColorBase.orange,
      );

      expect(newColors.brightness, Brightness.dark);
      expect(newColors.contrast, ZetaContrast.aaa);
      expect(newColors.primary, ZetaColorBase.green.apply(brightness: Brightness.dark, contrast: ZetaContrast.aaa));
      expect(newColors.secondary, ZetaColorBase.orange.apply(brightness: Brightness.dark, contrast: ZetaContrast.aaa));
      expect(newColors.white, zetaColors.white);
      expect(newColors.black, zetaColors.black);
    });

    test('apply returns a new instance with updated contrast', () {
      final zetaColors = ZetaColors();
      final newColors = zetaColors.apply(contrast: ZetaContrast.aaa);

      expect(newColors.contrast, ZetaContrast.aaa);
      expect(newColors.primary, isNotNull);
      expect(newColors.secondary, isNotNull);
      expect(newColors.error, isNotNull);
      expect(newColors.cool, isNotNull);
      expect(newColors.warm, isNotNull);
      expect(newColors.pure, isNotNull);
    });

    test('toScheme returns a ZetaColorScheme with correct values', () {
      final zetaColors = ZetaColors();
      final scheme = zetaColors.toScheme();

      expect(scheme.zetaColors, zetaColors);
      expect(scheme.brightness, zetaColors.brightness);
      expect(scheme.primary, zetaColors.primary.shade(zetaColors.contrast.primary));
      expect(scheme.secondary, zetaColors.secondary.shade(zetaColors.contrast.primary));
      expect(scheme.surface, zetaColors.surfacePrimary);
      expect(scheme.error, zetaColors.error);
    });

    test('deprecated properties return correct values', () {
      final zetaColors = ZetaColors();

      expect(zetaColors.surfaceHovered, zetaColors.surfaceHover);
      expect(zetaColors.surfaceSelectedHovered, zetaColors.surfaceSelectedHover);
      expect(zetaColors.positive, zetaColors.surfacePositive);
      expect(zetaColors.negative, zetaColors.surfaceNegative);
      expect(zetaColors.warning, zetaColors.surfaceWarning);
      expect(zetaColors.info, zetaColors.surfaceInfo);
      expect(zetaColors.shadow, const Color(0x1A49505E));
      expect(zetaColors.link, ZetaColorBase.linkLight);
      expect(zetaColors.linkVisited, ZetaColorBase.linkVisitedLight);
    });

    test('props returns correct list of properties', () {
      final zetaColors = ZetaColors();

      expect(
        zetaColors.props,
        [
          zetaColors.brightness,
          zetaColors.contrast,
          zetaColors.primary,
          zetaColors.secondary,
          zetaColors.error,
          zetaColors.cool,
          zetaColors.warm,
          zetaColors.white,
          zetaColors.black,
          zetaColors.surfacePrimary,
          zetaColors.surfaceSecondary,
          zetaColors.surfaceTertiary,
        ],
      );
    });
  });
}
