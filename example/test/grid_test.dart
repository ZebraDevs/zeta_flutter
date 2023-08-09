import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_example/pages/grid_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'test_components.dart';

void main() {
  testWidgets('Grid component default desktop', (tester) async {
    await tester.pumpWidget(
      TestWidget(widget: ZetaGrid(children: List.generate(20, (index) => GridItem(key: Key(index.toString()))))),
    );

    final item0 = tester.getCenter(find.byKey(const Key('0')));
    final item11 = tester.getCenter(find.byKey(const Key('11')));
    final item12 = tester.getCenter(find.byKey(const Key('12')));

    // First 12 items don't wrap - all grid items on same row
    expect(item0.dy, item11.dy);

    // Items wrap after 12th item
    expect(item0.dy != item12.dy, true);
  });

  testWidgets('Grid component default mobile', (tester) async {
    await tester.pumpWidget(
      TestWidget(
        widget: ZetaGrid(children: List.generate(20, (index) => GridItem(key: Key(index.toString())))),
        screenSize: const Size(400, 600),
      ),
    );

    final item0 = tester.getCenter(find.byKey(const Key('0')));
    final item1 = tester.getCenter(find.byKey(const Key('1')));
    final item2 = tester.getCenter(find.byKey(const Key('2')));

    // First 2 items are on same row
    expect(item0.dy, item1.dy);

    // Grid wraps at 2 columns
    expect(item1.dy == item2.dy, false);
  });
}
