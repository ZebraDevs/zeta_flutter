import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  setUpAll(() {
    final testUri = Uri.parse(getCurrentPath('button'));
    goldenFileComparator = TolerantComparator(testUri, tolerance: 0.01);
  });

  group('ZetaButton Tests', () {
    testWidgets('Initializes with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaButton(onPressed: () {}, label: 'Test Button'),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });
  });

  testWidgets('Triggers callback on tap', (WidgetTester tester) async {
    bool callbackTriggered = false;
    await tester.pumpWidget(
      TestApp(home: ZetaButton(onPressed: () => callbackTriggered = true, label: 'Test Button')),
    );
    await tester.tap(find.byType(ZetaButton));
    await tester.pump();

    expect(callbackTriggered, isTrue);
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

    await expectLater(find.byType(ZetaButton), matchesGoldenFile(join(getCurrentPath('button'), 'button_primary.png')));
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

    await expectLater(
      find.byType(ZetaButton),
      matchesGoldenFile(join(getCurrentPath('button'), 'button_secondary.png')),
    );
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

    await expectLater(
      find.byType(ZetaButton),
      matchesGoldenFile(join(getCurrentPath('button'), 'button_positive.png')),
    );
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

    await expectLater(
      find.byType(ZetaButton),
      matchesGoldenFile(join(getCurrentPath('button'), 'button_negative.png')),
    );
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

    await expectLater(find.byType(ZetaButton), matchesGoldenFile(join(getCurrentPath('button'), 'button_outline.png')));
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

    await expectLater(
      find.byType(ZetaButton),
      matchesGoldenFile(join(getCurrentPath('button'), 'button_outline_subtle.png')),
    );
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

    await expectLater(
      find.byType(ZetaButton),
      matchesGoldenFile(join(getCurrentPath('button'), 'button_text.png')),
    );
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

    await expectLater(
      find.byType(ZetaButton),
      matchesGoldenFile(join(getCurrentPath('button'), 'button_disabled.png')),
    );
  });
  testWidgets('Interaction with button', (WidgetTester tester) async {
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
  testWidgets('Interaction with button', (WidgetTester tester) async {
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
      const BorderSide(color: ZetaColorBase.blue, width: ZetaSpacingBase.x0_5),
    );
  });
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaButton(label: 'Test label').debugFillProperties(diagnostics);

    expect(diagnostics.finder('label'), '"Test label"');
    expect(diagnostics.finder('onPressed'), 'null');
    expect(diagnostics.finder('type'), 'primary');
    expect(diagnostics.finder('borderType'), 'null');
    expect(diagnostics.finder('size'), 'medium');
    expect(diagnostics.finder('leadingIcon'), 'null');
    expect(diagnostics.finder('trailingIcon'), 'null');
  });
}
