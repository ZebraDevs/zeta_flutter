import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  group('ZetaButton Tests', () {
    testWidgets('Initializes with correct Label', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ZetaButton(
            onPressed: () {},
            label: 'Test Button',
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });
  });

  testWidgets('Triggers callback on tap', (WidgetTester tester) async {
    bool callbackTriggered = false;
    await tester.pumpWidget(
      TestWidget(
          widget: ZetaButton(
        onPressed: () => callbackTriggered = true,
        label: 'Test Button',
      )),
    );
    await tester.tap(find.byType(ZetaButton));
    await tester.pump();

    expect(callbackTriggered, isTrue);
  });
}
