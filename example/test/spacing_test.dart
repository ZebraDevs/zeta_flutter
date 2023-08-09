import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'test_components.dart';

void main() {
  const Widget testChild = Text('Item');
  const Key control = Key('control');

  testWidgets('Square', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Column(
          children: [
            const SizedBox(key: Key('1'), child: ZetaSpacing(testChild, size: Dimensions.x1)),
            const SizedBox(
              key: Key('2'),
              child: ZetaSpacing.square(testChild, size: Dimensions.x1),
            ),
            SizedBox(key: const Key('3'), child: testChild.square(Dimensions.x1)),
            SizedBox(key: const Key('4'), child: Padding(padding: Dimensions.x1.square, child: testChild)),
            const SizedBox(
              key: control,
              child: Padding(padding: EdgeInsets.all(4), child: testChild),
            ),
          ],
        ),
      ),
    );

    final item1 = tester.getSize(find.byKey(const Key('1')));
    final item2 = tester.getSize(find.byKey(const Key('2')));
    final item3 = tester.getSize(find.byKey(const Key('3')));
    final item4 = tester.getSize(find.byKey(const Key('4')));
    final controlItem = tester.getSize(find.byKey(control));

    // Test all spacing methods return same size widget
    expect(item1, item2);
    expect(item2, item3);
    expect(item3, item4);

    // Test spacing component against known correct control item
    expect(item1, controlItem);
  });
  testWidgets('Squish', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Column(
          children: [
            const SizedBox(key: Key('1'), child: ZetaSpacing.squish(testChild, size: Dimensions.x1)),
            SizedBox(key: const Key('2'), child: testChild.squish(Dimensions.x1)),
            SizedBox(key: const Key('3'), child: Padding(padding: Dimensions.x1.squish, child: testChild)),
            const SizedBox(
              key: control,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 4), child: testChild),
            ),
          ],
        ),
      ),
    );

    final item1 = tester.getSize(find.byKey(const Key('1')));
    final item2 = tester.getSize(find.byKey(const Key('2')));
    final item3 = tester.getSize(find.byKey(const Key('3')));
    final controlItem = tester.getSize(find.byKey(control));

    // Test all spacing methods return same size widget
    expect(item1, item2);
    expect(item2, item3);

    // Test spacing component against known correct control item
    expect(item1, controlItem);
  });

  testWidgets('Stack', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Column(
          children: [
            const SizedBox(key: Key('1'), child: ZetaSpacing.stack(testChild, size: Dimensions.x1)),
            SizedBox(key: const Key('2'), child: testChild.stack(Dimensions.x1)),
            SizedBox(key: const Key('3'), child: Padding(padding: Dimensions.x1.stack, child: testChild)),
            const SizedBox(key: control, child: Padding(padding: EdgeInsets.only(bottom: 4), child: testChild)),
          ],
        ),
      ),
    );

    final item1 = tester.getSize(find.byKey(const Key('1')));
    final item2 = tester.getSize(find.byKey(const Key('2')));
    final item3 = tester.getSize(find.byKey(const Key('3')));
    final controlItem = tester.getSize(find.byKey(control));

    // Test all spacing methods return same size widget
    expect(item1, item2);
    expect(item2, item3);

    // Test spacing component against known correct control item
    expect(item1, controlItem);
  });
  testWidgets('Inline', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Column(
          children: [
            const SizedBox(key: Key('1'), child: ZetaSpacing.inline(testChild, size: Dimensions.x1)),
            SizedBox(key: const Key('2'), child: testChild.inline(Dimensions.x1)),
            SizedBox(key: const Key('3'), child: Padding(padding: Dimensions.x1.inline, child: testChild)),
            const SizedBox(
              key: control,
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: testChild),
            ),
          ],
        ),
      ),
    );

    final item1 = tester.getSize(find.byKey(const Key('1')));
    final item2 = tester.getSize(find.byKey(const Key('2')));
    final item3 = tester.getSize(find.byKey(const Key('3')));
    final controlItem = tester.getSize(find.byKey(control));

    // Test all spacing methods return same size widget
    expect(item1, item2);
    expect(item2, item3);

    // Test spacing component against known correct control item
    expect(item1, controlItem);
  });
  testWidgets('Inline Start', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Column(
          children: [
            const SizedBox(key: Key('1'), child: ZetaSpacing.inlineStart(testChild, size: Dimensions.x1)),
            SizedBox(key: const Key('2'), child: testChild.inlineStart(Dimensions.x1)),
            SizedBox(key: const Key('3'), child: Padding(padding: Dimensions.x1.inlineStart, child: testChild)),
            const SizedBox(
              key: control,
              child: Padding(padding: EdgeInsetsDirectional.only(start: 4), child: testChild),
            ),
          ],
        ),
      ),
    );

    final item1 = tester.getSize(find.byKey(const Key('1')));
    final item2 = tester.getSize(find.byKey(const Key('2')));
    final item3 = tester.getSize(find.byKey(const Key('3')));
    final controlItem = tester.getSize(find.byKey(control));

    // Test all spacing methods return same size widget
    expect(item1, item2);
    expect(item2, item3);

    // Test spacing component against known correct control item
    expect(item1, controlItem);
  });
  testWidgets('Inline end', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: Column(
          children: [
            const SizedBox(key: Key('1'), child: ZetaSpacing.inlineEnd(testChild, size: Dimensions.x1)),
            SizedBox(key: const Key('2'), child: testChild.inlineEnd(Dimensions.x1)),
            SizedBox(key: const Key('3'), child: Padding(padding: Dimensions.x1.inlineEnd, child: testChild)),
            const SizedBox(
              key: control,
              child: Padding(padding: EdgeInsetsDirectional.only(end: 4), child: testChild),
            ),
          ],
        ),
      ),
    );

    final item1 = tester.getSize(find.byKey(const Key('1')));
    final item2 = tester.getSize(find.byKey(const Key('2')));
    final item3 = tester.getSize(find.byKey(const Key('3')));
    final controlItem = tester.getSize(find.byKey(control));

    // Test all spacing methods return same size widget
    expect(item1, item2);
    expect(item2, item3);

    // Test spacing component against known correct control item
    expect(item1, controlItem);
  });
}
