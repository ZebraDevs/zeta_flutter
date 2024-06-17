import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'test_components.dart';

void main() {
  testWidgets('Global round inherited', (WidgetTester tester) async {
    GlobalKey key = GlobalKey();
    await tester.pumpWidget(
      TestWidget(
        rounded: true,
        widget: ZetaAccordion(
          key: key,
          title: 'Test Accordion',
          child: ZetaStatusLabel(label: 'Label'),
        ),
      ),
    );

    final zetaLabelFinder = find.byType(ZetaStatusLabel);

    expect(zetaLabelFinder, findsOneWidget);

    final childFinder = find.descendant(of: zetaLabelFinder, matching: find.byType(DecoratedBox));
    expect(childFinder, findsOneWidget);

    final DecoratedBox box = tester.firstWidget(childFinder);

    expect(box.decoration.runtimeType, BoxDecoration);
    expect((box.decoration as BoxDecoration).borderRadius, ZetaRadius.full);
    expect(Zeta.of(key.currentContext!).rounded, true);
  });

  testWidgets('Global sharp inherited', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestWidget(
        rounded: false,
        widget: ZetaAccordion(
          title: 'Test Accordion',
          child: ZetaStatusLabel(label: 'Label'),
        ),
      ),
    );

    final zetaLabelFinder = find.byType(ZetaStatusLabel);
    expect(zetaLabelFinder, findsOneWidget);

    final childFinder = find.descendant(of: zetaLabelFinder, matching: find.byType(DecoratedBox));
    expect(childFinder, findsOneWidget);

    final DecoratedBox box = tester.firstWidget(childFinder);

    expect(box.decoration.runtimeType, BoxDecoration);
    expect((box.decoration as BoxDecoration).borderRadius, ZetaRadius.none);
  });

  testWidgets('Global sharp, local round, not inherited', (WidgetTester tester) async {
    GlobalKey key = GlobalKey();
    await tester.pumpWidget(
      TestWidget(
        rounded: false,
        widget: ZetaAccordion(
          key: key,
          title: 'Test Accordion',
          child: ZetaStatusLabel(label: 'Label', rounded: true),
        ),
      ),
    );

    final zetaLabelFinder = find.byType(ZetaStatusLabel);

    expect(zetaLabelFinder, findsOneWidget);

    final childFinder = find.descendant(of: zetaLabelFinder, matching: find.byType(DecoratedBox));
    expect(childFinder, findsOneWidget);

    final DecoratedBox box = tester.firstWidget(childFinder);

    expect(box.decoration.runtimeType, BoxDecoration);
    expect((box.decoration as BoxDecoration).borderRadius, ZetaRadius.full);
  });

  testWidgets('Global sharp, scoped round inherited', (WidgetTester tester) async {
    final Key sharpKey = Key('sharp');
    final Key roundKey = Key('round');

    await tester.pumpWidget(
      TestWidget(
        rounded: false,
        widget: Column(
          children: [
            ZetaStatusLabel(label: 'Label', key: sharpKey),
            ZetaRoundedScope(
              rounded: true,
              child: ZetaAccordion(
                title: 'Test Accordion',
                child: ZetaStatusLabel(label: 'Label', key: roundKey),
              ),
            ),
          ],
        ),
      ),
    );

    final sharpLabelFinder = find.byKey(sharpKey);
    expect(sharpLabelFinder, findsOneWidget);

    final roundLabelFinder = find.byKey(roundKey);
    expect(roundLabelFinder, findsOneWidget);

    final sharpChildFinder = find.descendant(of: sharpLabelFinder, matching: find.byType(DecoratedBox));
    expect(sharpChildFinder, findsOneWidget);

    final roundChildFinder = find.descendant(of: roundLabelFinder, matching: find.byType(DecoratedBox));
    expect(roundChildFinder, findsOneWidget);

    final DecoratedBox sharpBox = tester.firstWidget(sharpChildFinder);
    final DecoratedBox roundBox = tester.firstWidget(roundChildFinder);

    expect(sharpBox.decoration.runtimeType, BoxDecoration);
    expect((sharpBox.decoration as BoxDecoration).borderRadius, ZetaRadius.none);

    expect(roundBox.decoration.runtimeType, BoxDecoration);
    expect((roundBox.decoration as BoxDecoration).borderRadius, ZetaRadius.full);
  });

  testWidgets('Global sharp, scoped round, scoped sharp inherited', (WidgetTester tester) async {
    final Key sharpKey = Key('sharp');
    final Key sharpKey2 = Key('round');

    await tester.pumpWidget(
      TestWidget(
        rounded: false,
        widget: Column(
          children: [
            ZetaStatusLabel(label: 'Label', key: sharpKey),
            ZetaRoundedScope(
              rounded: true,
              child: ZetaAccordion(
                title: 'Test Accordion',
                child: ZetaRoundedScope(rounded: false, child: ZetaStatusLabel(label: 'Label', key: sharpKey2)),
              ),
            ),
          ],
        ),
      ),
    );

    final sharpLabelFinder = find.byKey(sharpKey);
    expect(sharpLabelFinder, findsOneWidget);

    final roundLabelFinder = find.byKey(sharpKey2);
    expect(roundLabelFinder, findsOneWidget);

    final sharpChildFinder = find.descendant(of: sharpLabelFinder, matching: find.byType(DecoratedBox));
    expect(sharpChildFinder, findsOneWidget);

    final roundChildFinder = find.descendant(of: roundLabelFinder, matching: find.byType(DecoratedBox));
    expect(roundChildFinder, findsOneWidget);

    final DecoratedBox sharpBox = tester.firstWidget(sharpChildFinder);
    final DecoratedBox roundBox = tester.firstWidget(roundChildFinder);

    expect(sharpBox.decoration.runtimeType, BoxDecoration);
    expect((sharpBox.decoration as BoxDecoration).borderRadius, ZetaRadius.none);

    expect(roundBox.decoration.runtimeType, BoxDecoration);
    expect((roundBox.decoration as BoxDecoration).borderRadius, ZetaRadius.none);
  });
}
