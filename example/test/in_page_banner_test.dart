import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:flutter/material.dart';

import 'test_components.dart';

void main() {
  group('ZetaInPageBanner Tests', () {
    testWidgets('ZetaInPageBanner creation', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
            widget: ZetaInPageBanner(
          content: Text('Test'),
        )),
      );

      expect(find.byType(ZetaInPageBanner), findsOneWidget);
    });
  });

  testWidgets('ZetaInPageBanner displays content text', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
          widget: ZetaInPageBanner(
        content: Text('Test'),
      )),
    );

    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('ZetaInPageBanner shows/hides \'close icon\' correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
          widget: ZetaInPageBanner(
        content: Text('Test'),
        onClose: () {},
      )),
    );
    expect(find.byIcon(ZetaIcons.close_round), findsOneWidget);

    await tester.pumpWidget(
      TestWidget(
          widget: ZetaInPageBanner(
        content: Text('Test'),
      )),
    );
    expect(find.byIcon(ZetaIcons.close_sharp), findsNothing);
  });

  testWidgets('ZetaInPageBanner button callbacks work', (WidgetTester tester) async {
    bool onPressed = false;
    final key = GlobalKey();
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaInPageBanner(
          content: Text('Test'),
          actions: [
            ZetaButton(
              label: 'Test button',
              onPressed: () => onPressed = true,
              key: key,
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byKey(key));
    await tester.pumpAndSettle();
    expect(onPressed, isTrue);
  });

  testWidgets('ZetaInPageBanner \'close\' icon tap test', (WidgetTester tester) async {
    bool closeIconIsTapped = false;
    await tester.pumpWidget(
      TestWidget(
          widget: ZetaInPageBanner(
        onClose: () => closeIconIsTapped = true,
        content: Text('Test'),
      )),
    );
    final closeIcon = find.byIcon(ZetaIcons.close_round);
    await tester.tap(closeIcon);
    await tester.pump();
    expect(closeIconIsTapped, isTrue);
  });
}
