import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/test_app.dart';
import '../../utils/tolerant_comparator.dart';
import '../../utils/utils.dart';
import 'tooltip_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<Zeta>(),
])
void main() {
  const String parentFolder = 'tooltip';

  final mockZeta = MockZeta();
  when(mockZeta.radius).thenReturn(const ZetaRadiusAA(primitives: ZetaPrimitivesLight()));

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});
  group('Content Tests', () {
    final debugFillProperties = {
      'rounded': 'null',
      'padding': 'EdgeInsets.all(8.0)',
      'color': Colors.amber.toString(),
      'textStyle': 'TextStyle(inherit: true, size: 9.0)',
      'arrowDirection': 'down',
      'maxWidth': '170.0',
    };
    debugFillPropertiesTest(
      const ZetaTooltip(
        padding: EdgeInsets.all(8),
        color: Colors.amber,
        textStyle: TextStyle(fontSize: 9),
        maxWidth: 170,
        child: Text('Rounded tooltip'),
      ),
      debugFillProperties,
    );

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
  });
  group('Dimensions Tests', () {
    testWidgets('renders with custom padding', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Scaffold(
            body: ZetaTooltip(
              padding: EdgeInsets.all(20),
              child: Text('Tooltip text'),
            ),
          ),
        ),
      );

      final padding = tester.widget<Padding>(
        find.descendant(
          of: find.byType(ZetaTooltip),
          matching: find.byType(Padding),
        ),
      );

      expect(padding.padding, const EdgeInsets.all(20));
    });
  });
  group('Styling Tests', () {
    testWidgets('renders with custom color', (WidgetTester tester) async {
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

      expect((roundedTooltipBox.decoration as BoxDecoration).borderRadius, BorderRadius.all(mockZeta.radius.minimal));
      expect((sharpTooltipBox.decoration as BoxDecoration).borderRadius, null);
    });
  });
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      const TestApp(
        home: ZetaTooltip(
          arrowDirection: ZetaTooltipArrowDirection.up,
          child: Text('Tooltip up'),
        ),
      ),
      'arrow_up',
      widgetType: ZetaTooltip,
    );
    goldenTest(
      goldenFile,
      const TestApp(
        home: ZetaTooltip(
          child: Text('Tooltip down'),
        ),
      ),
      'arrow_down',
      widgetType: ZetaTooltip,
    );
    goldenTest(
      goldenFile,
      const TestApp(
        home: ZetaTooltip(
          arrowDirection: ZetaTooltipArrowDirection.left,
          child: Text('Tooltip left'),
        ),
      ),
      'arrow_left',
      widgetType: ZetaTooltip,
    );
    goldenTest(
      goldenFile,
      const TestApp(
        home: ZetaTooltip(
          arrowDirection: ZetaTooltipArrowDirection.right,
          child: Text('Tooltip right'),
        ),
      ),
      'arrow_right',
      widgetType: ZetaTooltip,
    );
  });
  group('Performance Tests', () {});
}
