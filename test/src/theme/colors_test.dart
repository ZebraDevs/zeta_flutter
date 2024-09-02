// ignore_for_file: deprecated_member_use_from_same_package

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
      expect(zetaColors.surfaceDefault, ZetaColorBase.white);
      expect(zetaColors.surfaceSecondary, isNotNull);
      expect(zetaColors.surfaceTertiary, isNotNull);
    });

    test('light constructor initializes correctly', () {
      final zetaColors = ZetaColors.light(
        warm: ZetaPrimitivesLight().warm,
        cool: ZetaPrimitivesLight().cool,
      );

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
      expect(zetaColors.surfaceDefault, ZetaColorBase.white);
      expect(zetaColors.surfaceSecondary, isNotNull);
      expect(zetaColors.surfaceTertiary, isNotNull);
    });

    test('dark constructor initializes correctly', () {
      final zetaColors = ZetaColors.dark(
        warm: ZetaPrimitivesLight().warm,
        cool: ZetaPrimitivesLight().cool,
      );

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
      expect(zetaColors.surfaceDefault, ZetaPrimitivesDark().pure.shade0);
      expect(zetaColors.surfaceSecondary, isNotNull);
      expect(zetaColors.surfaceTertiary, isNotNull);
    });

    test('copyWith creates a new instance with updated properties', () {
      final zetaColors = ZetaColors().copyWith();
      final newColors = zetaColors.copyWith(
        brightness: Brightness.dark,
        contrast: ZetaContrast.aaa,
        primary: ZetaPrimitivesLight().green,
        secondary: ZetaPrimitivesLight().orange,
      );

      expect(newColors.isDarkMode, true);
      expect(newColors.brightness, Brightness.dark);
      expect(newColors.contrast, ZetaContrast.aaa);
      expect(
        newColors.primary,
        ZetaPrimitivesLight().green.apply(brightness: Brightness.dark, contrast: ZetaContrast.aaa),
      );
      expect(
        newColors.secondary,
        ZetaPrimitivesLight().orange.apply(brightness: Brightness.dark, contrast: ZetaContrast.aaa),
      );
      expect(newColors.white, zetaColors.white);
      expect(newColors.black, zetaColors.black);
    });

    test('rainbow getters returns correct colors', () {
      final zetaColors = ZetaColors();
      expect(zetaColors.rainbow[0], zetaColors.red);
      expect(zetaColors.rainbow[1], zetaColors.orange);
      expect(zetaColors.rainbow[2], zetaColors.yellow);
      expect(zetaColors.rainbow[3], zetaColors.green);
      expect(zetaColors.rainbow[4], zetaColors.blue);
      expect(zetaColors.rainbow[5], zetaColors.teal);
      expect(zetaColors.rainbow[6], zetaColors.pink);

      expect(zetaColors.rainbowMap['red'], zetaColors.red);
      expect(zetaColors.rainbowMap['orange'], zetaColors.orange);
      expect(zetaColors.rainbowMap['yellow'], zetaColors.yellow);
      expect(zetaColors.rainbowMap['green'], zetaColors.green);
      expect(zetaColors.rainbowMap['blue'], zetaColors.blue);
      expect(zetaColors.rainbowMap['teal'], zetaColors.teal);
      expect(zetaColors.rainbowMap['pink'], zetaColors.pink);
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
      expect(scheme.surface, zetaColors.surfaceDefault);
      expect(scheme.error, zetaColors.error);
    });

    test('Color getter returns correct values', () {
      final zetaColors = ZetaColors();

      expect(zetaColors.mainDefault, ZetaPrimitivesLight().cool.shade90);
      expect(zetaColors.mainSubtle, ZetaPrimitivesLight().cool.shade70);
      expect(zetaColors.mainDisabled, ZetaPrimitivesLight().cool.shade50);
      expect(zetaColors.mainInverse, ZetaPrimitivesLight().cool.shade20);
      expect(zetaColors.mainDefault, ZetaPrimitivesLight().cool.shade90);
      expect(zetaColors.mainSubtle, ZetaPrimitivesLight().cool.shade70);
      expect(zetaColors.mainDisabled, ZetaPrimitivesLight().cool.shade50);
      expect(zetaColors.iconInverse, ZetaPrimitivesLight().cool.shade20);
      expect(zetaColors.surfaceDefault, ZetaPrimitivesLight().pure.shade(0));
      expect(zetaColors.surfaceDefaultInverse, ZetaPrimitivesLight().warm.shade(100));
      expect(zetaColors.surfaceHover, ZetaPrimitivesLight().cool.shade(20));
      expect(zetaColors.surfaceSelected, ZetaPrimitivesLight().blue.shade(10));
      expect(zetaColors.surfaceSelectedHover, ZetaPrimitivesLight().blue.shade(20));
      expect(zetaColors.surfaceDisabled, ZetaPrimitivesLight().cool.shade(30));
      expect(zetaColors.surfaceCool, ZetaPrimitivesLight().cool.shade(10));
      expect(zetaColors.surfaceWarm, ZetaPrimitivesLight().warm.shade(10));
      expect(zetaColors.surfacePrimarySubtle, ZetaPrimitivesLight().blue.shade(10));
      expect(zetaColors.surfaceAvatarBlue, ZetaPrimitivesLight().blue.shade(80));
      expect(zetaColors.surfaceAvatarOrange, ZetaPrimitivesLight().orange.shade(50));
      expect(zetaColors.surfaceAvatarPink, ZetaPrimitivesLight().pink.shade(80));
      expect(zetaColors.surfaceAvatarPurple, ZetaPrimitivesLight().purple.shade(80));
      expect(zetaColors.surfaceAvatarTeal, ZetaPrimitivesLight().teal.shade(80));
      expect(zetaColors.surfaceAvatarYellow, ZetaPrimitivesLight().yellow.shade(50));
      expect(zetaColors.surfaceSecondarySubtle, ZetaPrimitivesLight().yellow.shade(10));
      expect(zetaColors.surfacePositiveSubtle, ZetaPrimitivesLight().green.shade(10));
      expect(zetaColors.surfaceWarningSubtle, ZetaPrimitivesLight().orange.shade(10));
      expect(zetaColors.surfaceNegativeSubtle, ZetaPrimitivesLight().red.shade(10));
      expect(zetaColors.surfaceInfoSubtle, ZetaPrimitivesLight().purple.shade(10));
      expect(zetaColors.borderDefault, ZetaPrimitivesLight().cool.shade(40));
      expect(zetaColors.borderSubtle, ZetaPrimitivesLight().cool.shade(30));
      expect(zetaColors.borderHover, ZetaPrimitivesLight().cool.shade(90));
      expect(zetaColors.borderSelected, ZetaPrimitivesLight().cool.shade(90));
      expect(zetaColors.borderDisabled, ZetaPrimitivesLight().cool.shade(20));
      expect(zetaColors.borderPure, ZetaPrimitivesLight().pure.shade(0));
      expect(zetaColors.borderPrimary, ZetaPrimitivesLight().blue.shade(50));
      expect(zetaColors.borderSecondary, ZetaPrimitivesLight().yellow.shade(50));
      expect(zetaColors.borderPositive, ZetaPrimitivesLight().green.shade(50));
      expect(zetaColors.borderWarning, ZetaPrimitivesLight().orange.shade(50));
      expect(zetaColors.borderNegative, ZetaPrimitivesLight().red.shade(50));
      expect(zetaColors.borderInfo, ZetaPrimitivesLight().purple.shade(50));
      expect(zetaColors.surfacePositive, ZetaPrimitivesLight().green.shade60);
      expect(zetaColors.surfaceWarning, ZetaPrimitivesLight().orange.shade60);
      expect(zetaColors.surfaceNegative, ZetaPrimitivesLight().red.shade60);
      expect(zetaColors.surfaceAvatarGreen, ZetaPrimitivesLight().green);
      expect(zetaColors.surfaceInfo, ZetaPrimitivesLight().purple.shade60);
      expect(zetaColors.borderPrimaryMain, ZetaPrimitivesLight().blue);
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

  group('ZetaColorGetters', () {
    test('ColorScheme extension getters should return correct colors when scheme is ZetaColorScheme', () {
      final zetaColors = ZetaColors();
      final themeData = ThemeData.light().copyWith(colorScheme: zetaColors.toScheme());
      expect(themeData.colorScheme.primarySwatch, zetaColors.primary);
      expect(themeData.colorScheme.secondarySwatch, zetaColors.secondary);
      expect(themeData.colorScheme.cool, zetaColors.cool);
      expect(themeData.colorScheme.warm, zetaColors.warm);
      expect(themeData.colorScheme.textDefault, zetaColors.mainDefault);
      expect(themeData.colorScheme.textSubtle, zetaColors.mainSubtle);
      expect(themeData.colorScheme.textDisabled, zetaColors.mainDisabled);
      expect(themeData.colorScheme.textInverse, zetaColors.mainInverse);
      expect(themeData.colorScheme.surfacePrimary, zetaColors.surfaceDefault);
      expect(themeData.colorScheme.surfaceSecondary, zetaColors.surfaceCool);
      expect(themeData.colorScheme.surfaceTertiary, zetaColors.surfaceTertiary);
      expect(themeData.colorScheme.surfaceDisabled, zetaColors.surfaceDisabled);
      expect(themeData.colorScheme.surfaceHover, zetaColors.surfaceHover);
      expect(themeData.colorScheme.surfaceSelected, zetaColors.surfaceSelected);
      expect(themeData.colorScheme.surfaceSelectedHover, zetaColors.surfaceSelectedHover);
      expect(themeData.colorScheme.borderDefault, zetaColors.borderDefault);
      expect(themeData.colorScheme.borderSubtle, zetaColors.borderSubtle);
      expect(themeData.colorScheme.borderDisabled, zetaColors.borderDisabled);
      expect(themeData.colorScheme.borderSelected, zetaColors.borderSelected);
      expect(themeData.colorScheme.blue, zetaColors.blue);
      expect(themeData.colorScheme.green, zetaColors.green);
      expect(themeData.colorScheme.red, zetaColors.red);
      expect(themeData.colorScheme.orange, zetaColors.orange);
      expect(themeData.colorScheme.purple, zetaColors.purple);
      expect(themeData.colorScheme.yellow, zetaColors.yellow);
      expect(themeData.colorScheme.teal, zetaColors.teal);
      expect(themeData.colorScheme.pink, zetaColors.pink);
      expect(themeData.colorScheme.positive, zetaColors.green);
      expect(themeData.colorScheme.negative, zetaColors.red);
      expect(themeData.colorScheme.warning, zetaColors.orange);
      expect(themeData.colorScheme.info, zetaColors.purple);
    });

    test('ColorScheme extension getters should return default colors when ZetaColorScheme scheme is not injected', () {
      final themeData = ThemeData.light();
      expect(themeData.colorScheme.primarySwatch, ZetaPrimitivesLight().blue);
      expect(themeData.colorScheme.secondarySwatch, ZetaPrimitivesLight().yellow);
      expect(themeData.colorScheme.cool, ZetaPrimitivesLight().cool);
      expect(themeData.colorScheme.warm, ZetaPrimitivesLight().warm);
      expect(themeData.colorScheme.textDefault, ZetaPrimitivesLight().cool.shade90);
      expect(themeData.colorScheme.textSubtle, ZetaPrimitivesLight().cool.shade70);
      expect(themeData.colorScheme.textDisabled, ZetaPrimitivesLight().cool.shade50);
      expect(themeData.colorScheme.textInverse, ZetaPrimitivesLight().cool.shade20);
      expect(themeData.colorScheme.surfacePrimary, ZetaPrimitivesLight().pure.shade0);
      expect(themeData.colorScheme.surfaceSecondary, ZetaPrimitivesLight().cool.shade10);
      expect(themeData.colorScheme.surfaceTertiary, ZetaPrimitivesLight().warm.shade10);
      expect(themeData.colorScheme.surfaceDisabled, ZetaPrimitivesLight().cool.shade30);
      expect(themeData.colorScheme.surfaceHover, ZetaPrimitivesLight().cool.shade20);
      expect(themeData.colorScheme.surfaceSelected, ZetaPrimitivesLight().blue.shade10);
      expect(themeData.colorScheme.surfaceSelectedHover, ZetaPrimitivesLight().blue.shade20);
      expect(themeData.colorScheme.borderDefault, ZetaPrimitivesLight().cool.shade50);
      expect(themeData.colorScheme.borderSubtle, ZetaPrimitivesLight().cool.shade40);
      expect(themeData.colorScheme.borderDisabled, ZetaPrimitivesLight().cool.shade30);
      expect(themeData.colorScheme.borderSelected, ZetaPrimitivesLight().cool.shade90);
      expect(themeData.colorScheme.blue, ZetaPrimitivesLight().blue);
      expect(themeData.colorScheme.green, ZetaPrimitivesLight().green);
      expect(themeData.colorScheme.red, ZetaPrimitivesLight().red);
      expect(themeData.colorScheme.orange, ZetaPrimitivesLight().orange);
      expect(themeData.colorScheme.purple, ZetaPrimitivesLight().purple);
      expect(themeData.colorScheme.yellow, ZetaPrimitivesLight().yellow);
      expect(themeData.colorScheme.teal, ZetaPrimitivesLight().teal);
      expect(themeData.colorScheme.pink, ZetaPrimitivesLight().pink);
      expect(themeData.colorScheme.positive, ZetaPrimitivesLight().green);
      expect(themeData.colorScheme.negative, ZetaPrimitivesLight().red);
      expect(themeData.colorScheme.warning, ZetaPrimitivesLight().orange);
      expect(themeData.colorScheme.info, ZetaPrimitivesLight().purple);
    });
  });
}
