import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/checkbox/checkbox.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFinder(component: 'checkbox');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaCheckbox Tests', () {
    testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaCheckbox(
            value: true,
            onChanged: (value) {},
            label: 'Test Checkbox',
          ),
        ),
      );

      final checkboxFinder = find.byType(ZetaCheckbox);
      final ZetaCheckbox checkbox = tester.firstWidget(checkboxFinder);

      expect(checkbox.value, true);
      expect(checkbox.rounded, null);
      expect(checkbox.label, 'Test Checkbox');
    });

    testWidgets('ZetaCheckbox changes state on tap', (WidgetTester tester) async {
      bool? checkboxValue = true;

      await tester.pumpWidget(
        TestApp(
          home: ZetaCheckbox(
            value: checkboxValue,
            onChanged: (value) {
              checkboxValue = value;
            },
          ),
        ),
      );

      final checkboxFinder = find.byType(ZetaCheckbox);
      await expectLater(
        checkboxFinder,
        matchesGoldenFile(goldenFile.getFileUri('checkbox_enabled.png')),
      );
      await tester.tap(find.byType(ZetaCheckbox));
      await tester.pump();

      expect(checkboxValue, false);
    });
    testWidgets("Disabled ZetaCheckbox doesn't change state on tap", (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaCheckbox(
            value: true,
          ),
        ),
      );

      final checkboxFinder = find.byType(ZetaCheckbox);
      await expectLater(
        checkboxFinder,
        matchesGoldenFile(goldenFile.getFileUri('checkbox_disabled.png')),
      );
      await tester.tap(find.byType(ZetaCheckbox));
      await tester.pump();
      final ZetaCheckbox checkbox = tester.firstWidget(checkboxFinder);

      expect(checkbox.value, true);
    });

    testWidgets('ZetaCheckbox interaction', (WidgetTester tester) async {
      final FocusNode node = FocusNode();

      await tester.pumpWidget(
        TestApp(
          home: ZetaCheckbox(
            focusNode: node,
            onChanged: (value) {},
            value: true,
          ),
        ),
      );

      node.requestFocus();
      await tester.pump();

      final animatedContainerFinder = find.byType(AnimatedContainer);
      final AnimatedContainer animatedContainer = tester.firstWidget(animatedContainerFinder);
      expect((animatedContainer.decoration as BoxDecoration?)?.boxShadow?.first.color, ZetaColorBase.blue.shade50);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(ZetaInternalCheckbox)));
      await gesture.moveTo(tester.getCenter(find.byType(ZetaCheckbox)));
      await gesture.moveTo(Offset.zero);
      await gesture.moveTo(tester.getCenter(find.byType(ZetaInternalCheckbox)));

      await tester.pumpAndSettle();

      await tester.tap(find.byType(ZetaCheckbox));
      await tester.pump();
    });

    testWidgets('ZetaCheckbox UI changes on hover', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaCheckbox(
            onChanged: (value) {},
          ),
        ),
      );

      final checkboxFinder = find.byType(ZetaCheckbox);

      // Hover state
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(checkboxFinder));
      await tester.pumpAndSettle();
      await expectLater(
        checkboxFinder,
        matchesGoldenFile(goldenFile.getFileUri('checkbox_hover.png')),
      );
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();
      ZetaCheckbox().debugFillProperties(diagnostics);

      expect(diagnostics.finder('value'), 'false');
      expect(diagnostics.finder('label'), 'null');
      expect(diagnostics.finder('onChanged'), 'null');
      expect(diagnostics.finder('rounded'), 'null');
      expect(diagnostics.finder('useIndeterminate'), 'false');
      expect(diagnostics.finder('focusNode'), 'null');

      final internalDiagnostics = DiagnosticPropertiesBuilder();
      ZetaInternalCheckbox(onChanged: (_) {}).debugFillProperties(internalDiagnostics);
      expect(internalDiagnostics.finder('value'), 'false');
      expect(internalDiagnostics.finder('label'), 'null');
      expect(internalDiagnostics.finder('rounded'), 'null');
      expect(internalDiagnostics.finder('useIndeterminate'), 'false');
      expect(internalDiagnostics.finder('error'), 'false');
      expect(internalDiagnostics.finder('disabled'), 'false');
      expect(internalDiagnostics.finder('focusNode'), 'null');
    });
  });
}
