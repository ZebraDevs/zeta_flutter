import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test_utils/utils.dart';

void main() {
  group('Zeta InheritedWidget', () {
    testWidgets('provides correct default colors in light mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.light,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.colors, const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('provides correct default colors in dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.dark,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));
      expect(zeta.colors, const ZetaSemanticColorsAA(primitives: ZetaPrimitivesDark()));
    });

    testWidgets('provides AAA colors in light mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.light,
          contrast: ZetaContrast.aaa,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));

      expect(zeta.colors, const ZetaSemanticColorsAAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('provides AAA colors in dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.dark,
          contrast: ZetaContrast.aaa,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));

      expect(zeta.colors, const ZetaSemanticColorsAAA(primitives: ZetaPrimitivesDark()));
    });

    testWidgets('provides custom primitives in light mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.light,
          customPrimitives: const ZetaPrimitivesDark(),
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));

      /// We set custom primitives to be dark, even though the theme mode is light.
      expect(zeta.colors, const ZetaSemanticColorsAA(primitives: ZetaPrimitivesDark()));
    });

    testWidgets('provides custom primitives in dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.dark,
          customPrimitives: const ZetaPrimitivesLight(),
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));

      /// We set custom primitives to be light, even though the theme mode is dark.
      expect(zeta.colors, const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('provides custom semantics in AA mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          // ignore: avoid_redundant_argument_values
          contrast: ZetaContrast.aa,
          customSemantics: ZetaSemanticsAAA(primitives: const ZetaPrimitivesLight()),
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));

      /// We set custom primitives to be AAA, even though the contrast is AA.
      expect(zeta.colors, const ZetaSemanticColorsAAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('provides custom semantics in AAA mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          contrast: ZetaContrast.aaa,
          customSemantics: ZetaSemanticsAA(primitives: const ZetaPrimitivesLight()),
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();

      final zeta = Zeta.of(tester.element(find.byType(Container)));

      /// We set custom primitives to be AA, even though the contrast is AAA.
      expect(zeta.colors, const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('provides size tokens', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.light,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();
      final zeta = Zeta.of(tester.element(find.byType(Container)));

      expect(zeta.spacing, const ZetaSemanticSpacesAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('provides radius tokens', (WidgetTester tester) async {
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.light,
          child: Container(),
        ),
      );

      await tester.pumpAndSettle();
      final zeta = Zeta.of(tester.element(find.byType(Container)));

      expect(zeta.radius, const ZetaSemanticRadiiAA(primitives: ZetaPrimitivesLight()));
    });

    testWidgets('throws FlutterError if Zeta is not found in widget tree', (WidgetTester tester) async {
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
      expect(() => Zeta.of(tester.element(find.byType(Container))), throwsA(isA<Error>()));
    });
  });

  group('Zeta properties', () {
    testWidgets('updates correctly on state change', (WidgetTester tester) async {
      // TODO(mikecoomber): test updateShouldNotify
      // I think this test might be redundant because all of this is essentially being tested in the zeta_provider tests.
    });

    testWidgets('brightness getter works correctly', (WidgetTester tester) async {
      const Key test1 = Key('1');
      const Key test2 = Key('2');
      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.light,
          child: Container(key: test1),
        ),
      );

      final zeta = Zeta.of(tester.element(find.byKey(test1)));
      expect(zeta.brightness, Brightness.light);

      await tester.pumpWidget(
        Zeta(
          themeMode: ThemeMode.dark,
          child: Container(key: test2),
        ),
      );

      final zetaDark = Zeta.of(tester.element(find.byKey(test2)));
      expect(zetaDark.brightness, Brightness.dark);
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();
      Zeta(child: Container()).debugFillProperties(diagnostics);
      expect(diagnostics.finder('rounded'), 'true');
      expect(diagnostics.finder('colors'), const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()).toString());
      expect(diagnostics.finder('brightness'), Brightness.light.name);
      expect(diagnostics.finder('radius'), const ZetaSemanticRadiiAA(primitives: ZetaPrimitivesLight()).toString());
      expect(diagnostics.finder('spacing'), const ZetaSemanticSpacesAA(primitives: ZetaPrimitivesLight()).toString());
      expect(diagnostics.finder('primitives'), const ZetaPrimitivesLight().toString());
      expect(diagnostics.finder('semantics'), ZetaSemanticsAA(primitives: const ZetaPrimitivesLight()).toString());
      expect(diagnostics.finder('contrast'), ZetaContrast.aa.name);
      expect(diagnostics.finder('themeMode'), ThemeMode.system.name);
    });
  });
}
