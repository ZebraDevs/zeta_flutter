import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/breadcrumb/breadcrumb.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'breadcrumb';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  final List<ZetaBreadcrumbItem> children = [
    ZetaBreadcrumbItem(
      label: 'Breadcrumb',
      onPressed: () {},
      icon: ZetaIcons.star,
    ),
    ZetaBreadcrumbItem(label: 'Item 1', onPressed: () {}),
    ZetaBreadcrumbItem(label: 'Item 2', onPressed: () {}),
    ZetaBreadcrumbItem(
      label: 'Item 3',
      onPressed: () {},
      icon: ZetaIcons.star,
    ),
    ZetaBreadcrumbItem(label: 'Item 4', onPressed: () {}),
    ZetaBreadcrumbItem(label: 'Item 5', onPressed: () {}),
    ZetaBreadcrumbItem(label: 'Item 6', onPressed: () {}),
  ];

  group('Accessibility Tests', () {
    testWidgets('ZetaBreadcrumb meets accessibility standards', (tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaBreadcrumb(
            children: children,
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
    final debugFillProperties = {
      'children': children.toString().replaceAll('[', '').replaceAll(']', ''),
    };
    debugFillPropertiesTest(
      ZetaBreadcrumb(children: children),
      debugFillProperties,
    );

    // has the correct number of children
    testWidgets('ZetaBreadcrumb has the correct number of children', (tester) async {
      const maxItemsShown = 2;

      await tester.pumpWidget(
        TestApp(
          home: ZetaBreadcrumb(
            children: children,
          ),
        ),
      );
      expect(find.byType(ZetaBreadcrumbItem), findsNWidgets(maxItemsShown));

      await tester.tap(find.byType(TruncatedItem));
      await tester.pumpAndSettle();

      expect(find.byType(ZetaBreadcrumbItem), findsNWidgets(children.length));
    });

    // children have the correct labels
    testWidgets('ZetaBreadcrumb children have the correct labels', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBreadcrumb(
            children: children,
          ),
        ),
      );

      expect(find.text('Breadcrumb'), findsOneWidget);
      expect(find.text('Item ${children.length - 1}'), findsOneWidget);

      await tester.tap(find.byType(TruncatedItem));
      await tester.pumpAndSettle();

      for (int i = 0; i < children.length; i++) {
        expect(find.text(children[i].label), findsOneWidget);
      }
    });

    // children have the correct icons (if any)
    testWidgets(' ZetaBreadcrumb children have the correct icons', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBreadcrumb(
            children: children,
          ),
        ),
      );

      final iconFinder = find.byWidgetPredicate((widget) {
        if (widget is Icon) {
          return widget.icon == ZetaIcons.star;
        }
        return false;
      });
      expect(iconFinder, findsOneWidget);

      await tester.tap(find.byType(TruncatedItem));
      await tester.pumpAndSettle();

      final iconFinder1 = find.byWidgetPredicate((widget) {
        if (widget is Icon) {
          return widget.icon == ZetaIcons.star;
        }
        return false;
      });
      expect(iconFinder1, findsNWidgets(2));
    });
  });

  group('Dimensions Tests', () {
    // each item is equally spaced
    testWidgets('ZetaBreadcrumb items are equally spaced', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBreadcrumb(
            maxItemsShown: 7,
            children: [
              ZetaBreadcrumbItem(label: 'Item 0', onPressed: () {}),
              ZetaBreadcrumbItem(label: 'Item 1', onPressed: () {}),
              ZetaBreadcrumbItem(label: 'Item 2', onPressed: () {}),
              ZetaBreadcrumbItem(label: 'Item 3', onPressed: () {}),
              ZetaBreadcrumbItem(label: 'Item 4', onPressed: () {}),
              ZetaBreadcrumbItem(label: 'Item 5', onPressed: () {}),
              ZetaBreadcrumbItem(label: 'Item 6', onPressed: () {}),
            ],
          ),
        ),
      );

      final itemFinder = find.byType(ZetaBreadcrumbItem);

      final List<double> itemPositions = [];
      for (int i = 0; i < children.length; i++) {
        expect(itemFinder.at(i), findsOneWidget);
        itemPositions.add(tester.getTopLeft(itemFinder.at(i)).dx);
      }

      final double distance = itemPositions[1] - itemPositions[0];
      for (int i = 1; i < itemPositions.length; i++) {
        expect(itemPositions[i] - itemPositions[i - 1], distance);
      }
    });
  });

  group('Styling Tests', () {
    testWidgets('ZetaBreadcrumb label and icon colors are correct', (tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaBreadcrumb(
            maxItemsShown: 7,
            children: children,
          ),
        ),
      );
      final context = getBuildContext(tester, ZetaBreadcrumb);
      final colors = Zeta.of(context).colors;

      final labelFinder = find.byType(Text);
      final iconFinder = find.byType(Icon);

      for (int i = 0; i < children.length; i++) {
        if (i == children.length - 1) {
          expect(
            (tester.firstWidget(labelFinder.at(i)) as Text).style?.color,
            colors.primitives.pure.shade1000,
          );
        } else {
          expect(
            (tester.firstWidget(labelFinder.at(i)) as Text).style?.color,
            colors.mainSubtle,
          );
        }
      }

      for (int i = 0; i < iconFinder.evaluate().length; i++) {
        expect(
          (tester.firstWidget(iconFinder.at(i)) as Icon).color,
          colors.mainSubtle,
        );
      }
    });

    // label font styles are correct
    // icon sizes are correct

    // hovered state label and icon colors are correct
    // selected state label and icon colors are correct
  });

  group('Interaction Tests', () {
    // clicking on an item calls the onPressed callback
    // clicking on an item removes the children list after it
  });

  group('Golden Tests', () {
    // goldenTest(goldenFile, widget, 'PNG_FILE_NAME');
  });

  group('Performance Tests', () {});
}
