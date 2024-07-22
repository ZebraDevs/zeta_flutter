import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';

void main() {
  testWidgets('ZetaAccordion expands and collapses correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const TestApp(
        home: ZetaAccordion(
          title: 'Accordion Title',
          child: Text('Accordion Content'),
        ),
      ),
    );

    // Verify that the accordion is initially collapsed
    final Finder accordionContent = find.byType(SizeTransition);
    expect(accordionContent, findsOneWidget);

    final SizeTransition sizeTransition = tester.widget(accordionContent);
    expect(sizeTransition.sizeFactor.value, 0);

    // Tap on the accordion to expand it
    await tester.tap(find.text('Accordion Title'));
    await tester.pumpAndSettle();

    // Verify that the accordion is now expanded
    expect(sizeTransition.sizeFactor.value, 1);

    // Tap on the accordion again to collapse it
    await tester.tap(find.text('Accordion Title'));
    await tester.pumpAndSettle();

    expect(sizeTransition.sizeFactor.value, 0);
  });

  testWidgets('ZetaAccordion changes isOpen property correctly', (WidgetTester tester) async {
    bool isOpen = false;
    StateSetter? setState;

    await tester.pumpWidget(
      TestApp(
        home: StatefulBuilder(
          builder: (context, setState2) {
            setState = setState2;
            return ZetaAccordion(
              title: 'Accordion Title',
              isOpen: isOpen,
              child: const Text('Accordion Content'),
            );
          },
        ),
      ),
    );

    // Verify that the accordion is initially closed
    final Finder accordionContent = find.byType(SizeTransition);
    expect(accordionContent, findsOneWidget);

    final SizeTransition sizeTransition = tester.widget(accordionContent);
    expect(sizeTransition.sizeFactor.value, 0);

    // Change isOpen property to true
    setState?.call(() => isOpen = true);

    await tester.pumpAndSettle();

    // Verify that the accordion is now open
    expect(sizeTransition.sizeFactor.value, 1);

    // Change isOpen property to false
    setState?.call(() => isOpen = false);

    await tester.pumpAndSettle();

    // Verify that the accordion is now closed
    expect(sizeTransition.sizeFactor.value, 0);
  });
}
