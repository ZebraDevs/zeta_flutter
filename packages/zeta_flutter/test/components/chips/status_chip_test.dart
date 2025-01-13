import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/test_app.dart';
import '../../utils/tolerant_comparator.dart';
import '../../utils/utils.dart';

void main() {
  const String parentFolder = 'chips';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('Accessibility Tests', () {
    testWidgets('label meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label',
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });
  });

  group('Content Tests', () {
    final debugFillProperties = {
      'label': '"Label"',
      'draggable': 'false',
      'data': 'null',
      'onDragCompleted': 'null',
      'semanticLabel': 'null',
    };
    debugFillPropertiesTest(
      const ZetaStatusChip(
        label: 'Label',
      ),
      debugFillProperties,
    );

    testWidgets('renders label correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label',
          ),
        ),
      );

      expect(find.text('Label'), findsOneWidget);
    });

    testWidgets('renders label correctly when label is long', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label that is very very long',
          ),
        ),
      );

      final Finder textFinder = find.text('Label that is very very long');

      expect(textFinder, findsOneWidget);
    });
  });

  group('Dimensions Tests', () {
    testWidgets('horizontal padding is 8 and vertical padding is 4', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label',
          ),
        ),
      );
      final Finder finder = find.byType(Container);
      expect(finder, findsOneWidget);
      final Container widget = tester.widget(finder);
      expect(
        widget.padding,
        const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
      );
    });
  });

  group('Styling Tests', () {
    testWidgets('background color is ZetaColors.surfaceWarm and border radius is 8', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label',
          ),
        ),
      );
      final Finder finder = find.byType(Container);
      expect(finder, findsOneWidget);
      final Container widget = tester.widget(finder);
      expect(
        widget.decoration,
        BoxDecoration(
          color: const ZetaColorsAA(primitives: ZetaPrimitivesLight()).surfaceWarm,
          borderRadius: BorderRadius.circular(8),
        ),
      );
    });

    testWidgets('border radius is null when rounded is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label',
            rounded: false,
          ),
        ),
      );
      final Finder finder = find.byType(Container);
      expect(finder, findsOneWidget);
      final Container widget = tester.widget(finder);
      expect(
        widget.decoration,
        BoxDecoration(
          color: const ZetaColorsAA(primitives: ZetaPrimitivesLight()).surfaceWarm,
        ),
      );
    });

    testWidgets('text style is ZetaTextStyles.bodyXSmall and text color is mainDefault', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: ZetaStatusChip(
            label: 'Label',
          ),
        ),
      );
      final Finder finder = find.byType(Text);
      expect(finder, findsOneWidget);
      final Text widget = tester.widget(finder);
      expect(
        widget.style,
        ZetaTextStyles.bodyXSmall.copyWith(
          color: const ZetaColorsAA(primitives: ZetaPrimitivesLight()).mainDefault,
        ),
      );
    });
  });

  group('Interaction Tests', () {
    testWidgets('chip calls onDragCompleted and parses data to DragTarget when drag is completed',
        (WidgetTester tester) async {
      bool dragCompleted = false;
      String? dragData;

      await tester.pumpWidget(
        TestApp(
          home: Column(
            children: [
              ZetaStatusChip(
                label: 'Label',
                draggable: true,
                data: 'data',
                onDragCompleted: () {
                  dragCompleted = true;
                },
              ),
              DragTarget<String>(
                onAcceptWithDetails: (details) => dragData = details.data,
                builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                  return const SizedBox(
                    width: 100,
                    height: 100,
                  );
                },
              ),
            ],
          ),
        ),
      );

      final Finder finder = find.byType(Draggable);
      expect(finder, findsOneWidget);

      final TestGesture gesture = await tester.startGesture(tester.getCenter(finder));
      await gesture.moveTo(tester.getCenter(find.byType(DragTarget<String>)));
      await gesture.up();

      expect(dragCompleted, isTrue);
      expect(dragData, 'data');
    });
  });

  group('Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaStatusChip(
        label: 'Label',
      ),
      'status_chip_default',
    );
    goldenTest(
      goldenFile,
      const ZetaStatusChip(
        label: 'Label',
        rounded: false,
      ),
      'status_chip_sharp',
    );
    goldenTest(
      goldenFile,
      const ZetaStatusChip(
        label: 'Label that is very very long',
      ),
      'status_chip_long',
    );
  });

  group('Performance Tests', () {});
}
