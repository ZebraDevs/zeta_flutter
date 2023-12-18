import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  group('ZetaCheckbox Tests', () {
    testWidgets('Initializes with correct parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ZetaTag.right(
            label: 'Tag',
          ),
        ),
      );

      expect(find.text('Tag'), findsOneWidget);
    });

    testWidgets('ZetaTag handles direction correctly', (WidgetTester tester) async {
      const widgetLeft = TestWidget(
          widget: ZetaTag(
        label: 'Tag',
        direction: ZetaTagDirection.left,
      ));

      const widgetRight = TestWidget(
          widget: ZetaTag(
        label: 'Tag',
        direction: ZetaTagDirection.right,
      ));

      await tester.pumpWidget(widgetLeft);
      expect(find.byType(ZetaTag), findsOneWidget);

      await tester.pumpWidget(widgetRight);
      expect(find.byType(ZetaTag), findsOneWidget);
    });
  });
}
