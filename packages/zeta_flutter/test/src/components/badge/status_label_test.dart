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
  group('Dimensions Tests', () {});
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
