import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/utils.dart';

void main() {
  group('Zeta Icon', () {
    testWidgets('renders icon correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaIcon(ZetaIcons.add_round)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('applies correct size to icon', (WidgetTester tester) async {
      const double iconSize = 24;
      await tester.pumpWidget(const TestApp(home: ZetaIcon(ZetaIcons.add_round, size: iconSize)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.size, equals(iconSize));
    });

    testWidgets('applies correct color to icon', (WidgetTester tester) async {
      const Color iconColor = Colors.red;
      await tester.pumpWidget(const TestApp(home: ZetaIcon(ZetaIcons.add_round, color: iconColor)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.color, equals(iconColor));
    });

    testWidgets('applies correct semantic label to icon', (WidgetTester tester) async {
      const String semanticLabel = 'Add Icon';
      await tester.pumpWidget(const TestApp(home: ZetaIcon(ZetaIcons.add_round, semanticLabel: semanticLabel)));
      final iconFinder = find.byIcon(ZetaIcons.add_round);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.semanticLabel, equals(semanticLabel));
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

    testWidgets('applies correct font family to icon', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaIcon(ZetaIcons.add_round)));
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
            child: ZetaIcon(ZetaIcons.add_round, rounded: false),
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
              return ZetaIcon(ZetaIcons.activity.apply(context));
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
                return ZetaIcon(ZetaIcons.activity.apply(context));
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
                return ZetaIcon(Icons.abc.apply(context));
              },
            ),
          ),
        ),
      );
      final iconFinder = find.byIcon(Icons.abc);
      final iconWidget = tester.widget<Icon>(iconFinder);
      expect(iconWidget.icon?.fontFamily, equals('MaterialIcons'));
    });

    testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
      final diagnostics = DiagnosticPropertiesBuilder();
      const ZetaIcon(
        ZetaIcons.cached,
        rounded: false,
        size: 10,
        semanticLabel: 'Cached',
      ).debugFillProperties(diagnostics);

      expect(diagnostics.finder('icon'), 'IconData(U+0E045)');
      expect(diagnostics.finder('rounded'), 'false');
      expect(diagnostics.finder('size'), '10.0');
      expect(diagnostics.finder('fill'), 'null');
      expect(diagnostics.finder('weight'), 'null');
      expect(diagnostics.finder('grade'), 'null');
      expect(diagnostics.finder('opticalSize'), 'null');
      expect(diagnostics.finder('color'), 'null');
      expect(diagnostics.finder('shadows'), 'null');
      expect(diagnostics.finder('semanticLabel'), '"Cached"');
      expect(diagnostics.finder('textDirection'), 'null');
      expect(diagnostics.finder('applyTextScaling'), 'null');
    });
  });
}
