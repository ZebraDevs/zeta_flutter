// ignore_for_file: avoid_relative_lib_imports

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../example/lib/pages/grid_example.dart';
import '../example/widgetbook/utils/zebra.dart';

void main() {
  group('Grid', () {
    testWidgets('Grid component default desktop', (tester) async {
      await tester.pumpWidget(
        TestWidget(widget: ZetaGrid(children: List.generate(20, (index) => GridItem(key: Key(index.toString()))))),
      );

      final gridColumnFinder = find.byType(GridItem);
      final item0 = tester.getCenter(find.byKey(const Key('0')));
      final item11 = tester.getCenter(find.byKey(const Key('11')));

      // By default, only render 12 columns
      expect(gridColumnFinder, findsNWidgets(12));

      // No wrap - all grid items on same row
      expect(item0.dy, item11.dy);
    });

    testWidgets('Grid component default mobile', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ZetaGrid(children: List.generate(20, (index) => GridItem(key: Key(index.toString())))),
          screenSize: Zebra.ec50,
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
  });

  group('Spacing', () {
    const Widget testChild = Text('Item');
    const Key control = Key('control');

    testWidgets('Square', (tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: Column(
            children: [
              const SizedBox(key: Key('1'), child: ZetaSpacing(size: x1, child: testChild)),
              const SizedBox(key: Key('2'), child: ZetaSpacing.square(size: x1, child: testChild)),
              SizedBox(key: const Key('3'), child: testChild.square(x1)),
              SizedBox(key: const Key('4'), child: Padding(padding: x1.square, child: testChild)),
              const SizedBox(key: control, child: Padding(padding: EdgeInsets.all(4), child: testChild))
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.squish(size: x1, child: testChild)),
              SizedBox(key: const Key('2'), child: testChild.squish(x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: x1.squish, child: testChild)),
              const SizedBox(key: control, child: Padding(padding: EdgeInsets.symmetric(vertical: 4), child: testChild))
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.stack(size: x1, child: testChild)),
              SizedBox(key: const Key('2'), child: testChild.stack(x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: x1.stack, child: testChild)),
              const SizedBox(key: control, child: Padding(padding: EdgeInsets.only(bottom: 4), child: testChild))
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.inline(size: x1, child: testChild)),
              SizedBox(key: const Key('2'), child: testChild.inline(x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: x1.inline, child: testChild)),
              const SizedBox(
                key: control,
                child: Padding(padding: EdgeInsetsDirectional.only(start: 4, end: 4), child: testChild),
              )
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.inlineStart(size: x1, child: testChild)),
              SizedBox(key: const Key('2'), child: testChild.inlineStart(x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: x1.inlineStart, child: testChild)),
              const SizedBox(
                key: control,
                child: Padding(padding: EdgeInsetsDirectional.only(start: 4), child: testChild),
              )
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.inlineEnd(size: x1, child: testChild)),
              SizedBox(key: const Key('2'), child: testChild.inlineEnd(x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: x1.inlineEnd, child: testChild)),
              const SizedBox(
                key: control,
                child: Padding(padding: EdgeInsetsDirectional.only(end: 4), child: testChild),
              )
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
  });
}

class TestWidget extends StatelessWidget {
  final Device screenSize;
  final Widget widget;

  const TestWidget({required this.widget, this.screenSize = Desktop.desktop1080p, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: screenSize.resolution.logicalSize.width,
          height: screenSize.resolution.logicalSize.height,
          child: SingleChildScrollView(child: widget),
        ),
      ),
    );
  }
}
