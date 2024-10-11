import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String componentName = 'ZetaTag';
  const String parentFolder = 'badge';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('$componentName Accessibility Tests', () {});
  group('$componentName Content Tests', () {
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
  group('$componentName Dimensions Tests', () {});
  group('$componentName Styling Tests', () {});
  group('$componentName Interaction Tests', () {});
  group('$componentName Golden Tests', () {
    goldenTest(goldenFile, const ZetaTag.right(label: 'Tag', rounded: false), ZetaTag, 'tag_right');
    goldenTest(goldenFile, const ZetaTag.left(label: 'Tag', rounded: true), ZetaTag, 'tag_left');
  });
  group('$componentName Performance Tests', () {});
}
