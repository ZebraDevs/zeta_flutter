import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  group('ZetaFAB Tests', () {
    testWidgets('Initializes with correct', (WidgetTester tester) async {
      final scrollController = ScrollController();
      await tester.pumpWidget(TestWidget(
          widget: ZetaFAB(
        scrollController: scrollController,
        label: 'Label',
      )));

      expect(find.byType(ZetaFAB), findsOneWidget);
    });

    testWidgets('OnPressed callback', (WidgetTester tester) async {
      bool isPressed = false;
      final scrollController = ScrollController();

      await tester.pumpWidget(TestWidget(
          widget: ZetaFAB(
        scrollController: scrollController,
        label: 'Label',
        onPressed: () => isPressed = true,
      )));

      await tester.tap(find.byType(ZetaFAB));
      await tester.pumpAndSettle();
      expect(isPressed, isTrue);
    });
  });

  testWidgets('Icon Test', (WidgetTester tester) async {
    final scrollController = ScrollController();
    await tester.pumpWidget(TestWidget(
        widget: ZetaFAB(
      scrollController: scrollController,
      label: 'Label',
    )));
    expect(find.byIcon(ZetaIcons.add_round), findsOneWidget);
  });
}
