import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'package:zeta_flutter_theme/zeta_flutter_theme.dart';

void main() {
  testWidgets('ZetaThemeOverride overrides themeMode and contrast only', (WidgetTester tester) async {
    await tester.pumpWidget(
      ZetaProvider(
        initialThemeMode: ThemeMode.light,
        initialContrast: ZetaContrast.aa,
        builder: (context, lightTheme, darkTheme, themeMode) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeMode,
            home: Scaffold(
              backgroundColor: Zeta.of(context).colors.surfaceWarm,
              body: Row(
                children: [
                  Expanded(
                    child: Column(
                      key: const Key('outside-override'),
                      children: [
                        Text('ThemeMode: ${Zeta.of(context).themeMode}'),
                        Text('Contrast: ${Zeta.of(context).contrast}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ZetaThemeOverride(
                      themeMode: ThemeMode.dark,
                      contrast: ZetaContrast.aaa,
                      child: Builder(
                        builder: (context) {
                          return Column(
                            key: const Key('inside-override'),
                            children: [
                              Text('ThemeMode: ${Zeta.of(context).themeMode}'),
                              Text('Contrast: ${Zeta.of(context).contrast}'),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    // Find the Text widgets and verify their values
    final outsideFinder = find.byKey(const Key('outside-override'));
    final insideFinder = find.byKey(const Key('inside-override'));

    expect(outsideFinder, findsOneWidget);
    expect(insideFinder, findsOneWidget);

    final outsideTextWidgets =
        tester.widgetList<Text>(find.descendant(of: outsideFinder, matching: find.byType(Text))).toList();
    final insideTextWidgets =
        tester.widgetList<Text>(find.descendant(of: insideFinder, matching: find.byType(Text))).toList();

    expect(outsideTextWidgets[0].data, 'ThemeMode: ThemeMode.light');
    expect(outsideTextWidgets[1].data, 'Contrast: ZetaContrast.aa');
    expect(insideTextWidgets[0].data, 'ThemeMode: ThemeMode.dark');
    expect(insideTextWidgets[1].data, 'Contrast: ZetaContrast.aaa');
  });
}
