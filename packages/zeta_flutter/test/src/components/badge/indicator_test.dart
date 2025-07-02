// Ignored to test all values methodically
// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'badge';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    for (final type in ZetaIndicatorType.values) {
      for (final size in ZetaWidgetSize.values) {
        for (final value in [1, 10, 100]) {
          if (value != 1 && type == ZetaIndicatorType.icon) {
            continue; // Skip icon type for values other than 1
          }
          meetsAccessibilityGuidelinesTest(
            ZetaIndicator(
              type: type,
              size: size,
              icon: type == ZetaIndicatorType.icon ? ZetaIcons.star : null,
              value: type == ZetaIndicatorType.notification ? 1 : null,
            ),
            testName: '${type.name}-${size.name}-$value',
            beforeTest: (p0) async {
              await loadFonts();
            },
          );
        }
      }
    }
  });
  group('Content Tests', () {
    final debugFillProperties = {
      'color': Colors.orange.toString(),
      'icon': 'IconData(U+F04B6)',
      'rounded': 'false',
      'size': 'ZetaWidgetSize.small',
      'type': 'ZetaIndicatorType.icon',
      'value': '1',
    };
    debugFillPropertiesTest(
      const ZetaIndicator(
        color: Colors.orange,
        icon: Icons.abc,
        rounded: false,
        size: ZetaWidgetSize.small,
        type: ZetaIndicatorType.icon,
        value: 1,
      ),
      debugFillProperties,
    );

    testWidgets('Default constructor initializes with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaIndicator()));

      final zetaIndicatorFinder = find.byType(ZetaIndicator);
      final ZetaIndicator indicator = tester.firstWidget(zetaIndicatorFinder);

      expect(indicator.rounded, null);
      expect(indicator.type, ZetaIndicatorType.notification);
      expect(indicator.size, ZetaWidgetSize.large);
      expect(indicator.icon, null);
      expect(indicator.value, null);
      expect(indicator.color, null);
    });

    testWidgets('Copy with function works', (WidgetTester tester) async {
      const Key key1 = Key('1');
      const Key key2 = Key('2');

      const ZetaIndicator one = ZetaIndicator(key: key1);
      final ZetaIndicator two = one.copyWith(
        key: key2,
      );
      await tester.pumpWidget(TestApp(home: Column(children: [one, two])));

      final zetaIndicatorFinder1 = find.byKey(key1);
      final ZetaIndicator indicator1 = tester.firstWidget(zetaIndicatorFinder1);
      final zetaIndicatorFinder2 = find.byKey(key2);
      final ZetaIndicator indicator2 = tester.firstWidget(zetaIndicatorFinder2);

      expect(indicator1.rounded, null);
      expect(indicator1.type, ZetaIndicatorType.notification);
      expect(indicator1.size, ZetaWidgetSize.large);
      expect(indicator1.icon, null);
      expect(indicator1.value, null);
      expect(indicator1.color, null);

      expect(indicator2.rounded, null);
    });
    testWidgets('Icon constructor initializes with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaIndicator.icon()));

      final zetaIndicatorFinder = find.byType(ZetaIndicator);
      final ZetaIndicator indicator = tester.firstWidget(zetaIndicatorFinder);

      expect(indicator.rounded, null);
      expect(indicator.type, ZetaIndicatorType.icon);
      expect(indicator.size, ZetaWidgetSize.large);
      expect(indicator.icon, null);
      expect(indicator.value, null);
      expect(indicator.color, null);
    });
    testWidgets('Icon constructor with values', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.icon(
            color: Colors.purple,
            icon: Icons.abc,
            size: ZetaWidgetSize.medium,
          ),
        ),
      );

      final zetaIndicatorFinder = find.byType(ZetaIndicator);
      final ZetaIndicator indicator = tester.firstWidget(zetaIndicatorFinder);

      expect(indicator.rounded, null);
      expect(indicator.type, ZetaIndicatorType.icon);
      expect(indicator.size, ZetaWidgetSize.medium);
      expect(indicator.icon, Icons.abc);
      expect(indicator.value, null);
      expect(indicator.color, Colors.purple);
    });
    testWidgets('Notification constructor initializes with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaIndicator.notification()));

      final zetaIndicatorFinder = find.byType(ZetaIndicator);
      final ZetaIndicator indicator = tester.firstWidget(zetaIndicatorFinder);

      expect(indicator.rounded, null);
      expect(indicator.type, ZetaIndicatorType.notification);
      expect(indicator.size, ZetaWidgetSize.large);
      expect(indicator.icon, null);
      expect(indicator.value, null);
      expect(indicator.color, null);
    });
    testWidgets('Notification constructor with values', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            rounded: false,
            color: Colors.green,
            size: ZetaWidgetSize.small,
            value: 1,
          ),
        ),
      );

      final zetaIndicatorFinder = find.byType(ZetaIndicator);
      final ZetaIndicator indicator = tester.firstWidget(zetaIndicatorFinder);

      expect(indicator.rounded, false);
      expect(indicator.type, ZetaIndicatorType.notification);
      expect(indicator.size, ZetaWidgetSize.small);
      expect(indicator.icon, null);
      expect(indicator.value, 1);
      expect(indicator.color, Colors.green);
    });
  });
  group('Dimensions Tests', () {
    testWidgets('icon, sets the small dimensions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.icon(
            size: ZetaWidgetSize.small,
            icon: ZetaIcons.star,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 12);
      expect(size.height, 12);
    });

    testWidgets('icon, sets the medium dimensions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.icon(
            size: ZetaWidgetSize.medium,
            icon: ZetaIcons.star,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 16);
      expect(size.height, 16);
    });

    testWidgets('icon, sets the large dimensions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.icon(
            size: ZetaWidgetSize.large,
            icon: ZetaIcons.star,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 24);
      expect(size.height, 24);
    });

    testWidgets('notification, sets the small dimensions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            size: ZetaWidgetSize.small,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 12);
      expect(size.height, 12);
    });

    testWidgets('notification, sets the medium dimensions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            size: ZetaWidgetSize.medium,
            value: 1,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 16);
      expect(size.height, 16);
    });

    testWidgets('notification, sets the large dimensions correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            size: ZetaWidgetSize.large,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 28);
      expect(size.height, 16);
    });
  });
  group('Styling Tests', () {
    testWidgets('notification, applies the correct style based on 1 digit', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            size: ZetaWidgetSize.medium,
            value: 5,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 16);
      expect(size.height, 16);
    });

    testWidgets('notification, applies the correct style based on 2 digits', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            size: ZetaWidgetSize.medium,
            value: 55,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 28);
      expect(size.height, 16);
    });

    testWidgets('notification, applies the correct style based on 3 digits and caps at 99+',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            size: ZetaWidgetSize.medium,
            value: 555,
          ),
        ),
      );

      final finder = find.byType(ZetaIndicator);
      final size = tester.getSize(finder);

      expect(size.width, 28);
      expect(size.height, 16);

      // Check that the displayed text is '99+'
      final textFinder = find.descendant(
        of: finder,
        matching: find.byType(Text),
      );
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.data, equals('99+'));
    });
  });
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, const ZetaIndicator(), 'indicator_default');
    goldenTest(goldenFile, const ZetaIndicator.icon(), 'indicator_icon_default');
    goldenTest(
      goldenFile,
      const ZetaIndicator.icon(
        color: Colors.purple,
        icon: Icons.abc,
        size: ZetaWidgetSize.medium,
      ),
      'indicator_icon_values',
    );
    goldenTest(goldenFile, const ZetaIndicator.notification(), 'indicator_notification_default');
    goldenTest(
      goldenFile,
      const ZetaIndicator.notification(value: 3, size: ZetaWidgetSize.medium),
      'indicator_notification_with_value',
    );
    goldenTest(
      goldenFile,
      const ZetaIndicator.notification(
        rounded: false,
        color: Colors.green,
        size: ZetaWidgetSize.small,
        value: 1,
      ),
      'indicator_notification_values',
    );
  });
  group('Performance Tests', () {});
}
