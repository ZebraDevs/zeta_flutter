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
    final testUri = Uri.parse(getCurrentPath('badge'));
    goldenFileComparator = TolerantComparator(testUri, tolerance: 0.01);
  });
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

    await expectLater(
      find.byType(ZetaIndicator),
      matchesGoldenFile(join(getCurrentPath('badge'), 'indicator_default.png')),
    );
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

    await expectLater(
      find.byType(ZetaIndicator),
      matchesGoldenFile(join(getCurrentPath('badge'), 'indicator_icon_default.png')),
    );
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

    await expectLater(
      find.byType(ZetaIndicator),
      matchesGoldenFile(join(getCurrentPath('badge'), 'indicator_icon_values.png')),
    );
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

    await expectLater(
      find.byType(ZetaIndicator),
      matchesGoldenFile(join(getCurrentPath('badge'), 'indicator_notification_default.png')),
    );
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

    await expectLater(
      find.byType(ZetaIndicator),
      matchesGoldenFile(join(getCurrentPath('badge'), 'indicator_notification_values.png')),
    );
  });
  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaIndicator(
      color: Colors.orange,
      icon: Icons.abc,
      inverse: true,
      rounded: false,
      size: ZetaWidgetSize.small,
      type: ZetaIndicatorType.icon,
      value: 1,
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('color'), 'MaterialColor(primary value: Color(0xffff9800))');
    expect(diagnostics.finder('icon'), 'IconData(U+F04B6)');
    expect(diagnostics.finder('inverse'), 'true');
    expect(diagnostics.finder('rounded'), 'false');
    expect(diagnostics.finder('size'), 'ZetaWidgetSize.small');
    expect(diagnostics.finder('type'), 'ZetaIndicatorType.icon');
    expect(diagnostics.finder('value'), '1');
  });
}
