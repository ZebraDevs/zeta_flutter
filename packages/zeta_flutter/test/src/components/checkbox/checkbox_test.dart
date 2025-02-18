import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/checkbox/checkbox.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'checkbox';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});
  group('Content Tests', () {
    final debugFillPropertiesCheckbox = {
      'value': 'false',
      'label': 'null',
      'onChanged': 'null',
      'rounded': 'null',
      'useIndeterminate': 'false',
      'focusNode': 'null',
    };
    debugFillPropertiesTest(
      ZetaCheckbox(),
      debugFillPropertiesCheckbox,
    );
    final debugFillPropertiesCheckboxInternal = {
      'value': 'false',
      'label': 'null',
      'rounded': 'null',
      'useIndeterminate': 'false',
      'error': 'false',
      'disabled': 'false',
      'focusNode': 'null',
    };
    debugFillPropertiesTest(
      ZetaInternalCheckbox(onChanged: (_) {}),
      debugFillPropertiesCheckboxInternal,
    );

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
  });
  group('Dimensions Tests', () {});
  group('Styling Tests', () {});
  group('Interaction Tests', () {
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
      expect(
        (animatedContainer.decoration as BoxDecoration?)?.boxShadow?.first.color,
        const ZetaPrimitivesLight().blue.shade50,
      );

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
  });
  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      ZetaCheckbox(
        onChanged: (value) {},
      ),
      'checkbox_hover',
      beforeComparison: (tester) async {
        final checkboxFinder = find.byType(ZetaCheckbox);

        // Hover state
        final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();
        await gesture.moveTo(tester.getCenter(checkboxFinder));
        await tester.pumpAndSettle();
      },
    );

    goldenTest(
      goldenFile,
      ZetaCheckbox(
        value: true,
        onChanged: print,
      ),
      'checkbox_enabled',
    );

    goldenTest(
      goldenFile,
      ZetaCheckbox(
        value: true,
      ),
      'checkbox_disabled',
    );
  });
  group('Performance Tests', () {});
}
