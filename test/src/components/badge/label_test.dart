import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaLabel';
  const String parentFolder = 'badge';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {});
  group('$componentName Content Tests', () {
    final debugFillProperties = {
      'label': '"Test label"',
      'status': 'positive',
      'rounded': 'false',
    };
    debugFillPropertiesTest(
      const ZetaLabel(
        label: 'Test label',
        rounded: false,
        status: ZetaWidgetStatus.positive,
      ),
      debugFillProperties,
    );

    testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label')));

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.rounded, null);
      expect(label.label, 'Test Label');
      expect(label.status, ZetaWidgetStatus.info);
    });

    testWidgets('Positive status', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.positive)));

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.status, ZetaWidgetStatus.positive);
    });

    testWidgets('Warning status', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.warning)));

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.status, ZetaWidgetStatus.warning);
    });
    testWidgets('Negative status', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.negative)));

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.status, ZetaWidgetStatus.negative);
    });
    testWidgets('Neutral status', (WidgetTester tester) async {
      await tester.pumpWidget(const TestApp(home: ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.neutral)));

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.status, ZetaWidgetStatus.neutral);
    });

    testWidgets('Dark mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          themeMode: ThemeMode.dark,
          home: ZetaLabel(label: 'Test Label'),
        ),
      );

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.status, ZetaWidgetStatus.info);
    });

    testWidgets('Sharp', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(home: ZetaLabel(label: 'Test Label', rounded: false)),
      );

      final zetaBadgeFinder = find.byType(ZetaLabel);
      final ZetaLabel label = tester.firstWidget(zetaBadgeFinder);

      expect(label.rounded, false);
    });
  });
  group('$componentName Dimensions Tests', () {});
  group('$componentName Styling Tests', () {});
  group('$componentName Interaction Tests', () {});
  group('$componentName Golden Tests', () {
    goldenTest(goldenFile, const ZetaLabel(label: 'Test Label'), ZetaLabel, 'label_default');
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.positive),
      ZetaLabel,
      'label_positive',
    );
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.warning),
      ZetaLabel,
      'label_warning',
    );
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.negative),
      ZetaLabel,
      'label_negative',
    );
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.neutral),
      ZetaLabel,
      'label_neutral',
    );
    goldenTest(goldenFile, const ZetaLabel(label: 'Test Label'), ZetaLabel, 'label_dark', themeMode: ThemeMode.dark);
    goldenTest(goldenFile, const ZetaLabel(label: 'Test Label', rounded: false), ZetaLabel, 'label_sharp');
  });
  group('$componentName Performance Tests', () {});
}
