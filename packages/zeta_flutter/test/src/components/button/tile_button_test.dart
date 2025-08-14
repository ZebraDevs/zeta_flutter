import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'button';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    meetsAccessibilityGuidelinesTest(
      const ZetaTileButton(
        label: 'Button',
        icon: Icons.star,
      ),
    );

    testWidgets('Uses semantic label if provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
            semanticLabel: 'Semantic Button',
          ),
        ),
      );

      final Finder button = find.byType(ZetaTileButton);
      expect(tester.getSemantics(button).label, 'Semantic Button');
    });
  });

  group('Content Tests', () {
    testWidgets('Renders label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      expect(find.text('Button'), findsOneWidget);
    });

    testWidgets('Renders icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('Creates ellipsis when text is longer than width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button with a very long text',
            icon: Icons.star,
          ),
        ),
      );

      final Text textWidget = tester.widget(find.byType(Text));
      expect(textWidget.overflow, TextOverflow.ellipsis);
    });

    testWidgets('Renders another icon when one other than the default is selected', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button with a very long text',
            icon: Icons.block,
          ),
        ),
      );

      expect(find.byIcon(Icons.block), findsOneWidget);
    });
  });

  group('Dimensions Tests', () {
    testWidgets('Has correct height', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      final RenderBox renderButton = tester.renderObject(find.byType(ZetaTileButton));
      expect(renderButton.size.height, equals(80));
    });

    testWidgets('Has correct width', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      final RenderBox renderButton = tester.renderObject(find.byType(ZetaTileButton));
      expect(renderButton.size.width, equals(80));
    });

    testWidgets('Button stays the same width when text is very long', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button with a very long text',
            icon: Icons.star,
          ),
        ),
      );

      final RenderBox renderButton = tester.renderObject(find.byType(ZetaTileButton));
      expect(renderButton.size.width, equals(80));
    });

    testWidgets('Button stays the same width when there is no text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: '',
            icon: Icons.star,
          ),
        ),
      );

      final RenderBox renderButton = tester.renderObject(find.byType(ZetaTileButton));
      expect(renderButton.size.width, equals(80));
    });
  });

  group('Styling Tests', () {
    testWidgets('Applies rounded border by default', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      final ZetaTileButton tileButton = tester.widget(find.byType(ZetaTileButton));
      expect(tileButton.rounded, null);
      final FilledButton filledButton = tester.widget(find.byType(FilledButton));
      expect(
        (filledButton.style?.shape?.resolve({}) as RoundedRectangleBorder?)?.borderRadius,
        BorderRadius.circular(4),
      );
    });

    testWidgets('Applies sharp border when specified', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
            rounded: false,
          ),
        ),
      );

      final ZetaTileButton tileButton = tester.widget(find.byType(ZetaTileButton));
      expect(tileButton.rounded, false);
      final FilledButton filledButton = tester.widget(find.byType(FilledButton));
      expect(
        (filledButton.style?.shape?.resolve({}) as RoundedRectangleBorder?)?.borderRadius,
        BorderRadius.circular(0),
      );
    });

    testWidgets('Has the correct background colour when disabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      final FilledButton button = tester.widget(find.byType(FilledButton));
      final ButtonStyle style = button.style!;
      final Color? backgroundColor = style.backgroundColor?.resolve({WidgetState.disabled});
      expect(backgroundColor, const ZetaPrimitivesLight().cool.shade30);
    });

    testWidgets('Has the correct background colour when enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
            onPressed: () {},
          ),
        ),
      );

      final FilledButton button = tester.widget(find.byType(FilledButton));
      final ButtonStyle style = button.style!;
      final Color? backgroundColor = style.backgroundColor?.resolve({});
      expect(backgroundColor, const ZetaPrimitivesLight().pure.shade0);
    });

    testWidgets('Hover states are correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
            onPressed: () {},
          ),
        ),
      );

      final buttonFinder = find.byType(ZetaTileButton);
      final ZetaTileButton button = tester.firstWidget(buttonFinder);

      final filledButtonFinder = find.byType(FilledButton);
      final FilledButton filledButton = tester.firstWidget(filledButtonFinder);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(ZetaTileButton)));
      await tester.pumpAndSettle();

      expect(
        filledButton.style?.backgroundColor?.resolve({WidgetState.hovered}),
        const ZetaPrimitivesLight().cool.shade20,
      );

      await gesture.down(tester.getCenter(find.byType(ZetaTileButton)));
      await tester.pumpAndSettle();
      expect(
        filledButton.style?.backgroundColor?.resolve({WidgetState.pressed}),
        const ZetaPrimitivesLight().blue.shade10,
      );

      await gesture.up();

      await tester.pumpAndSettle();
      expect(button.label, 'Button');
      expect(button.icon, Icons.star);
    });

    testWidgets('Focus state is correct', (WidgetTester tester) async {
      final FocusNode focusNode = FocusNode();
      await tester.pumpWidget(
        TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
            onPressed: () {},
          ),
        ),
      );
      final buttonFinder = find.byType(ZetaTileButton);
      final ZetaTileButton button = tester.firstWidget(buttonFinder);
      focusNode.requestFocus();
      await tester.pump();
      final filledButtonFinder = find.byType(FilledButton);
      final FilledButton filledButton = tester.firstWidget(filledButtonFinder);

      expect(button.label, 'Button');
      expect(button.icon, Icons.star);
      expect(
        filledButton.style?.side?.resolve({WidgetState.focused}),
        BorderSide(color: const ZetaPrimitivesLight().primary.shade50, width: ZetaBorders.medium),
      );
    });
  });

  group('Interaction Tests', () {
    testWidgets('Calls onPressed when tapped', (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(ZetaTileButton));
      expect(pressed, isTrue);
    });

    testWidgets('Does not call onPressed when disabled', (WidgetTester tester) async {
      const bool pressed = false;

      await tester.pumpWidget(
        const TestApp(
          home: ZetaTileButton(
            label: 'Button',
            icon: Icons.star,
          ),
        ),
      );

      await tester.tap(find.byType(ZetaTileButton));
      expect(pressed, isFalse);
    });
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      ZetaTileButton(icon: Icons.star, onPressed: () {}, label: 'Test Button'),
      'tile_button_default',
    );
    goldenTest(
      goldenFile,
      ZetaTileButton(icon: Icons.star, onPressed: () {}, label: 'Test Button', rounded: false),
      'tile_button_sharp',
    );
    goldenTest(
      goldenFile,
      const ZetaTileButton(icon: Icons.star, label: 'Test Button'),
      'tile_button_disabled',
    );
  });

  group('Performance Tests', () {});
}
