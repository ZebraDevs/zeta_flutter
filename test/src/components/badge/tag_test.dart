import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const goldenFile = GoldenFinder(component: 'badge');

  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });
  group('ZetaTag', () {
    testWidgets('Initializes right with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTag.right(label: 'Tag', rounded: false),
        ),
      );

      expect(find.text('Tag'), findsOneWidget);

      await expectLater(
        find.byType(ZetaTag),
        matchesGoldenFile(goldenFile.getFileUri('tag_right.png')),
      );
    });

    testWidgets('Initializes left with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaTag.left(label: 'Tag', rounded: true),
        ),
      );
      expect(find.byType(ZetaTag), findsOneWidget);

      await expectLater(
        find.byType(ZetaTag),
        matchesGoldenFile(goldenFile.getFileUri('tag_left.png')),
      );
    });
  });

  testWidgets('debugFillProperties works correctly', (WidgetTester tester) async {
    final diagnostics = DiagnosticPropertiesBuilder();
    const ZetaTag(
      label: 'Test label',
      rounded: false,
    ).debugFillProperties(diagnostics);

    expect(diagnostics.finder('label'), '"Test label"');
    expect(diagnostics.finder('rounded'), 'false');
    expect(diagnostics.finder('direction'), 'left');
  });
}
