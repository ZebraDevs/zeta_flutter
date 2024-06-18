import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_app.dart';
import '../../../test_utils/utils.dart';

void main() {
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
        matchesGoldenFile(join(getCurrentPath('fabs'), 'FAB_default.png')),
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

      await tester.tap(find.byType(ZetaFAB));
      await tester.pumpAndSettle();
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

    expect(fab.initiallyExpanded, null);
    expect(fab.type, ZetaFabType.inverse);
    expect(fab.shape, ZetaWidgetBorder.rounded);

    await expectLater(
      find.byType(ZetaFAB),
      matchesGoldenFile(join(getCurrentPath('fabs'), 'FAB_inverse.png')),
    );
  });

  testWidgets('Expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestApp(
        home: ZetaFAB(
          initiallyExpanded: true,
          onPressed: () {},
          label: 'Label',
          type: ZetaFabType.secondary,
          shape: ZetaWidgetBorder.sharp,
        ),
      ),
    );

    final fabFinder = find.byType(ZetaFAB);
    final ZetaFAB fab = tester.firstWidget(fabFinder);

    expect(fab.initiallyExpanded, true);
    expect(fab.type, ZetaFabType.secondary);
    expect(fab.shape, ZetaWidgetBorder.sharp);

    await expectLater(
      find.byType(ZetaFAB),
      matchesGoldenFile(join(getCurrentPath('fabs'), 'FAB_secondary.png')),
    );
  });
  testWidgets('ZetaFAB interactive', (WidgetTester tester) async {
    final FocusNode node = FocusNode();

    await tester.pumpWidget(
      TestApp(
        home: ZetaFAB(
          initiallyExpanded: true,
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

    expect(fab.initiallyExpanded, true);
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
      BorderSide(color: ZetaColorBase.blue[50]!, width: ZetaSpacingBase.x0_5),
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
    expect(diagnostics.finder('initiallyExpanded'), 'null');
    expect(diagnostics.finder('focusNode'), 'null');
  });
}
