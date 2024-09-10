import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFiles(component: 'fab');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaFAB Tests', () {
    testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
      final scrollController = ScrollController();
      await tester.pumpWidget(
        TestApp(
          home: ZetaFAB(scrollController: scrollController, label: 'Label', onPressed: () {}),
        ),
      );

      expect(find.byType(ZetaFAB), findsOneWidget);

      await expectLater(
        find.byType(ZetaFAB),
        matchesGoldenFile(goldenFile.getFileUri('FAB_default')),
      );
    });

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

      await expectLater(
        find.byType(ZetaFAB),
        matchesGoldenFile(goldenFile.getFileUri('FAB_pressed')),
      );

      await e.up();
      expect(isPressed, isTrue);
    });
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
    expect(find.byIcon(ZetaIcons.add_round), findsOneWidget);
    final fabFinder = find.byType(ZetaFAB);
    final ZetaFAB fab = tester.firstWidget(fabFinder);

    expect(fab.expanded, false);
    expect(fab.type, ZetaFabType.inverse);
    expect(fab.shape, ZetaWidgetBorder.rounded);

    await expectLater(
      find.byType(ZetaFAB),
      matchesGoldenFile(goldenFile.getFileUri('FAB_inverse')),
    );
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

    await expectLater(
      find.byType(ZetaFAB),
      matchesGoldenFile(goldenFile.getFileUri('FAB_secondary')),
    );
  });
  testWidgets('ZetaFAB interactive', (WidgetTester tester) async {
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

    expect(filledButton.style?.backgroundColor?.resolve({WidgetState.hovered}), ZetaColorBase.yellow.shade70);

    await gesture.moveTo(Offset.zero);
    await tester.pumpAndSettle();

    node.requestFocus();
    await tester.pumpAndSettle();
    expect(
      filledButton.style?.side?.resolve({WidgetState.focused}),
      BorderSide(color: ZetaColorBase.blue[50]!, width: ZetaBorders.medium),
    );
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

    await expectLater(
      find.byType(ZetaFAB),
      matchesGoldenFile(goldenFile.getFileUri('FAB_disabled')),
    );
  });

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaFAB().debugFillProperties(diagnostics);

    expect(diagnostics.finder('label'), 'null');
    expect(diagnostics.finder('onPressed'), 'null');
    expect(diagnostics.finder('type'), 'primary');
    expect(diagnostics.finder('size'), 'small');
    expect(diagnostics.finder('shape'), 'full');
    expect(diagnostics.finder('icon'), 'IconData(U+0E009)');
    expect(diagnostics.finder('initiallyExpanded'), 'false');
    expect(diagnostics.finder('focusNode'), 'null');
  });

  testWidgets('Expanded changes when label is null', (WidgetTester tester) async {
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

    expect(labelFinder, findsNothing);

    setState?.call(() => expanded = true);

    await tester.pumpAndSettle();
    expect(labelFinder, findsOne);
  });
}
