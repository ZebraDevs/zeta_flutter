// ignore_for_file: avoid_relative_lib_imports,  avoid-top-level-members-in-tests, no-magic-number, prefer-moving-to-variable
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../lib/pages/grid_example.dart';
import '../widgetbook/utils/zebra.dart';

void main() {
  group('Grid', () {
    testWidgets('Grid component default desktop', (tester) async {
      await tester.pumpWidget(
        TestWidget(widget: ZetaGrid(children: List.generate(12, (index) => GridItem(key: Key(index.toString()))))),
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
              const SizedBox(key: Key('1'), child: ZetaSpacing(testChild, size: ZetaSpacing.x1)),
              const SizedBox(
                key: Key('2'),
                child: ZetaSpacing.square(testChild, size: ZetaSpacing.x1),
              ),
              SizedBox(key: const Key('3'), child: testChild.square(ZetaSpacing.x1)),
              SizedBox(key: const Key('4'), child: Padding(padding: ZetaSpacing.x1.square, child: testChild)),
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.squish(testChild, size: ZetaSpacing.x1)),
              SizedBox(key: const Key('2'), child: testChild.squish(ZetaSpacing.x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: ZetaSpacing.x1.squish, child: testChild)),
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.stack(testChild, size: ZetaSpacing.x1)),
              SizedBox(key: const Key('2'), child: testChild.stack(ZetaSpacing.x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: ZetaSpacing.x1.stack, child: testChild)),
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.inline(testChild, size: ZetaSpacing.x1)),
              SizedBox(key: const Key('2'), child: testChild.inline(ZetaSpacing.x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: ZetaSpacing.x1.inline, child: testChild)),
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.inlineStart(testChild, size: ZetaSpacing.x1)),
              SizedBox(key: const Key('2'), child: testChild.inlineStart(ZetaSpacing.x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: ZetaSpacing.x1.inlineStart, child: testChild)),
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
              const SizedBox(key: Key('1'), child: ZetaSpacing.inlineEnd(testChild, size: ZetaSpacing.x1)),
              SizedBox(key: const Key('2'), child: testChild.inlineEnd(ZetaSpacing.x1)),
              SizedBox(key: const Key('3'), child: Padding(padding: ZetaSpacing.x1.inlineEnd, child: testChild)),
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
