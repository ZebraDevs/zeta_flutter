import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'bottom_sheet');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });
  group('BottomSheet Colors Tests', () {
    testWidgets('displays the correct background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
          ),
        ),
      );

      final containerBackgroudColor =
          ((tester.firstWidget(find.byType(Container)) as Container).decoration! as BoxDecoration).color;

      expect(
        containerBackgroudColor,
        equals(Zeta.of(tester.element(find.byType(ZetaBottomSheet))).colors.surfaceSecondary),
      );
    });

    testWidgets('displays the correct icon color on vertical menu items', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                6,
                (index) => ZetaMenuItem.vertical(
                  label: const Text('Menu Item'),
                  icon: const ZetaIcon(ZetaIcons.star, color: Colors.red),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final iconFinder = find.byWidgetPredicate((widget) => widget is ZetaIcon && widget.icon == ZetaIcons.star);
      final Iterable<ZetaIcon> icons = iconFinder.evaluate().map((e) => e.widget as ZetaIcon);
      for (final icon in icons) {
        expect(icon.color, equals(Colors.red));
      }
    });

    testWidgets('displays the correct icon colors on horizontal menu items', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                6,
                (index) => ZetaMenuItem.horizontal(
                  label: const Text('Menu Item'),
                  leading: const ZetaIcon(ZetaIcons.star, color: Colors.red),
                  trailing: const ZetaIcon(ZetaIcons.chevron_right, color: Colors.red),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final starIconFinder = find.byWidgetPredicate((widget) => widget is ZetaIcon && widget.icon == ZetaIcons.star);
      final Iterable<ZetaIcon> starIcons = starIconFinder.evaluate().map((e) => e.widget as ZetaIcon);
      for (final icon in starIcons) {
        expect(icon.color, equals(Colors.red));
      }

      final chevronIconFinder =
          find.byWidgetPredicate((widget) => widget is ZetaIcon && widget.icon == ZetaIcons.chevron_right);
      final Iterable<ZetaIcon> chevronIcons = chevronIconFinder.evaluate().map((e) => e.widget as ZetaIcon);
      for (final icon in chevronIcons) {
        expect(icon.color, equals(Colors.red));
      }
    });
  });

  group('BottomSheet Text Tests', () {
    testWidgets('displays the correct title with the correct styles', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
          ),
        ),
      );

      expect(find.text('Bottom Sheet'), findsOneWidget);

      final title = tester.widget<Text>(find.text('Bottom Sheet'));
      expect(title.style, equals(ZetaTextStyles.titleMedium));
    });

    testWidgets('vertical menu items labels are correct with the correct styles and colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                6,
                (index) => ZetaMenuItem.vertical(
                  label: const Text('Menu Item'),
                  icon: const ZetaIcon(ZetaIcons.star),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final textFinder = find.text('Menu Item');
      expect(textFinder, findsNWidgets(6));
      final textStyleFinder = find.byWidgetPredicate((widget) => widget is DefaultTextStyle);
      final Iterable<DefaultTextStyle> texts = textStyleFinder.evaluate().map((e) => e.widget as DefaultTextStyle);

      var i = 0;
      for (final text in texts) {
        if (i >= 3) {
          expect(
            text.style,
            equals(
              ZetaTextStyles.labelLarge
                  .apply(color: Zeta.of(tester.element(find.byType(ZetaBottomSheet))).colors.textDefault),
            ),
          );
        }
        i++;
      }
    });

    testWidgets('horizontal menu items labels are correct with the correct styles and colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                6,
                (index) => ZetaMenuItem.horizontal(
                  label: const Text('Menu Item'),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final textFinder = find.text('Menu Item');
      expect(textFinder, findsNWidgets(6));
      final textStyleFinder = find.byWidgetPredicate((widget) => widget is DefaultTextStyle);
      final Iterable<DefaultTextStyle> texts = textStyleFinder.evaluate().map((e) => e.widget as DefaultTextStyle);

      var i = 0;
      for (final text in texts) {
        if (i >= 3) {
          expect(
            text.style,
            equals(
              ZetaTextStyles.labelLarge
                  .apply(color: Zeta.of(tester.element(find.byType(ZetaBottomSheet))).colors.textDefault),
            ),
          );
        }
        i++;
      }
    });
  });

  group('BottomSheet item amount Tests', () {
    for (var i = 1; i <= 10; i++) {
      testWidgets('displays the correct number of vertical menu items $i', (WidgetTester tester) async {
        await tester.pumpWidget(
          TestApp(
            home: ZetaBottomSheet(
              title: 'Bottom Sheet',
              body: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  i,
                  (index) => ZetaMenuItem.vertical(
                    label: const Text('Menu Item'),
                    icon: const ZetaIcon(ZetaIcons.star),
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(ZetaMenuItem), findsNWidgets(i));
      });

      testWidgets(
        'displays the correct number of horizontal menu items $i',
        (WidgetTester tester) async {
          //TODO: This test is failing because the horizontal menu items are overflowing
          markTestSkipped('This test is failing because the horizontal menu items are overflowing');
          await tester.pumpWidget(
            TestApp(
              home: ZetaBottomSheet(
                title: 'Bottom Sheet',
                body: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: List.generate(
                    i,
                    (index) => ZetaMenuItem.horizontal(
                      label: const Text('Menu Item'),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ),
          );

          expect(find.byType(ZetaMenuItem), findsNWidgets(i));
        },
        skip: true,
      );
    }
  });

  group('BottomSheet icon Tests', () {
    testWidgets('vertical menu items icons are correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                6,
                (index) => ZetaMenuItem.vertical(
                  label: const Text('Menu Item'),
                  icon: const ZetaIcon(ZetaIcons.star),
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      );

      final iconFinder = find.byWidgetPredicate((widget) => widget is ZetaIcon && widget.icon == ZetaIcons.star);

      expect(iconFinder, findsNWidgets(6));
    });

    testWidgets('horizontal menu items icons are correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                6,
                (index) => ZetaMenuItem.horizontal(
                  label: const Text('Menu Item'),
                  onTap: () {},
                  leading: const ZetaIcon(ZetaIcons.star),
                  trailing: const ZetaIcon(ZetaIcons.chevron_right),
                ),
              ),
            ),
          ),
        ),
      );

      final starIconFinder = find.byWidgetPredicate((widget) => widget is ZetaIcon && widget.icon == ZetaIcons.star);
      final chevronIconFinder =
          find.byWidgetPredicate((widget) => widget is ZetaIcon && widget.icon == ZetaIcons.chevron_right);

      expect(starIconFinder, findsNWidgets(6));
      expect(chevronIconFinder, findsNWidgets(6));
    });
  });

  group('BottomSheet Accessibility Tests', () {
    testWidgets('has semantic labels for title', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
          ),
        ),
      );

      final semanticLabel = tester.getSemantics(find.text('Bottom Sheet'));
      expect(semanticLabel, matchesSemantics(label: 'Bottom Sheet'));
    });

    testWidgets(
      'has semantic labels for vertical menu items',
      (WidgetTester tester) async {
        // TODO: This test is failing because the vertical menu items have no semantic label.
        markTestSkipped('This test is failing because the vertical menu items have no semantic label');
        await tester.pumpWidget(
          TestApp(
            home: ZetaBottomSheet(
              title: 'Bottom Sheet',
              body: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  6,
                  (index) => ZetaMenuItem.vertical(
                    label: const Text(
                      'Menu Item',
                      semanticsLabel: 'Menu Item',
                    ),
                    icon: const ZetaIcon(ZetaIcons.star),
                    onTap: () {},
                  ),
                ),
              ),
            ),
          ),
        );

        final semanticLabels = tester.widgetList<Semantics>(find.byType(Semantics));
        for (final semantics in semanticLabels) {
          expect(semantics.properties.label, isNotNull);
        }
      },
      skip: true,
    );

    testWidgets(
      'has semantic labels for horizontal menu items',
      (WidgetTester tester) async {
        // TODO: This test is failing because the horizontal menu items have no semantic label.
        markTestSkipped('This test is failing because the horizontal menu items have no semantic label');
        await tester.pumpWidget(
          TestApp(
            home: ZetaBottomSheet(
              title: 'Bottom Sheet',
              body: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  6,
                  (index) => ZetaMenuItem.horizontal(
                    label: const Text('Menu Item'),
                    onTap: () {},
                    leading: const ZetaIcon(ZetaIcons.star),
                    trailing: const ZetaIcon(ZetaIcons.chevron_right),
                  ),
                ),
              ),
            ),
          ),
        );

        final semanticLabels = tester.widgetList<Semantics>(find.byType(Semantics));
        for (final semantics in semanticLabels) {
          expect(semantics.properties.label, isNotNull);
        }
      },
      skip: true,
    );

    testWidgets('meets accessiblity standards', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();

      await tester.pumpWidget(
        TestApp(
          home: ZetaBottomSheet(
            title: 'Bottom Sheet',
            body: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(
                5,
                (index) => ZetaMenuItem.horizontal(
                  label: const Text('Menu Item'),
                  onTap: () {},
                  leading: const ZetaIcon(ZetaIcons.star),
                  trailing: const ZetaIcon(ZetaIcons.star),
                ),
              ),
            ),
          ),
        ),
      );

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });
  });

  group('ZetaBottomSheet debugFillProperties Test', () {
    testWidgets('debugFillProperties Test', (WidgetTester tester) async {
      final diagnostic = DiagnosticPropertiesBuilder();
      ZetaBottomSheet(
        title: 'Bottom Sheet',
        body: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            6,
            (index) => ZetaMenuItem.horizontal(
              label: const Text('Menu Item'),
              onTap: () {},
              leading: const ZetaIcon(ZetaIcons.star),
              trailing: const ZetaIcon(ZetaIcons.chevron_right),
            ),
          ),
        ),
      ).debugFillProperties(diagnostic);

      expect(diagnostic.finder('title'), 'Bottom Sheet');
      expect(diagnostic.finder('centerTitle'), 'true');
    });
  });

  group('ZetaBottomSheet Interaction Tests', () {
    testWidgets('ZetaBottomSheet is shown when ZetaMenuItem.horizontal is tapped', (WidgetTester tester) async {
      final GlobalKey key = GlobalKey();
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return ZetaMenuItem.horizontal(
                label: const Text('Grid'),
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return ZetaBottomSheet(
                        key: key,
                        title: 'Bottom Sheet',
                        body: Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: List.generate(
                            6,
                            (index) => ZetaMenuItem.vertical(
                              label: const Text('Menu Item'),
                              icon: const ZetaIcon(ZetaIcons.star),
                              onTap: () {},
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      );

      expect(find.byKey(key), findsNothing);

      final horizontalMenuItemFinder = find.byType(ZetaMenuItem);
      await tester.tap(horizontalMenuItemFinder.first);
      await tester.pumpAndSettle();

      expect(find.byKey(key), findsOneWidget);

      await tester.tap(horizontalMenuItemFinder.first, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byKey(key), findsNothing);
    });
  });
}
