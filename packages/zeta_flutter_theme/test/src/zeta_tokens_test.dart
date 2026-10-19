import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter_theme/zeta_flutter_theme.dart';

import 'zeta_provider_test.mocks.dart';

void main() {
  group('ZetaTokens.resolve', () {
    test('aaa uses the light palette until Figma has the mode, and reports light brightness', () {
      final light = ZetaTokens.resolve();
      final aaa = ZetaTokens.resolve(colorMode: ZetaColorMode.aaa);
      expect(aaa.surface.page, light.surface.page);
      expect(aaa.interactive.primaryBackgroundDefault, light.interactive.primaryBackgroundDefault);
      expect(aaa.brightness, Brightness.light);
      expect(ZetaTokens.resolve(colorMode: ZetaColorMode.dark).brightness, Brightness.dark);
    });

    test('dark mode changes palette-backed semantics', () {
      expect(ZetaTokens.resolve(colorMode: ZetaColorMode.dark).surface.page, isNot(ZetaTokens.resolve().surface.page));
    });

    test('each layer theme is independent', () {
      final zeta = ZetaTokens.resolve();
      final companion = ZetaTokens.resolve(paletteTheme: ZetaPaletteTheme.companion);
      // companion overrides the brand palette only.
      expect(companion.interactive.primaryBackgroundDefault, isNot(zeta.interactive.primaryBackgroundDefault));
      expect(companion.surface.page, zeta.surface.page);
      expect(companion.space.md, zeta.space.md);
    });

    test('rounded follows size.shape unless overridden', () {
      // size.shape is sharp on mobile and rounded from tablet up.
      expect(ZetaTokens.resolve().rounded, isFalse);
      expect(ZetaTokens.resolve(breakpoint: ZetaBreakpoint.tablet).rounded, isTrue);
      expect(ZetaTokens.resolve(rounded: true).rounded, isTrue);
      expect(ZetaTokens.resolve(breakpoint: ZetaBreakpoint.tablet, rounded: false).rounded, isFalse);
    });

    test('builds composite values', () {
      final tokens = ZetaTokens.resolve();
      expect(tokens.radius.mdAll, BorderRadius.circular(tokens.radius.md));
      expect(tokens.text.bodyMedium.fontFamily, kZetaFontFamily);
      expect(tokens.text.bodyMedium.height! * tokens.text.bodyMedium.fontSize!, closeTo(24, 0.001));
      expect(tokens.shadow.smallSoft.single.color, tokens.shadow.soft);
    });

    test('equality is based on the resolved inputs', () {
      expect(ZetaTokens.resolve(), ZetaTokens.resolve());
      expect(ZetaTokens.resolve(), isNot(ZetaTokens.resolve(sizeTheme: ZetaSizeTheme.condensed)));
    });

    test('toColorScheme maps tokens and brightness', () {
      final tokens = ZetaTokens.resolve(colorMode: ZetaColorMode.dark);
      final scheme = tokens.toColorScheme;
      expect(scheme.brightness, Brightness.dark);
      expect(scheme.primary, tokens.interactive.primaryBackgroundDefault);
      expect(scheme.surface, tokens.surface.page);
    });
  });

  test('ZetaBreakpoint.fromWidth uses the token thresholds', () {
    expect(ZetaBreakpoint.fromWidth(0), ZetaBreakpoint.mobile);
    expect(ZetaBreakpoint.fromWidth(599), ZetaBreakpoint.mobile);
    expect(ZetaBreakpoint.fromWidth(600), ZetaBreakpoint.tablet);
    expect(ZetaBreakpoint.fromWidth(840), ZetaBreakpoint.desktopCompact);
    expect(ZetaBreakpoint.fromWidth(1200), ZetaBreakpoint.desktop);
  });

  group('Zeta.tokens', () {
    Zeta zeta(
            {ZetaContrast contrast = ZetaContrast.aa,
            ThemeMode themeMode = ThemeMode.light,
            ZetaColorMode? colorMode,}) =>
        Zeta(contrast: contrast, themeMode: themeMode, colorMode: colorMode, child: const SizedBox());

    test('follow the theme mode unless a color mode is set', () {
      expect(zeta(themeMode: ThemeMode.dark).tokens.colorMode, ZetaColorMode.dark);
      expect(zeta(themeMode: ThemeMode.dark, colorMode: ZetaColorMode.aaa).tokens.colorMode, ZetaColorMode.aaa);
    });

    test('are not affected by the legacy contrast', () {
      expect(zeta(contrast: ZetaContrast.aaa).tokens, zeta().tokens);
    });

    test('legacy rounded stays true when the tokens follow size.shape', () {
      final value = zeta();
      expect(value.rounded, isTrue);
      expect(value.roundedOverride, isNull);
    });
  });

  group('ZetaProvider', () {
    late MockZetaThemeService themeService;

    setUp(() {
      themeService = MockZetaThemeService();
      when(themeService.loadTheme()).thenAnswer(
        (_) async => const ZetaThemeServiceData(paletteTheme: ZetaPaletteTheme.target),
      );
      when(themeService.saveTheme(themeData: anyNamed('themeData'))).thenAnswer((_) async {});
    });

    Widget app({required ValueSetter<BuildContext> onBuild}) => ZetaProvider(
          themeService: themeService,
          builder: (context, light, dark, themeMode) => Builder(
            builder: (context) {
              onBuild(context);
              return const SizedBox();
            },
          ),
        );

    testWidgets('loads and saves the layer themes', (tester) async {
      late BuildContext ctx;
      await tester.pumpWidget(app(onBuild: (c) => ctx = c));
      await tester.pumpAndSettle();
      expect(ctx.zetaTokens.paletteTheme, ZetaPaletteTheme.target);

      ZetaProvider.of(ctx).updateSizeTheme(ZetaSizeTheme.condensed);
      await tester.pump();
      expect(ctx.zetaTokens.sizeTheme, ZetaSizeTheme.condensed);
      final saved =
          verify(themeService.saveTheme(themeData: captureAnyNamed('themeData'))).captured.last as ZetaThemeServiceData;
      expect(saved.sizeTheme, ZetaSizeTheme.condensed);
      expect(saved.paletteTheme, ZetaPaletteTheme.target);
    });

    testWidgets('follows the window width across breakpoints', (tester) async {
      addTearDown(tester.view.reset);
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(400, 800);
      late BuildContext ctx;
      await tester.pumpWidget(app(onBuild: (c) => ctx = c));
      await tester.pumpAndSettle();
      expect(ctx.zetaTokens.breakpoint, ZetaBreakpoint.mobile);

      tester.view.physicalSize = const Size(1300, 800);
      await tester.pumpAndSettle();
      expect(ctx.zetaTokens.breakpoint, ZetaBreakpoint.desktop);
    });

    testWidgets('ZetaThemeOverride changes a layer for its subtree only', (tester) async {
      late BuildContext outer;
      late BuildContext inner;
      await tester.pumpWidget(
        ZetaProvider(
          themeService: themeService,
          initialThemeMode: ThemeMode.light,
          initialContrast: ZetaContrast.aa,
          builder: (context, light, dark, themeMode) => Builder(
            builder: (context) {
              outer = context;
              return ZetaThemeOverride(
                paletteTheme: ZetaPaletteTheme.companion,
                breakpoint: ZetaBreakpoint.tablet,
                builder: (context) {
                  inner = context;
                  return const SizedBox();
                },
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(outer.zetaTokens.paletteTheme, ZetaPaletteTheme.zeta);
      expect(inner.zetaTokens.paletteTheme, ZetaPaletteTheme.companion);
      expect(inner.zetaTokens.breakpoint, ZetaBreakpoint.tablet);
      expect(inner.zetaTokens.colorMode, outer.zetaTokens.colorMode);
    });
  });
}
