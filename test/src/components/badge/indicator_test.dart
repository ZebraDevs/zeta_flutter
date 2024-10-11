import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaIndicator';
  const String parentFolder = 'badge';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {});
  group('$componentName Content Tests', () {
    final debugFillProperties = {
      'color': 'MaterialColor(primary value: Color(0xffff9800))',
      'icon': 'IconData(U+F04B6)',
      'inverse': 'true',
      'rounded': 'false',
      'size': 'ZetaWidgetSize.small',
      'type': 'ZetaIndicatorType.icon',
      'value': '1',
    };
    debugFillPropertiesTest(
      const ZetaIndicator(
        color: Colors.orange,
        icon: Icons.abc,
        inverse: true,
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
      expect(indicator.inverse, false);
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
      expect(indicator1.inverse, false);
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
      expect(indicator.inverse, false);
      expect(indicator.color, null);
    });
    testWidgets('Icon constructor with values', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.icon(
            color: Colors.purple,
            icon: Icons.abc,
            inverse: true,
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
      expect(indicator.inverse, true);
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
      expect(indicator.inverse, false);
      expect(indicator.color, null);
    });
    testWidgets('Notification constructor with values', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaIndicator.notification(
            rounded: false,
            color: Colors.green,
            inverse: true,
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
      expect(indicator.inverse, true);
      expect(indicator.color, Colors.green);
    });
  });
  group('$componentName Dimensions Tests', () {});
  group('$componentName Styling Tests', () {});
  group('$componentName Interaction Tests', () {});
  group('$componentName Golden Tests', () {
    goldenTest(goldenFile, const ZetaIndicator(), ZetaIndicator, 'indicator_default');
    goldenTest(goldenFile, const ZetaIndicator.icon(), ZetaIndicator, 'indicator_icon_default');
    goldenTest(
      goldenFile,
      const ZetaIndicator.icon(
        color: Colors.purple,
        icon: Icons.abc,
        inverse: true,
        size: ZetaWidgetSize.medium,
      ),
      ZetaIndicator,
      'indicator_icon_values',
    );
    goldenTest(goldenFile, const ZetaIndicator.notification(), ZetaIndicator, 'indicator_notification_default');
    goldenTest(
      goldenFile,
      const ZetaIndicator.notification(
        rounded: false,
        color: Colors.green,
        inverse: true,
        size: ZetaWidgetSize.small,
        value: 1,
      ),
      ZetaIndicator,
      'indicator_notification_values',
    );
  });
  group('$componentName Performance Tests', () {});
}
