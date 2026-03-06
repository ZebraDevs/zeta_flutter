import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'fab';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});

  group('Content Tests', () {
    final debugFillProperties = {
      'label': 'null',
      'onPressed': 'null',
      'type': 'primary',
      'size': 'small',
      'shape': 'full',
      'icon': 'IconData(U+0${ZetaIcons.add_round.codePoint.toRadixString(16).toUpperCase()})',
      'initiallyExpanded': 'false',
      'focusNode': 'null',
    };
    debugFillPropertiesTest(
      const ZetaFAB(),
      debugFillProperties,
    );

    testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
      final scrollController = ScrollController();
      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(scrollController: scrollController, label: 'Label', onPressed: () {}),
        ),
      );

      expect(find.byType(ZetaFAB), findsOneWidget);
    });

    testWidgets('Icon Test', (WidgetTester tester) async {
      final scrollController = ScrollController();
      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(
            scrollController: scrollController,
            onPressed: () {},
            type: ZetaFabType.inverse,
            shape: ZetaWidgetBorder.rounded,
            size: ZetaFabSize.large,
          ),
        ),
      );
      expect(find.byIcon(ZetaIcons.add), findsOneWidget);
      final fabFinder = find.byType(ZetaFAB);
      final ZetaFAB fab = tester.firstWidget(fabFinder);

      expect(fab.expanded, false);
      expect(fab.type, ZetaFabType.inverse);
      expect(fab.shape, ZetaWidgetBorder.rounded);
    });

    testWidgets('Expanded', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(
            expanded: true,
            onPressed: () {},
            label: 'Label',
            type: ZetaFabType.secondary,
            shape: ZetaWidgetBorder.sharp,
          ),
        ),
      );

      final fabFinder = find.byType(ZetaFAB);
      final ZetaFAB fab = tester.firstWidget(fabFinder);

      expect(fab.expanded, true);
      expect(fab.type, ZetaFabType.secondary);
      expect(fab.shape, ZetaWidgetBorder.sharp);
    });

    testWidgets('Disabled FAB', (WidgetTester tester) async {
      final scrollController = ScrollController();
      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(scrollController: scrollController, label: 'Disabled'),
        ),
      );

      final fabFinder = find.byType(ZetaFAB);
      final ZetaFAB fab = tester.firstWidget(fabFinder);

      expect(fab.onPressed, isNull);
      expect(fab.type, ZetaFabType.primary);
      expect(fab.shape, ZetaWidgetBorder.full);
    });

    testWidgets('Label is correct', (WidgetTester tester) async {
      final scrollController = ScrollController();
      StateSetter? setState;
      bool expanded = false;

      await tester.pumpWidget(
        TestApp(
          home: StatefulBuilder(
            builder: (context, setState2) {
              setState = setState2;
              return ZetaFAB(
                scrollController: scrollController,
                expanded: expanded,
                label: 'Label',
                onPressed: () {},
              );
            },
          ),
        ),
      );

      final labelFinder = find.text('Label');

      expect(labelFinder, findsOne);

      setState?.call(() => expanded = true);

      await tester.pumpAndSettle();
      expect(labelFinder, findsOne);
    });
  });

  group('Dimensions Tests', () {});

  group('Styling Tests', () {
    testWidgets('hover colours are correct', (WidgetTester tester) async {
      final FocusNode node = FocusNode();

      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(
            expanded: true,
            onPressed: () {},
            label: 'Label',
            type: ZetaFabType.secondary,
            shape: ZetaWidgetBorder.sharp,
            focusNode: node,
          ),
        ),
      );

      final fabFinder = find.byType(ZetaFAB);
      final ZetaFAB fab = tester.firstWidget(fabFinder);
      final filledButtonFinder = find.byType(FilledButton);
      final FilledButton filledButton = tester.firstWidget(filledButtonFinder);

      expect(fab.expanded, true);
      expect(fab.type, ZetaFabType.secondary);
      expect(fab.shape, ZetaWidgetBorder.sharp);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await tester.pumpAndSettle();
      await gesture.moveTo(tester.getCenter(fabFinder));
      await tester.pumpAndSettle();

      expect(
        filledButton.style?.backgroundColor?.resolve({WidgetState.hovered}),
        const ZetaPrimitivesLight().greenBrand.shade50,
      );

      await gesture.moveTo(Offset.zero);
      await tester.pumpAndSettle();

      node.requestFocus();
      await tester.pumpAndSettle();
      expect(
        filledButton.style?.side?.resolve({WidgetState.focused}),
        BorderSide(color: const ZetaPrimitivesLight().primary[50]!, width: ZetaBorders.medium),
      );
    });
  });

  group('Interaction Tests', () {
    testWidgets('OnPressed callback', (WidgetTester tester) async {
      bool isPressed = false;
      final scrollController = ScrollController();

      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(scrollController: scrollController, label: 'Label', onPressed: () => isPressed = true),
        ),
      );
      final TestGesture e = await tester.press(find.byType(ZetaFAB));

      await tester.pumpAndSettle();

      await e.up();
      expect(isPressed, isTrue);
    });
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      ZetaFAB(
        scrollController: ScrollController(),
        label: 'Label',
        onPressed: () {},
      ),
      'FAB_default',
    );
    goldenTest(
      goldenFile,
      ZetaFAB(scrollController: ScrollController(), label: 'Label', onPressed: () => {}),
      'FAB_pressed',
      beforeComparison: (tester) async {
        await tester.press(find.byType(ZetaFAB));
        await tester.pumpAndSettle();
      },
    );
    goldenTest(
      goldenFile,
      ZetaFAB(
        scrollController: ScrollController(),
        onPressed: () {},
        type: ZetaFabType.inverse,
        shape: ZetaWidgetBorder.rounded,
        size: ZetaFabSize.large,
      ),
      'FAB_inverse',
    );
    goldenTest(
      goldenFile,
      ZetaFAB(scrollController: ScrollController(), label: 'Label', onPressed: () => {}),
      'FAB_pressed',
      beforeComparison: (tester) async {
        await tester.press(find.byType(ZetaFAB));
        await tester.pumpAndSettle();
      },
    );
    goldenTest(
      goldenFile,
      ZetaFAB(
        expanded: true,
        onPressed: () {},
        label: 'Label',
        type: ZetaFabType.secondary,
        shape: ZetaWidgetBorder.sharp,
      ),
      'FAB_secondary',
    );
    goldenTest(
      goldenFile,
      ZetaFAB(scrollController: ScrollController(), label: 'Disabled'),
      'FAB_disabled',
    );
  });

  group('Performance Tests', () {});
}
