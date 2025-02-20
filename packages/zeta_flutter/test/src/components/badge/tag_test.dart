import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  const String parentFolder = 'badge';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {});
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
  group('Dimensions Tests', () {});
  group('Styling Tests', () {});
  group('Interaction Tests', () {});
  group('Golden Tests', () {
    goldenTest(goldenFile, const ZetaTag.right(label: 'Tag', rounded: false), 'tag_right');
    goldenTest(goldenFile, const ZetaTag.left(label: 'Tag', rounded: true), 'tag_left');
  });
  group('Performance Tests', () {});
}
