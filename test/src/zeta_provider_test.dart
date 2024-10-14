import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'zeta_provider_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ZetaThemeService>(),
])
void main() {
  final mockThemeService = MockZetaThemeService();
  final initialThemeData = ZetaThemeData();

  group('ZetaProvider', () {
    testWidgets('initializes with correct default values', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
        ),
      );

      final providerState = tester.state<ZetaProviderState>(find.byType(ZetaProvider));
      expect(providerState.widget.initialThemeMode, ThemeMode.system);
      expect(providerState.widget.initialContrast, ZetaContrast.aa);
      expect(providerState.widget.initialZetaThemeData, isNotNull);
    });

    testWidgets('initializes with provided values', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeMode: ThemeMode.light,
          initialContrast: ZetaContrast.aaa,
          initialThemeData: initialThemeData,
          themeService: mockThemeService,
        ),
      );

      final providerState = tester.state<ZetaProviderState>(find.byType(ZetaProvider));
      expect(providerState.widget.initialThemeMode, ThemeMode.light);
      expect(providerState.widget.initialContrast, ZetaContrast.aaa);
      expect(providerState.widget.initialZetaThemeData, initialThemeData);
      expect(providerState.widget.themeService, mockThemeService);
    });

    testWidgets('updateThemeMode updates the state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeData: initialThemeData,
          themeService: mockThemeService,
        ),
      );

      tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateThemeMode(ThemeMode.dark);
      await tester.pump();

      // Verifying through the public interface of Zeta widget
      final zeta = tester.widget<Zeta>(find.byType(Zeta));
      expect(zeta.themeMode, ThemeMode.dark);
      verify(
        mockThemeService.saveTheme(
          themeData: initialThemeData,
          themeMode: ThemeMode.dark,
          contrast: ZetaContrast.aa,
        ),
      ).called(1);
    });

    testWidgets('updateThemeData updates the state correctly', (WidgetTester tester) async {
      final newThemeData = ZetaThemeData();

      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeData: initialThemeData,
          themeService: mockThemeService,
        ),
      );

      tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateThemeData(newThemeData);
      await tester.pump();

      // Verifying through the public interface of Zeta widget
      final zeta = tester.widget<Zeta>(find.byType(Zeta));
      expect(zeta.themeData, newThemeData);
      verify(
        mockThemeService.saveTheme(
          themeData: newThemeData,
          themeMode: ThemeMode.system,
          contrast: ZetaContrast.aa,
        ),
      ).called(1);
    });

    testWidgets('updateContrast updates the state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeData: initialThemeData,
          themeService: mockThemeService,
        ),
      );

      tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateContrast(ZetaContrast.aaa);
      await tester.pump();

      // Verifying through the public interface of Zeta widget
      final zeta = tester.widget<Zeta>(find.byType(Zeta));
      expect(zeta.contrast, ZetaContrast.aaa);
      verify(
        mockThemeService.saveTheme(
          themeData: initialThemeData.apply(contrast: ZetaContrast.aaa),
          themeMode: ThemeMode.system,
          contrast: ZetaContrast.aaa,
        ),
      ).called(1);
    });

    testWidgets('updateRounded updates the state correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeData: initialThemeData,
          themeService: mockThemeService,
        ),
      );

      tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateRounded(false);
      await tester.pump();

      // Verifying through the public interface of Zeta widget
      final zeta = tester.widget<Zeta>(find.byType(Zeta));
      expect(zeta.rounded, false);
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in ThemeMode',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          initialThemeMode: ThemeMode.light,
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).themeMode, ThemeMode.light);

      await tester.pumpWidget(
        ZetaProvider(
          initialThemeMode: ThemeMode.dark,
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).themeMode, ThemeMode.dark);
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in contrast',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).contrast, ZetaContrast.aa);

      await tester.pumpWidget(
        ZetaProvider(
          initialContrast: ZetaContrast.aaa,
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).contrast, ZetaContrast.aaa);
    });

    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in theme data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          initialThemeData: initialThemeData,
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).themeData.identifier, 'default');

      await tester.pumpWidget(
        ZetaProvider(
          initialThemeData: ZetaThemeData(identifier: 'different'),
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).themeData.identifier, 'different');
    });
    testWidgets('didUpdateWidget in ZetaProviderState works correctly with change rounded',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          initialThemeData: initialThemeData,
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).rounded, true);

      await tester.pumpWidget(
        ZetaProvider(
          initialThemeData: initialThemeData,
          initialRounded: false,
          builder: (context, themeData, themeMode) => Builder(
            builder: (context) {
              return Container();
            },
          ),
        ),
      );

      await tester.pumpAndSettle(const Duration(milliseconds: 250));

      // Verifying through the public interface of Zeta widget
      expect(tester.widget<Zeta>(find.byType(Zeta)).rounded, false);
    });

    testWidgets('retrieves ZetaProviderState from context', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Builder(
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
      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeData: initialThemeData,
        ),
      );

      // Rebuild the widget tree
      await tester.pumpAndSettle();

      // Get test binding
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

      // Simulate platform brightness change to dark
      binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;

      await tester.pumpAndSettle(const Duration(milliseconds: 550));

      // Verifying through the public interface of Zeta widget
      final zeta = tester.widget<Zeta>(find.byType(Zeta));
      expect(zeta.brightness, Brightness.dark);
    });

    testWidgets('generateZetaTheme applies zeta values to existing theme', (WidgetTester tester) async {
      final ColorScheme colors = ColorScheme.fromSeed(seedColor: Colors.red);

      final theme = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: ZetaColors.light().toScheme(),
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
        ),
      );
      expect(theme2.useMaterial3, false);
      expect(theme2.brightness, Brightness.light);
      expect(theme2.primaryColor, Colors.red);

      expect(theme2.scaffoldBackgroundColor, ZetaColors.light().toScheme().surfaceTertiary);
    });
    testWidgets('generateZetaTheme generates a new theme', (WidgetTester tester) async {
      final theme = generateZetaTheme(brightness: Brightness.light, colorScheme: ZetaColors.light().toScheme());
      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.light);
      expect(theme.colorScheme, ZetaColors.light().toScheme());

      final theme2 = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: ZetaColors.light().toScheme(),
        zetaThemeData: initialThemeData,
      );

      expect(theme2.iconTheme.color, initialThemeData.colorsLight.iconDefault);
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();

      ZetaProvider(
        builder: (context, themeData, themeMode) => Container(),
        initialThemeData: initialThemeData,
        themeService: mockThemeService,
      ).debugFillProperties(diagnostics);

      final description =
          diagnostics.properties.where((p) => p.name == 'themeData').map((p) => p.toDescription()).first;
      expect(description, contains('ZetaThemeData'));

      final themeMode =
          diagnostics.properties.where((p) => p.name == 'initialThemeMode').map((p) => p.toDescription()).first;
      expect(themeMode, 'system');

      final contrast =
          diagnostics.properties.where((p) => p.name == 'initialContrast').map((p) => p.toDescription()).first;
      expect(contrast, 'aa');

      final themeService =
          diagnostics.properties.where((p) => p.name == 'themeService').map((p) => p.toDescription()).first;
      expect(themeService, isNotNull);
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();

      await tester.pumpWidget(
        ZetaProvider(
          builder: (context, themeData, themeMode) => Container(),
          initialThemeData: initialThemeData,
        ),
      );

      // Rebuild the widget tree
      await tester.pumpAndSettle();

      tester.state<ZetaProviderState>(find.byType(ZetaProvider)).debugFillProperties(diagnostics);

      final description =
          diagnostics.properties.where((p) => p.name == 'themeData').map((p) => p.toDescription()).first;
      expect(description, contains('ZetaThemeData'));

      final contrast = diagnostics.properties.where((p) => p.name == 'contrast').map((p) => p.toDescription()).first;
      expect(contrast, 'aa');

      final themeMode = diagnostics.properties.where((p) => p.name == 'themeMode').map((p) => p.toDescription()).first;
      expect(themeMode, 'system');
    });
  });
}
