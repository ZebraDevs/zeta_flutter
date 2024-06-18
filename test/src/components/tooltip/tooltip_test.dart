// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/utils.dart';

void main() {
  group('ZetaTooltip Widget Tests', () {
    testWidgets('renders with default properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              child: Text('Tooltip text'),
            ),
          ),
        ),
      );

      expect(find.text('Tooltip text'), findsOneWidget);
      expect(find.byType(ZetaTooltip), findsOneWidget);
    });

    testWidgets('renders with custom color and padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              color: Colors.red,
              padding: EdgeInsets.all(20),
              child: Text('Tooltip text'),
            ),
          ),
        ),
      );

      final tooltipBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.byType(ZetaTooltip),
          matching: find.byType(DecoratedBox),
        ),
      );

      expect((tooltipBox.decoration as BoxDecoration).color, Colors.red);

      final padding = tester.widget<Padding>(
        find.descendant(
          of: find.byType(ZetaTooltip),
          matching: find.byType(Padding),
        ),
      );

      expect(padding.padding, const EdgeInsets.all(20));
    });

    testWidgets('renders with custom text style', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              textStyle: TextStyle(fontSize: 24, color: Colors.blue),
              child: Text('Tooltip text'),
            ),
          ),
        ),
      );

      // Find the RichText widget, which is a descendant of the Text widget
      final richTextFinder = find.descendant(
        of: find.text('Tooltip text'),
        matching: find.byType(RichText),
      );

      expect(richTextFinder, findsOneWidget);

      // Verify the styles
      final RichText richTextWidget = tester.widget(richTextFinder);
      final TextSpan textSpan = richTextWidget.text as TextSpan;

      expect(textSpan.style?.fontSize, 24);
      expect(textSpan.style?.color, Colors.blue);
    });

    testWidgets('renders with arrow correctly in up direction', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              arrowDirection: ZetaTooltipArrowDirection.up,
              child: Text('Tooltip up'),
            ),
          ),
        ),
      );

      expect(find.text('Tooltip up'), findsOneWidget);

      // Verifying the CustomPaint with different arrow directions.
      await expectLater(
        find.byType(ZetaTooltip),
        matchesGoldenFile(join(getCurrentPath('tooltip'), 'arrow_up.png')),
      );
    });

    testWidgets('renders with arrow correctly in down direction', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              child: Text('Tooltip down'),
            ),
          ),
        ),
      );

      expect(find.text('Tooltip down'), findsOneWidget);

      // Verifying the CustomPaint with different arrow directions.
      await expectLater(
        find.byType(ZetaTooltip),
        matchesGoldenFile(join(getCurrentPath('tooltip'), 'arrow_down.png')),
      );
    });

    testWidgets('renders with arrow correctly in left direction', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              arrowDirection: ZetaTooltipArrowDirection.left,
              child: Text('Tooltip left'),
            ),
          ),
        ),
      );

      expect(find.text('Tooltip left'), findsOneWidget);

      // Verifying the CustomPaint with different arrow directions.
      await expectLater(
        find.byType(ZetaTooltip),
        matchesGoldenFile(join(getCurrentPath('tooltip'), 'arrow_left.png')),
      );
    });

    testWidgets('renders with arrow correctly in right direction', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              arrowDirection: ZetaTooltipArrowDirection.right,
              child: Text('Tooltip right'),
            ),
          ),
        ),
      );

      expect(find.text('Tooltip right'), findsOneWidget);

      // Verifying the CustomPaint with different arrow directions.
      await expectLater(
        find.byType(ZetaTooltip),
        matchesGoldenFile(join(getCurrentPath('tooltip'), 'arrow_right.png')),
      );
    });

    testWidgets('renders with rounded and sharp corners', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: Column(
              children: [
                ZetaTooltip(
                  child: Text('Rounded tooltip'),
                ),
                ZetaTooltip(
                  rounded: false,
                  child: Text('Sharp tooltip'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Rounded tooltip'), findsOneWidget);
      expect(find.text('Sharp tooltip'), findsOneWidget);

      final roundedTooltipBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.widgetWithText(ZetaTooltip, 'Rounded tooltip'),
          matching: find.byType(DecoratedBox),
        ),
      );

      final sharpTooltipBox = tester.widget<DecoratedBox>(
        find.descendant(
          of: find.widgetWithText(ZetaTooltip, 'Sharp tooltip'),
          matching: find.byType(DecoratedBox),
        ),
      );

      expect((roundedTooltipBox.decoration as BoxDecoration).borderRadius, ZetaRadius.minimal);
      expect((sharpTooltipBox.decoration as BoxDecoration).borderRadius, null);
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();
      const ZetaTooltip(
        padding: EdgeInsets.all(8),
        color: Colors.amber,
        textStyle: TextStyle(fontSize: 9),
        maxWidth: 170,
        child: Text('Rounded tooltip'),
      ).debugFillProperties(diagnostics);

      expect(diagnostics.finder('rounded'), 'null');
      expect(diagnostics.finder('padding'), 'EdgeInsets.all(8.0)');
      expect(diagnostics.finder('color').toLowerCase(), contains(Colors.amber.hexCode.toLowerCase()));
      expect(diagnostics.finder('textStyle'), contains('size: 9.0'));
      expect(diagnostics.finder('arrowDirection'), 'down');
      expect(diagnostics.finder('maxWidth'), '170.0');
    });
  });
}
