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
        ZetaStatusLabel(label: 'Label', status: status),
      );
    }
  });
  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Test label"',
      'rounded': 'false',
      'icon': 'IconData(U+F04B6)',
      'status': 'info',
    };
    debugFillPropertiesTest(
      const ZetaStatusLabel(
        label: 'Test label',
        rounded: false,
        icon: Icons.abc,
      ),
      debugFillProperties,
    );

    testWidgets('Initializes with correct properties', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusLabel(label: 'Test Label'),
        ),
      );
      expect(find.text('Test Label'), findsOneWidget);
    });

    testWidgets('Initializes with correct label and custom icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusLabel(
            label: 'Custom Icon',
            icon: Icons.person,
          ),
        ),
      );
      expect(find.text('Custom Icon'), findsOneWidget);
      expect(find.byIcon(Icons.person), findsOneWidget);
    });
  });
  group('Dimensions Tests', () {
    testWidgets('Has correct default dimensions', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusLabel(label: 'Label'),
        ),
      );
      final zetaStatusLabelFinder = find.byType(ZetaStatusLabel);
      final statusLabel = tester.widget<ZetaStatusLabel>(find.byType(ZetaStatusLabel));
      expect(statusLabel.icon, isNull);
      final RenderBox box = tester.renderObject(zetaStatusLabelFinder);
      expect(box.size.width.round(), inInclusiveRange(70, 72)); // Width may vary slightly based on font rendering
      expect(box.size.height, 28);
    });

    testWidgets('Has correct dimensions with custom icon', (WidgetTester tester) async {
      await loadFonts();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusLabel(label: 'Label', icon: ZetaIcons.star),
        ),
      );
      final statusLabel = tester.widget<ZetaStatusLabel>(find.byType(ZetaStatusLabel));
      expect(statusLabel.icon, ZetaIcons.star);
      final RenderBox box = tester.renderObject(find.byType(ZetaStatusLabel));
      expect(box.size.width.round(), inInclusiveRange(81, 84)); // Width may vary slightly based on font rendering
      expect(box.size.height, 28);
    });
  });
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, const ZetaStatusLabel(label: 'Test Label'), 'status_label_default');
    goldenTest(
      goldenFile,
      const ZetaStatusLabel(
        label: 'Custom Icon',
        icon: Icons.person,
      ),
      'status_label_custom',
    );
  });
  group('Performance Tests', () {});
}
