import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaButton';
  const String parentFolder = 'button';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {});

  group('$componentName Content Tests', () {
    final debugFillProperties = {
      'label': '"Test label"',
      'onPressed': 'null',
      'type': 'primary',
      'borderType': 'null',
      'size': 'medium',
      'leadingIcon': 'null',
      'trailingIcon': 'null',
    };
    debugFillPropertiesTest(
      const ZetaButton(label: 'Test label'),
      debugFillProperties,
    );

    testWidgets('Initializes with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton(onPressed: () {}, label: 'Test Button'),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('Initializes primary with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton.primary(onPressed: () {}, label: 'Test Button'),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, null);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.medium);
      expect(button.type, ZetaButtonType.primary);
    });

    testWidgets('Initializes secondary with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton.secondary(
            onPressed: () {},
            label: 'Test Button',
            leadingIcon: Icons.abc,
            size: ZetaWidgetSize.small,
          ),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, null);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, Icons.abc);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.small);
      expect(button.type, ZetaButtonType.secondary);
    });
    testWidgets('Initializes positive with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton.positive(onPressed: () {}, label: 'Test Button', trailingIcon: Icons.abc),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, null);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, Icons.abc);
      expect(button.size, ZetaWidgetSize.medium);
      expect(button.type, ZetaButtonType.positive);
    });
    testWidgets('Initializes negative with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton.negative(onPressed: () {}, label: 'Test Button', size: ZetaWidgetSize.small),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, null);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.small);
      expect(button.type, ZetaButtonType.negative);
    });
    testWidgets('Initializes outline with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton.outline(onPressed: () {}, label: 'Test Button', size: ZetaWidgetSize.large),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, null);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.large);
      expect(button.type, ZetaButtonType.outline);
    });
    testWidgets('Initializes outlineSubtle with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaButton.outlineSubtle(label: 'Test Button', borderType: ZetaWidgetBorder.sharp),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, ZetaWidgetBorder.sharp);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.medium);
      expect(button.type, ZetaButtonType.outlineSubtle);
    });
    testWidgets('Initializes text with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton.text(onPressed: () {}, label: 'Test Button', borderType: ZetaWidgetBorder.full),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, ZetaWidgetBorder.full);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.medium);
      expect(button.type, ZetaButtonType.text);
    });

    testWidgets('Disabled button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaButton.text(label: 'Test Button', borderType: ZetaWidgetBorder.full),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      expect(button.borderType, ZetaWidgetBorder.full);
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.onPressed, null);
      expect(button.size, ZetaWidgetSize.medium);
      expect(button.type, ZetaButtonType.text);
    });
  });

  group('$componentName Dimensions Tests', () {});

  group('$componentName Styling Tests', () {
    testWidgets('Hover states are correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton(label: 'Test Button', onPressed: () {}),
        ),
      );

      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);

      final filledButtonFinder = find.byType(FilledButton);
      final FilledButton filledButton = tester.firstWidget(filledButtonFinder);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(ZetaButton)));
      await tester.pumpAndSettle();

      expect(filledButton.style?.backgroundColor?.resolve({WidgetState.hovered}), ZetaColorBase.blue.shade50);

      await gesture.down(tester.getCenter(find.byType(ZetaButton)));
      await tester.pumpAndSettle();
      expect(filledButton.style?.backgroundColor?.resolve({WidgetState.pressed}), ZetaColorBase.blue.shade70);

      await gesture.up();

      await tester.pumpAndSettle();
      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.medium);
    });

    testWidgets('Focus state is correct', (WidgetTester tester) async {
      final FocusNode focusNode = FocusNode();
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton(label: 'Test Button', onPressed: () {}, focusNode: focusNode),
        ),
      );
      final buttonFinder = find.byType(ZetaButton);
      final ZetaButton button = tester.firstWidget(buttonFinder);
      focusNode.requestFocus();
      await tester.pump();
      final filledButtonFinder = find.byType(FilledButton);
      final FilledButton filledButton = tester.firstWidget(filledButtonFinder);

      expect(button.label, 'Test Button');
      expect(button.leadingIcon, null);
      expect(button.trailingIcon, null);
      expect(button.size, ZetaWidgetSize.medium);
      expect(
        filledButton.style?.side?.resolve({WidgetState.focused}),
        BorderSide(color: ZetaColorBase.blue, width: ZetaBorders.medium),
      );
    });
  });

  group('$componentName Interaction Tests', () {
    testWidgets('Triggers callback on tap', (WidgetTester tester) async {
      bool callbackTriggered = false;
      await tester.pumpWidget(
        TestApp(home: ZetaButton(onPressed: () => callbackTriggered = true, label: 'Test Button')),
      );
      await tester.tap(find.byType(ZetaButton));
      await tester.pump();

      expect(callbackTriggered, isTrue);
    });
  });

  group('$componentName Golden Tests', () {
    goldenTest(goldenFile, ZetaButton.primary(onPressed: () {}, label: 'Test Button'), ZetaButton, 'button_primary');
    goldenTest(
      goldenFile,
      ZetaButton.secondary(onPressed: () {}, label: 'Test Button', leadingIcon: Icons.abc, size: ZetaWidgetSize.small),
      ZetaButton,
      'button_secondary',
    );
    goldenTest(
      goldenFile,
      ZetaButton.positive(onPressed: () {}, label: 'Test Button', trailingIcon: Icons.abc),
      ZetaButton,
      'button_positive',
    );
    goldenTest(
      goldenFile,
      ZetaButton.negative(onPressed: () {}, label: 'Test Button', size: ZetaWidgetSize.small),
      ZetaButton,
      'button_negative',
    );
    goldenTest(
      goldenFile,
      ZetaButton.outline(onPressed: () {}, label: 'Test Button', size: ZetaWidgetSize.large),
      ZetaButton,
      'button_outline',
    );
    goldenTest(
      goldenFile,
      const ZetaButton.outlineSubtle(label: 'Test Button', borderType: ZetaWidgetBorder.sharp),
      ZetaButton,
      'button_outline_subtle',
    );
    goldenTest(
      goldenFile,
      ZetaButton.text(onPressed: () {}, label: 'Test Button', borderType: ZetaWidgetBorder.full),
      ZetaButton,
      'button_text',
    );
    goldenTest(
      goldenFile,
      const ZetaButton.text(label: 'Test Button', borderType: ZetaWidgetBorder.full),
      ZetaButton,
      'button_disabled',
    );
  });

  group('$componentName Performance Tests', () {});
}
