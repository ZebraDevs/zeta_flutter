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
    for (final direction in ZetaTagDirection.values) {
      meetsAccessibilityGuidelinesTest(
        ZetaTag(direction: direction, label: 'Label'),
      );
    }
  });
  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Test label"',
      'rounded': 'false',
      'direction': 'left',
    };
    debugFillPropertiesTest(
      const ZetaTag(
        label: 'Test label',
        rounded: false,
      ),
      debugFillProperties,
    );

    testWidgets('Initializes right with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTag.right(label: 'Tag', rounded: false),
        ),
      );

      expect(find.text('Tag'), findsOneWidget);
    });
    testWidgets('Initializes left with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTag.left(label: 'Tag', rounded: true),
        ),
      );
      expect(find.byType(ZetaTag), findsOneWidget);
    });
  });
  group('Dimensions Tests', () {
    testWidgets('Has correct dimensions', (WidgetTester tester) async {
      await loadFonts();
      const leftKey = Key('left');
      const rightKey = Key('right');
      await tester.pumpWidget(
        const TestApp(
          home: Column(
            children: [
              // Ignored for testing purposes.
              // ignore: avoid_redundant_argument_values
              ZetaTag(label: 'Tag', direction: ZetaTagDirection.left, key: leftKey),
              ZetaTag(label: 'Tag', direction: ZetaTagDirection.right, key: rightKey),
            ],
          ),
        ),
      );
      final Finder leftTag = find.byKey(leftKey);
      final Finder rightTag = find.byKey(rightKey);

      expect(leftTag, findsOneWidget);
      expect(rightTag, findsOneWidget);

      final RenderBox leftBox = tester.renderObject<RenderBox>(leftTag);
      final RenderBox rightBox = tester.renderObject<RenderBox>(rightTag);

      expect(leftBox.size.width.round(), inInclusiveRange(53, 55)); // Width may vary slightly based on font rendering
      expect(leftBox.size.height, 32);
      expect(rightBox.size.width.round(), inInclusiveRange(53, 55)); // Width may vary slightly based on font rendering
      expect(rightBox.size.height, 32);

      expect(leftBox.size.width, rightBox.size.width);
      expect(leftBox.size.height, rightBox.size.height);
    });
  });
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, const ZetaTag.right(label: 'Tag', rounded: false), 'tag_right');
    goldenTest(goldenFile, const ZetaTag.left(label: 'Tag', rounded: true), 'tag_left');
  });
  group('Performance Tests', () {});
}
