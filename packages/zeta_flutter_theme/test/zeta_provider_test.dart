import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter_theme/zeta_flutter_theme.dart';
import '../../zeta_flutter/test/test_utils/test_utils.dart';

import 'zeta_provider_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ZetaThemeService>()])
void main() {
  group('ZetaProvider', () {
    late MockZetaThemeService mockThemeService;

    setUp(() async {
      mockThemeService = MockZetaThemeService();

      when(mockThemeService.loadTheme()).thenAnswer(
        (_) async => const ZetaThemeServiceData(),
      );
      when(mockThemeService.saveTheme(themeData: anyNamed('themeData'))).thenAnswer(
        (_) async => {},
      );
    });

    group('initializers', () {
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

      testWidgets('initializes values in Zeta', (WidgetTester tester) async {
        await tester.pumpWidget(
          ZetaProvider(
            builder: (context, light, dark, themeMode) => Container(),
            themeService: mockThemeService,
            initialThemeMode: ThemeMode.dark,
            initialContrast: ZetaContrast.aaa,
            customLoadingWidget: const SizedBox(),
          ),
        );
        await tester.pumpAndSettle();

        final zeta = tester.widget<Zeta>(find.byType(Zeta));

        expect(zeta.themeMode, ThemeMode.dark);
        expect(zeta.contrast, ZetaContrast.aaa);
      });
    });

    group('updates state', () {
      late ZetaProvider subject;

      setUp(() {
        subject = ZetaProvider(
          builder: (context, light, dark, themeMode) => Container(),
          initialThemeMode: ThemeMode.light,
          themeService: mockThemeService,
        );
      });

      testWidgets('updateThemeMode updates the state correctly', (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateThemeMode(ThemeMode.dark);
        await tester.pump();

        final zeta = tester.widget<Zeta>(find.byType(Zeta));

        // Verifying through the public interface of Zeta widget
        expect(zeta.themeMode, ThemeMode.dark);
      });

      testWidgets('updateContrast updates the state correctly', (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateContrast(ZetaContrast.aaa);
        await tester.pump();

        // Verifying through the public interface of Zeta widget
        final zeta = tester.widget<Zeta>(find.byType(Zeta));

        expect(zeta.contrast, ZetaContrast.aaa);
      });

      testWidgets('updateRounded updates the state correctly', (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateRounded(false);
        await tester.pump();

        // Verifying through the public interface of Zeta widget
        final zeta = tester.widget<Zeta>(find.byType(Zeta));

        expect(zeta.rounded, false);
      });
    });

    group('didUpdateWidget', () {
      late ZetaProvider subject;

      setUp(() {
        subject = ZetaProvider(
          builder: (context, light, dark, themeMode) => Container(),
          initialThemeMode: ThemeMode.light,
          themeService: mockThemeService,
        );
      });

      testWidgets('didUpdateWidget in ZetaProviderState works correctly with change in ThemeMode',
          (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        await tester.pump();
        // Verifying through the public interface of Zeta widget
        expect(tester.widget<Zeta>(find.byType(Zeta)).themeMode, ThemeMode.light);

        await tester.pumpWidget(
          ZetaProvider(
            initialThemeMode: ThemeMode.dark,
            customLoadingWidget: const SizedBox(),
            builder: (context, light, dark, themeMode) => Builder(
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
        await tester.pumpWidget(subject);

        await tester.pumpAndSettle();

        // Verifying through the public interface of Zeta widget
        expect(tester.widget<Zeta>(find.byType(Zeta)).contrast, ZetaContrast.aa);

        await tester.pumpWidget(
          ZetaProvider(
            initialContrast: ZetaContrast.aaa,
            builder: (context, light, dark, themeMode) => Builder(
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

      testWidgets('didUpdateWidget in ZetaProviderState works correctly with change rounded',
          (WidgetTester tester) async {
        await tester.pumpWidget(subject);

        await tester.pumpAndSettle();

        // Verifying through the public interface of Zeta widget
        expect(tester.widget<Zeta>(find.byType(Zeta)).rounded, true);

        await tester.pumpWidget(
          ZetaProvider(
            initialRounded: false,
            themeService: mockThemeService,
            customLoadingWidget: const SizedBox(),
            builder: (context, light, dark, themeMode) => Builder(
              builder: (context) {
                return Container();
              },
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verifying through the public interface of Zeta widget
        expect(tester.widget<Zeta>(find.byType(Zeta)).rounded, false);
      });
    });

    testWidgets('retrieves ZetaProviderState from context', (WidgetTester tester) async {
      await tester.pumpWidget(
        ZetaProvider(
          themeService: mockThemeService,
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
      const Key k = Key('1');
      await tester.pumpWidget(
        ZetaProvider(
          initialThemeMode: ThemeMode.system,
          themeService: mockThemeService,
          builder: (context, light, dark, themeMode) => Container(key: k),
        ),
      );

      // Rebuild the widget tree
      await tester.pump(Durations.extralong4);

      // Get test binding
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

      // Simulate platform brightness change to dark
      binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;

      await tester.pump(Durations.extralong4);
      final zeta = Zeta.of(tester.element(find.byKey(k)));

      // Verifying through the public interface of Zeta widget
      // It is important to check here that zeta.brightness is changed to dark,
      // as this shows if themeMode.system actually works.
      expect(zeta.brightness, Brightness.dark);
    });

    testWidgets('generateZetaTheme applies zeta values to existing theme', (WidgetTester tester) async {
      final ColorScheme colors = ColorScheme.fromSeed(seedColor: Colors.red);
      final theme = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: const ZetaColorsAA(primitives: ZetaPrimitivesLight()).toColorScheme,
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
      final colorScheme = const ZetaColorsAA(primitives: ZetaPrimitivesLight()).toColorScheme;

      final theme = generateZetaTheme(
        brightness: Brightness.light,
        colorScheme: colorScheme,
      );

      expect(theme.useMaterial3, true);
      expect(theme.brightness, Brightness.light);
      expect(colorScheme, theme.colorScheme);
    });

    group('custom theme', () {
      late ZetaProvider subject;

      final customPrimary = ZetaColorSwatch.fromColor(Colors.red);

      final customThemes = [
        ZetaCustomTheme(id: '1', primary: customPrimary),
        ZetaCustomTheme(id: '2', primary: Colors.orange),
      ];

      setUp(() {
        subject = ZetaProvider(
          themeService: mockThemeService,
          customThemes: customThemes,
          initialThemeMode: ThemeMode.light,
          initialTheme: '1',
          builder: (_, __, ___, ____) => const SizedBox(),
        );
      });

      testWidgets('initial theme gets set correctly', (tester) async {
        await tester.pumpWidget(subject);

        await tester.pump();

        final zeta = tester.widget<Zeta>(find.byType(Zeta));

        expect(zeta.primitives.primary, customPrimary);
      });

      testWidgets('customThemeId getter works as expected', (tester) async {
        await tester.pumpWidget(subject);

        await tester.pump();

        final providerState = tester.widget<Zeta>(find.byType(Zeta));

        expect(providerState.customThemeId, '1');
      });

      testWidgets('custom themes can be changed', (tester) async {
        await tester.pumpWidget(subject);
        await tester.pump();

        final newThemes = [
          ZetaCustomTheme(id: '3', primary: Colors.blue),
          ZetaCustomTheme(id: '4', primary: Colors.green),
        ];
        ZetaProviderState providerState = tester.state<ZetaProviderState>(find.byType(ZetaProvider))
          ..setCustomThemes(newThemes);

        await tester.pump();

        providerState = tester.state<ZetaProviderState>(find.byType(ZetaProvider));

        expect(providerState.customThemes, newThemes);
      });

      testWidgets('updateCustomTheme works as expected', (tester) async {
        await tester.pumpWidget(subject);
        await tester.pump();

        tester
            .state<ZetaProviderState>(
              find.byType(ZetaProvider),
            )
            .updateCustomTheme(themeId: '2');
        await tester.pump();

        final zeta = tester.widget<Zeta>(find.byType(Zeta));

        expect(zeta.customThemeId, '2');
      });
    });

    group('theme service', () {
      group('load theme', () {
        setUp(() async {
          when(mockThemeService.loadTheme()).thenAnswer(
            (_) async => const ZetaThemeServiceData(
              contrast: ZetaContrast.aaa,
              themeMode: ThemeMode.dark,
              themeId: '1',
            ),
          );
        });

        testWidgets('loads a custom theme correctly', (tester) async {
          final customThemes = [
            ZetaCustomTheme(id: '1', primary: Colors.red),
          ];

          await tester.pumpWidget(
            ZetaProvider(
              themeService: mockThemeService,
              customThemes: customThemes,
              builder: (_, __, ___, ____) {
                return const SizedBox();
              },
            ),
          );
          await tester.pump();

          final zeta = tester.widget<Zeta>(find.byType(Zeta));

          verify(mockThemeService.loadTheme()).called(1);
          expect(zeta.customThemeId, '1');
          expect(zeta.themeMode, ThemeMode.dark);
          expect(zeta.contrast, ZetaContrast.aaa);
        });

        testWidgets('theme is not loaded if all defaults are given to provider and no custom themes are provided',
            (tester) async {
          await tester.pumpWidget(
            ZetaProvider(
              themeService: mockThemeService,
              initialThemeMode: ThemeMode.light,
              initialContrast: ZetaContrast.aa,
              builder: (_, __, ___, ____) {
                return const SizedBox();
              },
            ),
          );
          await tester.pump();

          verifyNever(mockThemeService.loadTheme());
        });

        testWidgets('theme is not loaded if all defaults are given to provider and custom themes contains initialTheme',
            (tester) async {
          final customThemes = [
            ZetaCustomTheme(id: '1', primary: Colors.red),
          ];

          await tester.pumpWidget(
            ZetaProvider(
              themeService: mockThemeService,
              customThemes: customThemes,
              initialThemeMode: ThemeMode.light,
              initialContrast: ZetaContrast.aa,
              initialTheme: '1',
              builder: (_, __, ___, ____) {
                return const SizedBox();
              },
            ),
          );
          await tester.pump();

          verifyNever(mockThemeService.loadTheme());
        });

        testWidgets('theme is loaded if some defaults are given to provider', (tester) async {
          final customThemes = [
            ZetaCustomTheme(id: '1', primary: Colors.red),
          ];

          await tester.pumpWidget(
            ZetaProvider(
              themeService: mockThemeService,
              customThemes: customThemes,
              initialThemeMode: ThemeMode.light,
              builder: (_, __, ___, ____) {
                return const SizedBox();
              },
            ),
          );
          await tester.pump();

          verify(mockThemeService.loadTheme()).called(1);
        });

        testWidgets(
            'theme is loaded if all other defaults are specified but custom themes does not contain initialTheme',
            (tester) async {
          await tester.pumpWidget(
            ZetaProvider(
              themeService: mockThemeService,
              initialContrast: ZetaContrast.aa,
              customThemes: [
                ZetaCustomTheme(id: '1', primary: Colors.red),
              ],
              initialTheme: 'not found',
              initialThemeMode: ThemeMode.light,
              builder: (_, __, ___, ____) {
                return const SizedBox();
              },
            ),
          );
          await tester.pump();

          verify(mockThemeService.loadTheme()).called(1);
        });

        testWidgets('use default theme if saved custom theme is not found by theme service', (tester) async {
          when(mockThemeService.loadTheme()).thenAnswer(
            (_) async => const ZetaThemeServiceData(themeId: 'this theme does not exist'),
          );

          await tester.pumpWidget(
            ZetaProvider(
              themeService: mockThemeService,
              initialThemeMode: ThemeMode.light,
              initialContrast: ZetaContrast.aa,
              builder: (_, __, ___, ____) {
                return const SizedBox();
              },
            ),
          );
          await tester.pump();

          final zeta = tester.widget<Zeta>(find.byType(Zeta));

          expect(zeta.customThemeId, null);
          expect(
            zeta.colors.primitives.primary,
            const ZetaPrimitivesLight().primary,
          );
        });
      });

      group('save theme', () {
        late ZetaProvider subject;

        setUp(() {
          subject = ZetaProvider(
            themeService: mockThemeService,
            builder: (context, light, dark, themeMode) => Container(),
          );
        });

        testWidgets('saveTheme is called when theme mode is updated', (tester) async {
          await tester.pumpWidget(subject);
          await tester.pumpAndSettle();

          tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateThemeMode(ThemeMode.dark);

          await tester.pumpAndSettle();

          verify(mockThemeService.saveTheme(themeData: anyNamed('themeData'))).called(1);
        });

        testWidgets('saveTheme is called when contrast is updated', (tester) async {
          await tester.pumpWidget(subject);
          await tester.pumpAndSettle();

          tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateContrast(ZetaContrast.aaa);

          await tester.pumpAndSettle();

          verify(mockThemeService.saveTheme(themeData: anyNamed('themeData'))).called(1);
        });

        testWidgets('saveTheme is called when theme id is updated', (tester) async {
          await tester.pumpWidget(subject);
          await tester.pumpAndSettle();

          tester.state<ZetaProviderState>(find.byType(ZetaProvider)).updateCustomTheme(themeId: '2');

          await tester.pumpAndSettle();

          verify(mockThemeService.saveTheme(themeData: anyNamed('themeData'))).called(1);
        });
      });
    });

    group('debugFillProperties', () {
      testWidgets('ZetaProvider debugFillProperties works correctly', (WidgetTester tester) async {
        final Map<String, dynamic> debugFillProperties = {
          'properties': '{}',
          'contrast': 'ZetaContrast.aaa',
          'themeMode': 'ThemeMode.light',
          'customThemes': '[]',
          'customTheme': 'ZetaThemeServiceData()',
        };
        final themes = [ZetaCustomTheme(id: '1')];

        debugFillPropertiesTest(
          ZetaProvider(
            builder: (context, light, dark, themeMode) => Container(),
            initialThemeMode: ThemeMode.light,
            initialContrast: ZetaContrast.aaa,
            themeService: mockThemeService,
            initialRounded: false,
            initialTheme: '1',
            customThemes: themes,
          ),
          debugFillProperties,
        );
      });

      testWidgets('ZetaProviderState debugFillProperties works correctly', (WidgetTester tester) async {});

      testWidgets('InternalProvider debugFillProperties works correctly', (WidgetTester tester) async {});
    });
  });
}
