import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('Initializes with correct label and index', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaPriorityPill(
          priority: 'High',
          index: 2,
        ),
      ),
    );
    expect(find.text('High'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });
}
