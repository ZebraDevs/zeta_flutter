// Ignored for testing purposes
// ignore_for_file: avoid_redundant_argument_values

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
    for (final isBadge in [true, false]) {
      for (final status in ZetaPriorityPillStatus.values) {
        for (final size in ZetaPriorityPillSize.values) {
          meetsAccessibilityGuidelinesTest(
            ZetaPriorityPill(
              status: status,
              isBadge: isBadge,
              label: 'Label',
              size: size,
            ),
            testName: 'status: $status, isBadge: $isBadge, size: $size',
          );
        }
      }
    }
    // TODO(test): Consider adding customColor tests. Currently these fail as there is not logic for accessibillty with custom colors.
    // for (final isBadge in [true, false]) {
    //   for (final color in [
    //     const ZetaPrimitivesLight().blue,
    //     const ZetaPrimitivesLight().red,
    //     const ZetaPrimitivesLight().green,
    //     const ZetaPrimitivesLight().yellow,
    //     const ZetaPrimitivesLight().purple,
    //     const ZetaPrimitivesLight().orange,
    //     const ZetaPrimitivesLight().warm,
    //     const ZetaPrimitivesLight().cool,
    //     const ZetaPrimitivesLight().teal,
    //     const ZetaPrimitivesLight().pink,
    //   ]) {
    //     for (final size in ZetaPriorityPillSize.values) {
    //       meetsAccessibilityGuidelinesTest(
    //         ZetaPriorityPill(
    //           customColor: color,
    //           isBadge: isBadge,
    //           label: 'Label',
    //           size: size,
    //         ),
    //       );
    //     }
    //   }
    // }
  });
  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Test label"',
      'rounded': 'false',
      'isBadge': 'false',
      'index': '"1"',
      'customColor': const ZetaPrimitivesLight().blue.toString(),
      'status': 'urgent',
      'size': 'large',
    };
    debugFillPropertiesTest(
      ZetaPriorityPill(
        label: 'Test label',
        rounded: false,
        customColor: const ZetaPrimitivesLight().blue,
        index: '1',
      ),
      debugFillProperties,
    );

    testWidgets('Initializes with correct label and index', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(),
        ),
      );

      final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
      final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
      expect(zetaPriorityPill.rounded, null);
      expect(zetaPriorityPill.index, null);
      expect(zetaPriorityPill.isBadge, false);
      expect(zetaPriorityPill.customColor, null);
      expect(zetaPriorityPill.label, null);
      expect(zetaPriorityPill.size, ZetaPriorityPillSize.large);
      expect(zetaPriorityPill.status, ZetaPriorityPillStatus.urgent);

      expect(find.text('Urgent'), findsOneWidget);
      expect(find.text('U'), findsOneWidget);

      await expectLater(
        find.byType(ZetaPriorityPill),
        matchesGoldenFile(goldenFile.getFileUri('priority_pill_default')),
      );
    });
    testWidgets('High priority pill', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            status: ZetaPriorityPillStatus.high,
            index: '10',
            label: 'test label',
            rounded: false,
            size: ZetaPriorityPillSize.small,
          ),
        ),
      );

      final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
      final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
      expect(zetaPriorityPill.rounded, false);
      expect(zetaPriorityPill.index, '10');
      expect(zetaPriorityPill.isBadge, false);
      expect(zetaPriorityPill.status, ZetaPriorityPillStatus.high);
      expect(zetaPriorityPill.size, ZetaPriorityPillSize.small);

      expect(find.text('test label'), findsOneWidget);
    });
    testWidgets('Medium priority pill', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            status: ZetaPriorityPillStatus.medium,
            isBadge: true,
          ),
        ),
      );

      final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
      final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
      expect(zetaPriorityPill.status, ZetaPriorityPillStatus.medium);
      expect(zetaPriorityPill.isBadge, true);
    });
    testWidgets('Low priority pill', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            status: ZetaPriorityPillStatus.low,
            size: ZetaPriorityPillSize.small,
            isBadge: true,
          ),
        ),
      );

      final zetaPriorityPillFinder = find.byType(ZetaPriorityPill);
      final ZetaPriorityPill zetaPriorityPill = tester.firstWidget(zetaPriorityPillFinder);
      expect(zetaPriorityPill.status, ZetaPriorityPillStatus.low);
      expect(zetaPriorityPill.isBadge, true);
      expect(zetaPriorityPill.size, ZetaPriorityPillSize.small);
    });
  });
  group('Dimensions Tests', () {
    testWidgets('renders badge size large', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            size: ZetaPriorityPillSize.large,
            isBadge: true,
          ),
        ),
      );

      final finder = find.byType(ZetaPriorityPill);
      final size = tester.getSize(finder);

      expect(size.width, 28);
      expect(size.height, 28);
    });

    testWidgets('renders lozenge size large', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            size: ZetaPriorityPillSize.large,
            isBadge: false,
            status: ZetaPriorityPillStatus.urgent,
            label: 'Label',
          ),
        ),
      );

      final finder = find.byType(ZetaPriorityPill);
      final size = tester.getSize(finder);

      expect(size.width, inInclusiveRange(78, 80));
      expect(size.height, 28);
    });

    testWidgets('renders badge size small', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            size: ZetaPriorityPillSize.small,
            isBadge: true,
          ),
        ),
      );

      final finder = find.byType(ZetaPriorityPill);
      final size = tester.getSize(finder);

      expect(size.width, 20);
      expect(size.height, 20);
    });

    testWidgets('renders lozenge size small', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaPriorityPill(
            size: ZetaPriorityPillSize.small,
            isBadge: false,
            status: ZetaPriorityPillStatus.urgent,
            label: 'Label',
          ),
        ),
      );

      final finder = find.byType(ZetaPriorityPill);
      final size = tester.getSize(finder);

      expect(size.width, inInclusiveRange(60, 62));
      expect(size.height, 20);
    });
  });
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, const ZetaPriorityPill(), 'priority_pill_default');
    goldenTest(
      goldenFile,
      const ZetaPriorityPill(
        status: ZetaPriorityPillStatus.high,
        index: '10',
        label: 'test label',
        rounded: false,
        size: ZetaPriorityPillSize.small,
      ),
      'priority_pill_high',
    );
    goldenTest(
      goldenFile,
      const ZetaPriorityPill(
        status: ZetaPriorityPillStatus.medium,
        isBadge: true,
      ),
      'priority_pill_medium',
    );
    goldenTest(
      goldenFile,
      const ZetaPriorityPill(
        status: ZetaPriorityPillStatus.low,
        size: ZetaPriorityPillSize.small,
        isBadge: true,
      ),
      'priority_pill_low',
    );
  });
  group('Performance Tests', () {});
}
