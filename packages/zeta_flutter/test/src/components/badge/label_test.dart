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
    for (final status in ZetaWidgetStatus.values) {
      meetsAccessibilityGuidelinesTest(
        ZetaLabel(label: 'Label', status: status),
      );
    }
  });
  group('Content Tests', () {
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
  group('Dimensions Tests', () {
    testWidgets('Label has expected width and height', (WidgetTester tester) async {
      await loadFonts();

      await tester.pumpWidget(
        const TestApp(
          home: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ZetaLabel(
                  label: 'Label',
                  status: ZetaWidgetStatus.negative,
                ),
              ],
            ),
          ),
        ),
      );

      final zetaLabelFinder = find.byType(ZetaLabel);

      final RenderBox box = tester.renderObject(zetaLabelFinder);

      expect(box.size.width.round(), inInclusiveRange(37, 39)); // Width may vary slightly based on font rendering
      expect(box.size.height, 16);
    });
  });
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, const ZetaLabel(label: 'Test Label'), 'label_default');
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.positive),
      'label_positive',
    );
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.warning),
      'label_warning',
    );
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.negative),
      'label_negative',
    );
    goldenTest(
      goldenFile,
      const ZetaLabel(label: 'Test Label', status: ZetaWidgetStatus.neutral),
      'label_neutral',
    );
    goldenTest(goldenFile, const ZetaLabel(label: 'Test Label'), 'label_dark', themeMode: ThemeMode.dark);
    goldenTest(goldenFile, const ZetaLabel(label: 'Test Label', rounded: false), 'label_sharp');
  });
  group('Performance Tests', () {});
}
