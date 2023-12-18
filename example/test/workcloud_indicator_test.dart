import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  group('ZetaWorkcloud', () {
    testWidgets('ZetaWorkcloud creates status badge', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ZetaWorkcloudIndicator.status(label: 'Test Label'),
        ),
      );
      expect(find.byType(ZetaWorkcloudIndicator), findsOneWidget);
    });
  });

  testWidgets('ZetaWorkcloud creates priority pill', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaWorkcloudIndicator.priorityPill(index: '1'),
      ),
    );
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('ZetaWorkcloud custom colors', (WidgetTester tester) async {
    final customColor = ZetaWidgetColor(backgroundColor: Colors.pink, foregroundColor: Colors.pink);
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaWorkcloudIndicator.priorityPill(
          index: '1',
          priorityType: ZetaWorkcloudIndicatorType.custom,
          customColors: customColor,
        ),
      ),
    );
    final container = tester.widget<Container>(find.byType(Container).first);
    expect((container.decoration as BoxDecoration).color, equals(Colors.pink));
  });
}
