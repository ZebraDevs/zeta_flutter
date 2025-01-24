import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/navigation%20bar/navigation_bar.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'navigation_bar';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  const items = [
    ZetaNavigationBarItem(
      icon: ZetaIcons.star,
      label: 'Label0',
      badge: ZetaIndicator(
        value: 2,
      ),
    ),
    ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label1', badge: ZetaIndicator(value: 2)),
    ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label2'),
    ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label3'),
  ];
  final action = ZetaButton.primary(
    label: 'Button',
    onPressed: () {},
  );

  group('Accessibility Tests', () {
    testWidgets('meets accessibility requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
            currentIndex: 0,
          ),
        ),
      );

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    // TODO(UX-1361): Button is not accessible.
    // testWidgets('meets accessibility requirements with action', (WidgetTester tester) async {
    //   final SemanticsHandle handle = tester.ensureSemantics();
    //   await tester.pumpWidget(
    //     TestApp(
    //       home: ZetaNavigationBar.action(
    //         items: items,
    //         action: action,
    //       ),
    //     ),
    //   );

    //   await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
    //   await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
    //   await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
    //   await expectLater(tester, meetsGuideline(textContrastGuideline));
    //   handle.dispose();
    // });

    testWidgets('meets accessibility requirements with divider', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaNavigationBar.divided(
            items: items,
            dividerIndex: 2,
          ),
        ),
      );

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('meets accessibility requirements with split', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaNavigationBar.split(
            items: items,
          ),
        ),
      );

      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });

    testWidgets('meets accessibility requirements with shrink items', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
            shrinkItems: true,
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

  group('Content Tests', () {
    debugFillPropertiesTest(
      ZetaNavigationBar(
        items: items,
      ),
      {
        'items':
            "Instance of 'ZetaNavigationBarItem', Instance of 'ZetaNavigationBarItem', Instance of 'ZetaNavigationBarItem', Instance of 'ZetaNavigationBarItem'",
        'currentIndex': 'null',
        'onTap': 'null',
        'splitItems': 'false',
        'dividerIndex': 'null',
        'semanticLabel': 'null',
      },
    );

    testWidgets('renders the correct number of items', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );

      final itemsFinder = find.byType(NavigationItem);
      expect(itemsFinder, findsNWidgets(items.length));
    });

    testWidgets('renders the correct label for each item', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );

      for (int i = 0; i < items.length; i++) {
        final labelFinder = find.text('Label$i');
        expect(labelFinder, findsOneWidget);
      }
    });

    testWidgets('renders the correct icon for each item', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );

      final iconFinder = find.byElementType(ZetaIcon);
      final icons = tester.widgetList(iconFinder).map((e) => e as ZetaIcon).toList();
      for (final icon in icons) {
        expect(icon.icon, ZetaIcons.star);
      }
    });
    testWidgets('passes the correct badge content for each item', (WidgetTester tester) async {
      const items1 = [
        ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label0', badge: ZetaIndicator(value: 0)),
        ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label1', badge: ZetaIndicator(value: 1)),
        ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label2', badge: ZetaIndicator(value: 2)),
        ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label3', badge: ZetaIndicator(value: 3)),
      ];
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items1,
          ),
        ),
      );

      final badgeFinder = find.byType(ZetaIndicator);
      final badges = tester.widgetList(badgeFinder).map((e) => e as ZetaIndicator).toList();
      for (int i = 0; i < badges.length; i++) {
        expect(badges[i].value, i);
      }
    });

    testWidgets('renders the action', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar.action(
            items: items,
            action: action,
          ),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('renders the divider', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaNavigationBar.divided(
            items: items,
            dividerIndex: 2,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final dividerFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.color == Zeta.of(context).colors.borderSubtle,
      );

      expect(dividerFinder, findsOneWidget);
    });
  });

  group('Dimensions Tests', () {
    testWidgets('renders the correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final containerFinder = find.byType(Container).first;

      expect(
        tester.widget<Container>(containerFinder).padding,
        EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.large),
      );
    });

    testWidgets('items render the correct padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final itemFinder = find.byType(NavigationItem);
      if (itemFinder.evaluate().isEmpty) {
        fail('No items found');
      } else if (itemFinder.evaluate().length != items.length) {
        fail('Incorrect number of items found');
      } else {
        for (int i = 0; i < items.length; i++) {
          expect(
            tester
                .widget<Container>(find.descendant(of: itemFinder.at(i), matching: find.byType(Container)).first)
                .padding,
            EdgeInsets.only(
              left: Zeta.of(context).spacing.small,
              right: Zeta.of(context).spacing.small,
              bottom: Zeta.of(context).spacing.small,
            ),
          );
        }
      }
    });

    testWidgets('the divider is the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaNavigationBar.divided(
            items: items,
            dividerIndex: 2,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final dividerFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.color == Zeta.of(context).colors.borderSubtle,
      );

      expect(dividerFinder, findsOneWidget);

      expect(dividerFinder.evaluate().first.size?.height, Zeta.of(context).spacing.xl_7);
      expect(dividerFinder.evaluate().first.size?.width, 1);
    });
  });

  group('Styling Tests', () {
    testWidgets('renders the correct background color', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final containerFinder = find.byType(Container).first;

      final containerWidget = tester.widget<Container>(containerFinder);
      final boxDecoration = containerWidget.decoration! as BoxDecoration;

      expect(boxDecoration.color, Zeta.of(context).colors.surfaceDefault);
    });

    testWidgets('items are the correct color', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final itemFinder = find.byType(NavigationItem);
      final icon =
          tester.widget<ZetaIcon>(find.descendant(of: itemFinder.first, matching: find.byType(ZetaIcon)).first);
      final label = tester.widget<Text>(find.descendant(of: itemFinder.first, matching: find.text('Label0')));

      expect(icon.color, Zeta.of(context).colors.mainSubtle);
      expect(label.style, Theme.of(context).textTheme.labelSmall?.copyWith(color: Zeta.of(context).colors.mainSubtle));
    });

    testWidgets('selected item is the correct color', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
            currentIndex: 0,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final itemFinder = find.byType(NavigationItem);
      final icon =
          tester.widget<ZetaIcon>(find.descendant(of: itemFinder.first, matching: find.byType(ZetaIcon)).first);
      final label = tester.widget<Text>(find.descendant(of: itemFinder.first, matching: find.text('Label0')));

      expect(icon.color, Zeta.of(context).colors.mainPrimary);
      expect(label.style, Theme.of(context).textTheme.labelSmall?.copyWith(color: Zeta.of(context).colors.mainPrimary));
    });

    testWidgets('hover background color is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
            currentIndex: 0,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaNavigationBar);

      final itemFinder = find.byType(NavigationItem).first;

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: tester.getCenter(itemFinder));
      addTearDown(gesture.removePointer);

      await tester.pumpAndSettle();

      final inkResponse =
          tester.widget<InkResponse>(find.descendant(of: itemFinder, matching: find.byType(InkResponse)).first);

      expect(inkResponse.hoverColor, Zeta.of(context).colors.surfaceHover);
    });
  });

  group('Interaction Tests', () {
    testWidgets('calls onTap when an item is tapped', (WidgetTester tester) async {
      var tappedIndex = -1;
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
            onTap: (index) => tappedIndex = index,
          ),
        ),
      );

      final itemFinder = find.byType(NavigationItem).first;
      await tester.tap(itemFinder);

      expect(tappedIndex, 0);

      final lastItemFinder = find.byType(NavigationItem).last;
      await tester.tap(lastItemFinder);

      expect(tappedIndex, 3);
    });

    testWidgets('calls onTap when an item is tapped off center', (WidgetTester tester) async {
      var tappedIndex = -1;
      await tester.pumpWidget(
        TestApp(
          home: ZetaNavigationBar(
            items: items,
            onTap: (index) => tappedIndex = index,
          ),
        ),
      );

      final itemFinder = find.byType(NavigationItem).first;

      await tester.tapAt(tester.getCenter(itemFinder) + const Offset(80, 0));
      expect(tappedIndex, 0);

      final lastItemFinder = find.byType(NavigationItem).last;

      await tester.tapAt(tester.getCenter(lastItemFinder) + const Offset(-80, 0));
      expect(tappedIndex, 3);
    });

    testWidgets('updates the selected item when an item is tapped', (WidgetTester tester) async {
      var selectedIndex = -1;
      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return TestApp(
              home: ZetaNavigationBar(
                items: items,
                currentIndex: selectedIndex,
                onTap: (val) => setState(() {
                  selectedIndex = val;
                }),
              ),
            );
          },
        ),
      );

      final itemFinder = find.byType(NavigationItem).first;
      await tester.tap(itemFinder);
      expect(selectedIndex, 0);

      final lastItemFinder = find.byType(NavigationItem).last;
      await tester.tap(lastItemFinder);
      expect(selectedIndex, 3);
    });
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      ZetaNavigationBar(items: items),
      'navigation_bar_default',
    );
    goldenTest(
      goldenFile,
      ZetaNavigationBar(
        items: items,
        shrinkItems: true,
      ),
      'navigation_bar_shrink_items',
    );
    for (int i = 0; i < items.length; i++) {
      goldenTest(
        goldenFile,
        ZetaNavigationBar(
          items: items,
          currentIndex: i,
        ),
        'navigation_bar_current_index_$i',
      );

      goldenTest(
        goldenFile,
        ZetaNavigationBar.divided(
          items: items,
          dividerIndex: i,
        ),
        'navigation_bar_divider_at_$i',
      );
    }
    goldenTest(
      goldenFile,
      const ZetaNavigationBar.action(
        items: items,
        action: ZetaButton(label: 'Button'),
      ),
      'navigation_bar_action',
    );
    goldenTest(
      goldenFile,
      const ZetaNavigationBar.split(
        items: items,
      ),
      'navigation_bar_split',
    );
  });

  group('Performance Tests', () {});
}
