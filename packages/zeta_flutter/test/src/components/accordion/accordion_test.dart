// Ignored as we want to ensure values are passed.
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

Widget accordionContentExample = Builder(
  builder: (context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Scan Mode'),
        ZetaDropdown(
          items: [
            ZetaDropdownItem(label: 'Continuous', value: 'Continuous'),
            ZetaDropdownItem(label: 'Continuous1', value: 'Continuous1'),
            ZetaDropdownItem(label: 'Continuous2', value: 'Continuous2'),
          ],
          onChange: (_) {},
        ),
      ],
    );
  },
);

List<ZetaAccordionItem> otherItems = [
  const ZetaAccordionItem(title: 'Connectivity & Network'),
  const ZetaAccordionItem(title: 'Light & Sensor Calibration'),
  const ZetaAccordionItem(title: 'Firmware & Updates'),
];
void main() {
  const String parentFolder = 'accordion';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri, tolerance: 0.01);
  });

  group('Accessibility Tests', () {
    meetsAccessibilityGuidelinesTest(
      const ZetaAccordion(
        openMultiple: true,
        children: [
          ZetaAccordionItem(
            title: 'Item 1',
            isOpen: true,
            child: Text('Content 1'),
          ),
          ZetaAccordionItem(
            title: 'Item 2',
            isOpen: true,
            isSelectable: true,
            isSelected: true,
            child: Text('Content 2'),
          ),
          ZetaAccordionItem(
            isNavigation: true,
            title: 'Item 3',
          ),
        ],
      ),
    );
    testWidgets('Expand / collapse semantic is correct', (tester) async {
      const Key firstItemKey = Key('item1');
      const Key secondItemKey = Key('item2');

      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            children: [
              ZetaAccordionItem(
                title: 'Item 1',
                isOpen: true,
                isSelectable: true,
                key: firstItemKey,
                child: Text('Content 1'),
              ),
              ZetaAccordionItem(
                title: 'Item 2',
                isOpen: false,
                isSelectable: true,
                key: secondItemKey,
                child: Text('Content 2'),
              ),
            ],
          ),
        ),
      );

      final firstAccordionItem = find.byKey(firstItemKey);
      final secondAccordionItem = find.byKey(secondItemKey);

      expect(firstAccordionItem, findsOneWidget);
      expect(secondAccordionItem, findsOneWidget);

      final semanticCollapseFinder = find.descendant(
        of: firstAccordionItem,
        matching: find.bySemanticsLabel('Collapse accordion'),
      );

      final semanticExpandFinder = find.descendant(
        of: secondAccordionItem,
        matching: find.bySemanticsLabel('Expand accordion'),
      );

      expect(semanticCollapseFinder, findsOneWidget);

      expect(semanticExpandFinder, findsOneWidget);

      // Tap the first item to collapse it
      await tester.tap(semanticCollapseFinder);
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: firstAccordionItem,
          matching: find.bySemanticsLabel('Expand accordion'),
        ),
        findsOneWidget,
      );

      // Tap the second item to expand it
      await tester.tap(semanticExpandFinder);
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: secondAccordionItem,
          matching: find.bySemanticsLabel('Collapse accordion'),
        ),
        findsOneWidget,
      );
    });
  });
  group('Content Tests', () {
    testWidgets('Accordion with multiple items', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            openMultiple: true,
            children: [
              ZetaAccordionItem(title: 'Item 1', isOpen: true, child: Text('Content 1')),
              ZetaAccordionItem(title: 'Item 2', isOpen: true, child: Text('Content 2')),
              ZetaAccordionItem(title: 'Item 3', isOpen: false, child: Text('Content 3')),
            ],
          ),
        ),
      );

      final content1Finder = find.text('Content 1');
      final content2Finder = find.text('Content 2');
      final content3Finder = find.text('Content 3');

      expect(content1Finder, findsOneWidget);
      expect(content2Finder, findsOneWidget);
      expect(content3Finder, findsOneWidget);

      // Ensure Content 1 is visible (AnimatedSize height > 1)
      final animatedSize1Finder = find.ancestor(
        of: content1Finder,
        matching: find.byType(AnimatedSize),
      );
      expect(animatedSize1Finder, findsOneWidget);
      final animatedSize1Rect = tester.getRect(animatedSize1Finder);
      expect(animatedSize1Rect.height, greaterThan(1.0));

      // Ensure Content 2 is visible (AnimatedSize height > 1)
      final animatedSize2Finder = find.ancestor(
        of: content2Finder,
        matching: find.byType(AnimatedSize),
      );
      expect(animatedSize2Finder, findsOneWidget);
      final animatedSize2Rect = tester.getRect(animatedSize2Finder);
      expect(animatedSize2Rect.height, greaterThan(1.0));

      // Ensure Content 3 is present but not visible (AnimatedSize height == 0)
      final animatedSize3Finder = find.ancestor(
        of: content3Finder,
        matching: find.byType(AnimatedSize),
      );
      expect(animatedSize3Finder, findsOneWidget);
      final animatedSize3Rect = tester.getRect(animatedSize3Finder);
      expect(animatedSize3Rect.height, 0.0);
    });

    testWidgets('Check mark behavior is correct', (WidgetTester tester) async {
      const Key selectedItemKey = Key('selectedItem');
      const Key unselectedItemKey = Key('unselectedItem');

      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            children: [
              ZetaAccordionItem(
                title: 'Item 1',
                isOpen: false,
                isSelectable: true,
                isSelected: true,
                key: selectedItemKey,
                child: Text('Content 1'),
              ),
              ZetaAccordionItem(
                title: 'Item 2',
                isOpen: false,
                isSelectable: true,
                isSelected: false,
                key: unselectedItemKey,
                child: Text('Content 2'),
              ),
            ],
          ),
        ),
      );

      final selectedItemFinder = find.byKey(selectedItemKey);
      final unselectedItemFinder = find.byKey(unselectedItemKey);

      expect(selectedItemFinder, findsOneWidget);
      expect(unselectedItemFinder, findsOneWidget);

      final selectedCheckMarkFinder = find.descendant(
        of: selectedItemFinder,
        matching: find.byIcon(ZetaIcons.check_mark),
      );

      final unselectedCheckMarkFinder = find.descendant(
        of: unselectedItemFinder,
        matching: find.byIcon(ZetaIcons.check_mark),
      );

      expect(selectedCheckMarkFinder, findsOneWidget);
      expect(unselectedCheckMarkFinder, findsNothing);
    });

    testWidgets('Navigation accordion has an icon', (WidgetTester tester) async {
      const Key navigationItemKey = Key('navigationItem');
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            children: [
              ZetaAccordionItem(
                title: 'Item 1',
                isOpen: false,
                isNavigation: true,
                key: navigationItemKey,
              ),
            ],
          ),
        ),
      );
      final navigationItemFinder = find.byKey(navigationItemKey);
      expect(navigationItemFinder, findsOneWidget);

      final iconFinder = find.descendant(
        of: navigationItemFinder,
        matching: find.byIcon(ZetaIcons.chevron_right),
      );

      expect(iconFinder, findsOneWidget);
    });
  });
  group('Dimensions Tests', () {
    testWidgets('Accordion with 8 items has expected dimensions', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 328,
                child: ZetaAccordion(
                  children: [
                    ZetaAccordionItem(title: 'Item 1', isOpen: false, child: Text('Content 1')),
                    ZetaAccordionItem(title: 'Item 2', isOpen: false, child: Text('Content 2')),
                    ZetaAccordionItem(title: 'Item 3', isOpen: false, child: Text('Content 3')),
                    ZetaAccordionItem(title: 'Item 4', isOpen: false, child: Text('Content 4')),
                    ZetaAccordionItem(title: 'Item 5', isOpen: false, child: Text('Content 5')),
                    ZetaAccordionItem(title: 'Item 6', isOpen: false, child: Text('Content 6')),
                    ZetaAccordionItem(title: 'Item 7', isOpen: false, child: Text('Content 7')),
                    ZetaAccordionItem(title: 'Item 8', isOpen: false, child: Text('Content 8')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final accordionRect = tester.getRect(accordionFinder);

      expect(accordionRect.width, 328);
      expect(accordionRect.height, 448);
    });
    testWidgets('Accordion with 8 items in card has expected dimensions', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 328,
                child: ZetaAccordion(
                  inCard: true,
                  children: [
                    ZetaAccordionItem(title: 'Item 1', isOpen: false, child: Text('Content 1')),
                    ZetaAccordionItem(title: 'Item 2', isOpen: false, child: Text('Content 2')),
                    ZetaAccordionItem(title: 'Item 3', isOpen: false, child: Text('Content 3')),
                    ZetaAccordionItem(title: 'Item 4', isOpen: false, child: Text('Content 4')),
                    ZetaAccordionItem(title: 'Item 5', isOpen: false, child: Text('Content 5')),
                    ZetaAccordionItem(title: 'Item 6', isOpen: false, child: Text('Content 6')),
                    ZetaAccordionItem(title: 'Item 7', isOpen: false, child: Text('Content 7')),
                    ZetaAccordionItem(title: 'Item 8', isOpen: false, child: Text('Content 8')),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final accordionRect = tester.getRect(accordionFinder);

      expect(accordionRect.width, 328);
      expect(accordionRect.height, 448);
    });
    testWidgets('Accordion item has correct height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZetaAccordion(
                children: [
                  ZetaAccordionItem(title: 'Item 1', child: Text('Content 1')),
                ],
              ),
            ],
          ),
        ),
      );

      final itemFinder = find.byType(ZetaAccordion);
      final itemRect = tester.getRect(itemFinder);

      expect(itemRect.height, 56);
    });
    testWidgets('Open Accordion item has correct height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZetaAccordion(
                children: [
                  ZetaAccordionItem(title: 'Item 1', isOpen: true, child: SizedBox(width: 388, height: 354)),
                ],
              ),
            ],
          ),
        ),
      );

      final itemFinder = find.byType(ZetaAccordion);
      final itemRect = tester.getRect(itemFinder);

      expect(itemRect.height, 442);
    });
  });
  group('Styling Tests', () {
    testWidgets('Accordion in card has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(title: 'Item 1', isOpen: false, child: Text('Content 1')),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final accordionWidget = tester.widget<ZetaAccordion>(accordionFinder);

      expect(accordionWidget.inCard, isTrue);

      final decoratedBoxFinder = find.descendant(
        of: accordionFinder,
        matching: find.byType(DecoratedBox),
      );

      expect(decoratedBoxFinder, findsOneWidget);
      final decoratedBox = tester.widget<DecoratedBox>(decoratedBoxFinder);
      expect(decoratedBox.decoration, isA<BoxDecoration>());
      final boxDecoration = decoratedBox.decoration as BoxDecoration;
      expect(boxDecoration.color, Zeta.of(tester.element(accordionFinder)).colors.surfaceDefault);
      expect(boxDecoration.borderRadius, BorderRadius.all(Zeta.of(tester.element(accordionFinder)).radius.rounded));
      expect(
        boxDecoration.border,
        Border.all(color: Zeta.of(tester.element(accordionFinder)).colors.borderSubtle, width: ZetaBorders.small),
      );
    });
    testWidgets('Accordion without card has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            inCard: false,
            children: [
              ZetaAccordionItem(title: 'Item 1', isOpen: false, child: Text('Content 1')),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final accordionWidget = tester.widget<ZetaAccordion>(accordionFinder);

      expect(accordionWidget.inCard, isFalse);

      final decoratedBoxFinder = find.descendant(
        of: accordionFinder,
        matching: find.byType(DecoratedBox),
      );

      expect(decoratedBoxFinder, findsNothing);
    });
    testWidgets('Accordion displays custom header', (WidgetTester tester) async {
      const Key headerKey = Key('header');
      await tester.pumpWidget(
        TestApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Builder(
                builder: (context) {
                  return SizedBox(
                    // width: 328,
                    child: ZetaAccordion(
                      inCard: true,
                      children: [
                        ZetaAccordionItem(
                          onTap: () {},
                          title: 'Scanner Configuration',
                          header: SizedBox(
                            height: 40,
                            child: Row(
                              key: headerKey,
                              spacing: Zeta.of(context).spacing.small,
                              children: [
                                ZetaButton.outlineSubtle(label: 'Action 1', onPressed: () {}),
                                ZetaButton.outlineSubtle(label: 'Action 2', onPressed: () {}),
                                ZetaButton.outlineSubtle(label: 'Action 3', onPressed: () {}),
                              ],
                            ),
                          ),
                          child: const Placeholder(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      expect(accordionFinder, findsOneWidget);

      final buttonFinder = find.byType(ZetaButton);
      expect(buttonFinder, findsNWidgets(3));

      final accordionRect = tester.getRect(accordionFinder);
      expect(accordionRect.height, 112);
    });
  });
  group('Interaction Tests', () {
    testWidgets('Accordion item expands and collapses on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            children: [
              ZetaAccordionItem(title: 'Item 1', isOpen: false, child: Text('Content 1')),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final materialFinder = find.descendant(
        of: accordionFinder,
        matching: find.byType(Material),
      );

      // Find the AnimatedSize widget for the content and check its height is 0
      final animatedSizeFinder = find.descendant(
        of: accordionFinder,
        matching: find.byType(AnimatedSize),
      );
      expect(animatedSizeFinder, findsOneWidget);
      final animatedSizeRect = tester.getRect(animatedSizeFinder);
      expect(animatedSizeRect.height, 0.0);

      // Tap the item to expand it
      await tester.tap(materialFinder);
      await tester.pumpAndSettle();

      // The AnimatedSize height should be greater than 0
      final animatedSizeRectAfterExpand = tester.getRect(animatedSizeFinder);
      expect(animatedSizeRectAfterExpand.height, greaterThan(0.0));

      // Tap again near the top to collapse it
      final materialRect = tester.getRect(materialFinder);
      final Offset topCenter = materialRect.topCenter;
      await tester.tapAt(topCenter);
      await tester.pumpAndSettle();

      final animatedSizeRectAfter = tester.getRect(animatedSizeFinder);
      expect(animatedSizeRectAfter.height, 0.0);
    });
    testWidgets('Selectable accordion item can be selected and unselected', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            children: [
              ZetaAccordionItem(
                title: 'Item 1',
                isOpen: false,
                isSelectable: true,
                isSelected: false,
                child: Text('Content 1'),
              ),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final itemFinder = find.descendant(of: accordionFinder, matching: find.byType(Material));
      expect(itemFinder, findsOneWidget);

      final checkMarkFinder = find.descendant(of: itemFinder, matching: find.byIcon(ZetaIcons.check_mark));
      expect(checkMarkFinder, findsNothing);

      // Tap to select the item
      await tester.tap(itemFinder);
      await tester.pumpAndSettle();

      // Check mark should now be visible
      expect(checkMarkFinder, findsOneWidget);

      // Tap again to unselect the item
      await tester.tap(itemFinder);
      await tester.pumpAndSettle();

      // Check mark should be gone
      expect(checkMarkFinder, findsNothing);
    });
    testWidgets('Selectable accordion item can be expanded and collapsed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaAccordion(
            children: [
              ZetaAccordionItem(
                title: 'Item 1',
                isOpen: false,
                isSelectable: true,
                isSelected: false,
                child: Text('Content 1'),
              ),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final chevronFinder = find.descendant(
        of: accordionFinder,
        matching: find.byIcon(ZetaIcons.chevron_right),
      );
      expect(chevronFinder, findsOneWidget);

      // Tap the chevron to expand
      await tester.tap(chevronFinder);
      await tester.pumpAndSettle();

      // The AnimatedSize height should be greater than 0 (expanded)
      final animatedSizeFinder = find.descendant(
        of: accordionFinder,
        matching: find.byType(AnimatedSize),
      );
      expect(animatedSizeFinder, findsOneWidget);
      final animatedSizeRect = tester.getRect(animatedSizeFinder);
      expect(animatedSizeRect.height, greaterThan(0.0));

      // Tap the chevron again to collapse
      await tester.tap(chevronFinder);
      await tester.pumpAndSettle();
      final animatedSizeRectAfter = tester.getRect(animatedSizeFinder);
      expect(animatedSizeRectAfter.height, 0.0);
    });
    testWidgets('Navigation accordion size does not change on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZetaAccordion(
                children: [
                  ZetaAccordionItem(
                    title: 'Item 1',
                    isOpen: false,
                    isNavigation: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      final accordionFinder = find.byType(ZetaAccordion);
      final itemFinder = find.descendant(of: accordionFinder, matching: find.byType(Material));
      expect(itemFinder, findsOneWidget);

      // Get the initial size
      final initialSize = tester.getSize(itemFinder);

      // Tap the item
      await tester.tap(itemFinder);
      await tester.pumpAndSettle();

      // Size should remain the same
      final newSize = tester.getSize(itemFinder);
      expect(newSize, initialSize);
    });
  });
  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaAccordion(
        inCard: true,
        children: [
          ZetaAccordionItem(title: 'Scanner Configuration', isNavigation: true),
          ZetaAccordionItem(title: 'Connectivity & Network', isNavigation: true),
          ZetaAccordionItem(title: 'Light & Sensor Calibration', isNavigation: true),
          ZetaAccordionItem(title: 'Firmware & Updates', isNavigation: true),
        ],
      ),
      'navigation',
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: true,
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'collapsible',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: true,
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'collapsible_card',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: false,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    ZetaButton.outline(label: 'Clear', onPressed: () {}),
                    ZetaButton(label: 'Apply', onPressed: () {}),
                  ],
                ),
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'footer_closed',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: true,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  spacing: 8,
                  children: [
                    ZetaButton.outline(label: 'Clear', onPressed: () {}),
                    ZetaButton(label: 'Apply', onPressed: () {}),
                  ],
                ),
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'footer_open',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: false,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    ZetaButton.outlineSubtle(label: 'Action 1', onPressed: () {}),
                    ZetaButton.outlineSubtle(label: 'Action 2', onPressed: () {}),
                    ZetaButton.outlineSubtle(label: 'Action 3', onPressed: () {}),
                  ],
                ),
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'header_closed',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: true,
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    ZetaButton.outlineSubtle(label: 'Action 1', onPressed: () {}),
                    ZetaButton.outlineSubtle(label: 'Action 2', onPressed: () {}),
                    ZetaButton.outlineSubtle(label: 'Action 3', onPressed: () {}),
                  ],
                ),
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'header_open',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: false,
                isSelectable: true,
                isSelected: true,
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'selectable_closed',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
    goldenTest(
      goldenFile,
      Builder(
        builder: (context) {
          return ZetaAccordion(
            inCard: true,
            children: [
              ZetaAccordionItem(
                title: 'Scanner Configuration',
                isOpen: true,
                isSelectable: true,
                isSelected: true,
                child: accordionContentExample,
              ),
              ...otherItems,
            ],
          );
        },
      ),
      'selectable_open',
      widgetType: ZetaAccordion,
      loadFont: false,
    );
  });
  group('Performance Tests', () {});
}
