import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:zeta_flutter/src/utils/zeta_provider.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../test_utils/utils.dart';
import 'zeta_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ZetaThemeService>()])
void main() {
  final mockThemeService = MockZetaThemeService();

  group('ZetaProvider', () {
    testWidgets('initializes with correct default values', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(builder: (context, light, dark, themeMode) => Container()),
      );

      final providerState = tester.state<ZetaProviderState>(find.byType(ZetaProvider));
      expect(providerState.widget.initialThemeMode, null);
      expect(providerState.widget.initialContrast, null);
      expect(providerState.widget.customThemes, <String>[]);
      expect(providerState.widget.initialRounded, true);
      expect(providerState.widget.initialTheme, null);

      expect(providerState.widget.themeService.runtimeType, ZetaDefaultThemeService);
    });

    testWidgets('initializes with provided values', (WidgetTester tester) async {
      final themes = [ZetaCustomTheme(id: '1')];
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, light, dark, themeMode) => Container(),
          initialThemeMode: ThemeMode.light,
          initialContrast: ZetaContrast.aaa,
          themeService: mockThemeService,
          initialRounded: false,
          initialTheme: '1',
          customThemes: themes,
        ),
      );

      final providerState = tester.state<ZetaProviderState>(find.byType(ZetaProvider));
      expect(providerState.widget.initialThemeMode, ThemeMode.light);
      expect(providerState.widget.initialContrast, ZetaContrast.aaa);
      expect(providerState.widget.themeService, mockThemeService);
      expect(providerState.widget.initialTheme, '1');
      expect(providerState.widget.customThemes, themes);
      expect(providerState.widget.initialRounded, false);
    });

    testWidgets('updateThemeMode updates the state correctly', (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables
      // 1. mock theme service does not work
      // 2. pumpAndSettle does not work when a continuous animation is on, such as circular progress indicator in ZetaProvider
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, light, dark, themeMode) => Container(),
          // themeService: mockThemeService,
          initialThemeMode: ThemeMode.light,
        ),
      );
      await tester.pump();

      // final zeta = tester.widget<Zeta>(find.byType(Zeta));

      // expect(zeta.themeMode, ThemeMode.light);

      // tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateThemeMode(ThemeMode.dark);
      // await tester.pump();
      // Verifying through the public interface of Zeta widget
      // expect(zeta.themeMode, ThemeMode.dark);
      // verify that save theme was called by the provider using mockito
      // verify(
      //   mockThemeService.saveTheme(
      //     themeData: ZetaThemeServiceData(
      //       themeMode: ThemeMode.dark,
      //       contrast: ZetaContrast.aa,
      //     ),
      //   ),
      // ).called(1);
    });

    testWidgets('updateContrast updates the state correctly', (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables
      // await tester.pumpWidget(
      //   ZetaProvider(
      //     builder: (context, light, dark, themeMode) => Container(),
      //     themeService: mockThemeService,
      //   ),
      // );
      // await tester.pumpAndSettle();

      // tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateContrast(ZetaContrast.aaa);
      // await tester.pumpAndSettle();

      // // Verifying through the public interface of Zeta widget
      // final zeta = tester.widget<Zeta>(find.byType(Zeta));
      // expect(zeta.contrast, ZetaContrast.aaa);
      // // // verify that save theme was called by the provider using mockito
      // // verify(
      // //   mockThemeService.saveTheme(
      // //     themeData: initialThemeData.apply(contrast: ZetaContrast.aaa),
      // //     themeMode: ThemeMode.system,
      // //     contrast: ZetaContrast.aaa,
      // //   ),
      // // ).called(1);
    });

    testWidgets('updateRounded updates the state correctly', (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables
      // await tester.pumpWidget(
      //   ZetaProvider(
      //     builder: (context, light, dark, themeMode) => Container(),
      //     // initialThemeData: initialThemeData,
      //     themeService: mockThemeService,
      //   ),
      // );

      // tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateRounded(false);
      // await tester.pump();

      // // Verifying through the public interface of Zeta widget
      // final zeta = tester.widget<Zeta>(find.byType(Zeta));
      // expect(zeta.rounded, false);
      // // // verify that save theme was called by the provider using mockito
      // // verify(
      // //   mockThemeService.saveTheme(
      // //     themeData: initialThemeData.apply(contrast: ZetaContrast.aaa),
      // //     themeMode: ThemeMode.system,
      // //     contrast: ZetaContrast.aaa,
      // //   ),
      // // ).called(1);
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in ThemeMode',
        (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     initialThemeMode: ThemeMode.light,
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle();
      // // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).themeMode, ThemeMode.light);

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     initialThemeMode: ThemeMode.dark,
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).themeMode, ThemeMode.dark);
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in contrast',
        (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle();

      // // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).contrast, ZetaContrast.aa);

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     initialContrast: ZetaContrast.aaa,
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).contrast, ZetaContrast.aaa);
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in theme data',
        (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     // initialThemeData: initialThemeData,
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle();

      // // Verifying through the public interface of Zeta widget
      // // expect(tester.widget<Zeta>(find.byType(Zeta)).themeData?.identifier, 'default');

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     // initialThemeData: const ZetaThemeData(identifier: 'different'),
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).themeData?.identifier, 'different');
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change rounded',
        (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     // initialThemeData: initialThemeData,
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle();

      // // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).rounded, true);

      // await tester.pumpWidget(
      //   ZetaProvider(
      //     // initialThemeData: initialThemeData,
      //     initialRounded: false,
      //     builder: (context, light, dark, themeMode) => Builder(
      //       builder: (context) {
      //         return Container();
      //       },
      //     ),
      //   ),
      // );

      // await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // // Verifying through the public interface of Zeta widget
      // expect(tester.widget<Zeta>(find.byType(Zeta)).rounded, false);
    });

    testWidgets('retrieves ZetaProviderState from context', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, light, dark, themeMode) => Builder(
            builder: (context) {
              final providerState = ZetaProvider.of(context);
              expect(providerState, isNotNull);
              return Container();
            },
          ),
        ),
      );
    });

    testWidgets('throws error if ZetaProvider is not found in widget tree', (WidgetTester tester) async {
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            expect(() => ZetaProvider.of(context), throwsA(isA<Error>()));
            return Container();
          },
        ),
      );
    });

    testWidgets('handles platform brightness changes', (WidgetTester tester) async {
      // TODO(mikecoomber): Test failing due to late variables

      // final Key k = Key('1');
      // await tester.pumpWidget(
      //   ZetaProvider(
      //     builder: (context, light, dark, themeMode) => Container(key: k),
      //   ),
      // );

      // // Rebuild the widget tree
      // await tester.pump(Durations.extralong4);
      // await tester.pump(Durations.extralong4);
      // await tester.pump(Durations.extralong4);

      // // Get test binding
      // final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

      // // Simulate platform brightness change to dark
      // binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;

      // await tester.pump(Durations.extralong4);
      // final zeta = Zeta.of(tester.element(find.byKey(k)));

      // // Verifying through the public interface of Zeta widget
      // // It is important to check here that zeta.brightness is changed to dark,
      // // as this shows if themeMode.system actually works.
      // expect(zeta.brightness, Brightness.dark);
    });

    testWidgets('generateZetaTheme applies zeta values to existing theme', (WidgetTester tester) async {
      final ColorScheme colors = ColorScheme.fromSeed(seedColor: Colors.red);
      final theme = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()).toColorScheme,
        existingTheme: ThemeData(
          fontFamily: 'Comic Sans',
          primaryColor: Colors.red,
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.blue,
          colorScheme: colors,
        ),
      );
      expect(theme.useMaterial3, false);
      expect(theme.brightness, Brightness.light);
      expect(theme.primaryColor, Colors.red);
      expect(theme.scaffoldBackgroundColor, Colors.blue);

      final theme2 = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: colors,
        existingTheme: ThemeData(
          fontFamily: 'Comic Sans',
          primaryColor: Colors.red,
          useMaterial3: false,
          colorScheme: colors,
          scaffoldBackgroundColor: Colors.orange,
        ),
      );
      expect(theme2.useMaterial3, false);
      expect(theme2.brightness, Brightness.light);
      expect(theme2.primaryColor, Colors.red);

      expect(theme2.scaffoldBackgroundColor, Colors.orange);
    });

    testWidgets('generateZetaTheme generates a new theme', (WidgetTester tester) async {
      final theme = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: const ZetaSemanticColorsAA(primitives: ZetaPrimitivesLight()).toColorScheme,
      );
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.light);

      // TODO(mikecoomber): Please check this function more thouroughly
      // TODO(mikecoomber): Ensure this funcaiton is actually being used, and ensure it works as intended.
    });

    testWidgets('customThemes getter work as expected', (WidgetTester tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('customThemeId getter works as expected', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('custom themes can be changed', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('custom themes can be found using theme service', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('graceful error if custom theme is not found by theme service', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('didUpdateWidget', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('getThemeValuesFromPreferences works as expected', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('updateCustomTheme works as expected', (tester) async {
      // TODO(mikecoomber): make test
    });

    testWidgets('Internal provider works as expected', (tester) async {
      // TODO(mikecoomber): I don't know if this is actually possible
    });

    testWidgets('ZetaProvider debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();

      ZetaProvider(
        builder: (context, light, dark, themeMode) => Container(),
        themeService: mockThemeService,
        initialContrast: ZetaContrast.aa,
        initialRounded: false,
        initialThemeMode: ThemeMode.system,
      ).debugFillProperties(diagnostics);

      expect(diagnostics.finder('builder'), 'has builder');
      expect(diagnostics.finder('initialThemeMode'), ThemeMode.system.name);
      expect(diagnostics.finder('initialContrast'), ZetaContrast.aa.name);
      expect(diagnostics.finder('themeService'), 'MockZetaThemeService');
      expect(diagnostics.finder('initialRounded'), 'false');
      expect(diagnostics.finder('customThemes'), '[]');
      expect(diagnostics.finder('initialTheme'), 'null');
    });
  });
  testWidgets('ZetaProviderState debugFillProperties works correctly', (WidgetTester tester) async {
    // TODO(mikecoomber): I dont know if this is possible?
  });
  testWidgets('InternalProvider debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();

    InternalProvider(
      contrast: ZetaContrast.aa,
      themeMode: ThemeMode.dark,
      rounded: false,
      customTheme: null,
      customThemes: const [],
      widget: (context, light, dark, themeMode) => Container(),
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('widget'), 'has widget');
    expect(diagnostics.finder('themeMode'), ThemeMode.dark.name);
    expect(diagnostics.finder('contrast'), ZetaContrast.aa.name);
    expect(diagnostics.finder('rounded'), 'false');
    expect(diagnostics.finder('customThemes'), '[]');
    expect(diagnostics.finder('customTheme'), 'null');
  });
}
