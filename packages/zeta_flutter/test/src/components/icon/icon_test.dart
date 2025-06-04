import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'icon';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    testWidgets('applies correct semantic label to icon', (WidgetTester tester) async {
      const String semanticLabel = 'Add Icon';
      await tester.pumpWidget(const TestApp(home: Icon(ZetaIcons.add_round, semanticLabel: semanticLabel)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.semanticLabel, equals(semanticLabel));
    });
  });
  group('Content Tests', () {
    final debugFillProperties = {
      'icon': 'IconData(U+0${ZetaIcons.cached_sharp.codePoint.toRadixString(16).toUpperCase()})',
      'rounded': 'null',
      'size': '10.0',
      'fill': 'null',
      'weight': 'null',
      'grade': 'null',
      'opticalSize': 'null',
      'color': 'null',
      'shadows': 'null',
      'semanticLabel': '"Cached"',
      'textDirection': 'null',
      'applyTextScaling': 'null',
    };
    const icon = ZetaIcon(
      ZetaIcons.cached_sharp,
      size: 10,
      semanticLabel: 'Cached',
    );
    debugFillPropertiesTest(
      icon,
      debugFillProperties,
    );

    testWidgets('renders icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: Icon(ZetaIcons.add_round)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('color value is correct', (WidgetTester tester) async {
      const Color iconColor = Colors.red;
      await tester.pumpWidget(const TestApp(home: Icon(ZetaIcons.add_round, color: iconColor)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, equals(iconColor));
    });

    testWidgets('applies sharp family to icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            children: [
              ZetaIcon(ZetaIcons.table),
              ZetaRoundedScope(
                rounded: false,
                child: ZetaIcon(ZetaIcons.table),
              ),
            ],
          ),
        ),
      );
      final iconFinderRound = find.byIcon(ZetaIcons.table_round);
      final iconFinderSharp = find.byIcon(ZetaIcons.table_sharp);

      expect(iconFinderRound, findsOneWidget);
      expect(iconFinderSharp, findsExactly(1));
    });
  });
  group('Dimensions Tests', () {
    testWidgets('applies correct size to icon', (WidgetTester tester) async {
      const double iconSize = 24;
      await tester.pumpWidget(const TestApp(home: Icon(ZetaIcons.add_round, size: iconSize)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final sizeOfIcon = tester.getSize(iconFinder);
      expect(sizeOfIcon.width, equals(iconSize));
      expect(sizeOfIcon.height, equals(iconSize));
    });
  });
  group('Styling Tests', () {
    testWidgets('applies correct font family to icon', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: Icon(ZetaIcons.add_round)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals(ZetaIcons.familyRound));
    });

    testWidgets('applies correct font family when rounded is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaRoundedScope(
            rounded: false,
            child: ZetaIcon(ZetaIcons.add),
          ),
        ),
      );
      final iconFinder = find.byIcon(ZetaIcons.add_sharp);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals(ZetaIcons.familySharp));
    });

    testWidgets('does not change fontFamily if specific rounded / sharp variant is requested',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaRoundedScope(
            rounded: false,
            child: Icon(ZetaIcons.add_round),
          ),
        ),
      );
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals(ZetaIcons.familyRound));
    });

    testWidgets('apply() sets round icon font', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: Builder(
            builder: (context) {
              return Icon(ZetaIcons.activity.apply(context));
            },
          ),
        ),
      );
      final iconFinder = find.byIcon(ZetaIcons.activity_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals(ZetaIcons.familyRound));
    });

    testWidgets('apply() uses rounded from context', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRoundedScope(
            rounded: false,
            child: Builder(
              builder: (context) {
                return Icon(ZetaIcons.activity.apply(context));
              },
            ),
          ),
        ),
      );
      final iconFinder = find.byIcon(ZetaIcons.activity_sharp);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals(ZetaIcons.familySharp));
    });

    testWidgets('apply() returns the same icon if not in ZetaIcons family', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaRoundedScope(
            rounded: false,
            child: Builder(
              builder: (context) {
                return Icon(Icons.abc.apply(context));
              },
            ),
          ),
        ),
      );
      final iconFinder = find.byIcon(Icons.abc);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals('MaterialIcons'));
    });
  });
  group('Interaction Tests', () {});
  group('Golden Tests', () {});
  group('Performance Tests', () {});
}
