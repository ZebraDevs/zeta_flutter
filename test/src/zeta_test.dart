import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/theme/contrast.dart';
import 'package:zeta_flutter/src/theme/theme_data.dart';
import 'package:zeta_flutter/src/zeta.dart';

void main() {
  group('Zeta InheritedWidget', () {
    testWidgets('provides correct colors in light mode', (WidgetTester tester) async {
      final themeData = ZetaThemeData();

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.light,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.light,
          themeData: themeData,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.colors, themeData.colorsLight);
    });

    testWidgets('provides correct colors in dark mode', (WidgetTester tester) async {
      final themeData = ZetaThemeData();

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.dark,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.dark,
          themeData: themeData,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.colors, themeData.colorsDark);
    });

    testWidgets('provides correct colors in system mode with light media brightness', (WidgetTester tester) async {
      final themeData = ZetaThemeData();

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.light,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.system,
          themeData: themeData,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.colors, themeData.colorsLight);
    });

    testWidgets('provides correct colors in system mode with dark media brightness', (WidgetTester tester) async {
      final themeData = ZetaThemeData();

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.dark,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.system,
          themeData: themeData,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.colors, themeData.colorsDark);
    });

    testWidgets('throws FlutterError if Zeta is not found in widget tree', (WidgetTester tester) async {
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
      expect(() => Zeta.of(tester.element(find.byType(Container))), throwsA(isA<Error>()));
    });
  });

  group('Zeta properties', () {
    testWidgets('brightness getter works correctly', (WidgetTester tester) async {
      final themeData = ZetaThemeData();

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.light,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.system,
          themeData: themeData,
          child: Container(),
        ),
      );

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.brightness, Brightness.light);

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.dark,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.dark,
          themeData: themeData,
          child: Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      final zetaDark = Zeta.of(tester.element(find.byType(Container)));
      expect(zetaDark.brightness, Brightness.dark);

      await tester.pumpWidget(
        Zeta(
          mediaBrightness: Brightness.light,
          contrast: ZetaContrast.aa,
          themeMode: ThemeMode.light,
          themeData: themeData,
          child: Container(),
        ),
      );

      final zetaLight = Zeta.of(tester.element(find.byType(Container)));
      expect(zetaLight.brightness, Brightness.light);
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final themeData = ZetaThemeData();

      final diagnostics = DiagnosticPropertiesBuilder();
      Zeta(
        mediaBrightness: Brightness.light,
        contrast: ZetaContrast.aa,
        themeMode: ThemeMode.system,
        themeData: themeData,
        child: Container(),
      ).debugFillProperties(diagnostics);

      final description = diagnostics.properties.where((p) => p.name == 'contrast').map((p) => p.toDescription()).first;
      expect(description, 'aa');

      final themeMode = diagnostics.properties.where((p) => p.name == 'themeMode').map((p) => p.toDescription()).first;
      expect(themeMode, 'system');

      final thData = diagnostics.properties.where((p) => p.name == 'themeData').map((p) => p.toDescription()).first;
      expect(thData, contains('ZetaThemeData'));

      final colors = diagnostics.properties.where((p) => p.name == 'colors').map((p) => p.toDescription()).first;
      expect(colors, contains('ZetaColors'));

      final mediaBrightness =
          diagnostics.properties.where((p) => p.name == 'mediaBrightness').map((p) => p.toDescription()).first;
      expect(mediaBrightness, 'light');

      final brightness =
          diagnostics.properties.where((p) => p.name == 'brightness').map((p) => p.toDescription()).first;
      expect(brightness, 'light');
    });
  });
}
