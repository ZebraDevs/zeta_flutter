import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/stepper/stepper.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_app.dart';
import '../../../test_utils/tolerant_comparator.dart';
import '../../../test_utils/utils.dart';

void main() {
  const String parentFolder = 'ENTER_PARENT_FOLDER (e.g. button)';

  const goldenFile = GoldenFiles(component: parentFolder);
  setUpAll(() {
    goldenFileComparator = TolerantComparator(goldenFile.uri);
  });

  group('ZetaStepper Accessibility Tests', () {
    testWidgets('Horizontal stepper meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [ZetaStep(title: Text('Title'))],
            currentStep: 0,
            onStepTapped: (step) {},
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });

    testWidgets('Vertical stepper meets accessibility  requirements', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [ZetaStep(title: Text('Title'))],
            currentStep: 0,
            type: ZetaStepperType.vertical,
            onStepTapped: (step) {},
          ),
        ),
      );
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      await expectLater(tester, meetsGuideline(textContrastGuideline));

      handle.dispose();
    });

    testWidgets('Horizontal steps correctly recieve semantic labels', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [ZetaStep(title: Text('Title'), semanticLabel: 'semantic label')],
            currentStep: 0,
            onStepTapped: (step) {},
          ),
        ),
      );

      expect(find.bySemanticsLabel('semantic label'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('Vertical steps correctly recieve semantic labels', (WidgetTester tester) async {
      final SemanticsHandle handle = tester.ensureSemantics();
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [ZetaStep(title: Text('Title'), semanticLabel: 'semantic label')],
            currentStep: 0,
            type: ZetaStepperType.vertical,
            onStepTapped: (step) {},
          ),
        ),
      );

      expect(find.bySemanticsLabel('semantic label'), findsOneWidget);

      handle.dispose();
    });
  });

  group('ZetaStepper Content Tests', () {
    testWidgets('Horizontal stepper renders the correct steps', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [
              ZetaStep(title: Text('Title 1')),
              ZetaStep(title: Text('Title 2')),
              ZetaStep(title: Text('Title 3')),
            ],
            currentStep: 0,
            onStepTapped: (step) {},
          ),
        ),
      );

      expect(find.text('Title 1'), findsOneWidget);
      expect(find.text('Title 2'), findsOneWidget);
      expect(find.text('Title 3'), findsOneWidget);
    });

    testWidgets('Vertical stepper renders the correct steps', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [
              ZetaStep(title: Text('Title 1')),
              ZetaStep(title: Text('Title 2')),
              ZetaStep(title: Text('Title 3')),
            ],
            type: ZetaStepperType.vertical,
            currentStep: 0,
            onStepTapped: (step) {},
          ),
        ),
      );

      expect(find.text('Title 1'), findsOneWidget);
      expect(find.text('Title 2'), findsOneWidget);
      expect(find.text('Title 3'), findsOneWidget);
    });

    testWidgets('StepIcon displays the correct text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: StepIcon(
            completed: false,
            disabled: false,
            index: 0,
            type: ZetaStepperType.horizontal,
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
    });
    testWidgets('StepIcon displays the correct icon when completed', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: StepIcon(
            completed: true,
            disabled: false,
            index: 0,
            type: ZetaStepperType.horizontal,
          ),
        ),
      );

      expect(find.byIcon(ZetaIcons.check_mark_round), findsOneWidget);
    });

    debugFillPropertiesTest(
      const ZetaStepper(steps: [], currentStep: 0),
      {
        'steps': '[]',
        'currentStep': '0',
        'type': 'horizontal',
        'onStepTapped': 'null',
      },
    );
    debugFillPropertiesTest(
      const StepIcon(completed: false, disabled: false, index: 0, type: ZetaStepperType.horizontal),
      {
        'index': '0',
        'type': 'horizontal',
        'completed': 'false',
        'disabled': 'false',
      },
    );
    const step = ZetaStep(title: Text('Title'));
    debugFillPropertiesTest(
      const HorizontalStep(step: step, index: 0, completed: false),
      {
        'step': "Instance of 'ZetaStep'",
        'index': '0',
        'completed': 'false',
        'onStepTapped': 'null',
      },
    );
    debugFillPropertiesTest(
      const VerticalStep(step: step, index: 0, completed: false, isLast: false),
      {
        'step': "Instance of 'ZetaStep'",
        'index': '0',
        'completed': 'false',
        'isLast': 'false',
        'onStepTapped': 'null',
      },
    );
  });

  group('ZetaStepper Dimensions Tests', () {
    testWidgets('StepIcon horiztonal has the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: StepIcon(
            completed: false,
            disabled: false,
            index: 0,
            type: ZetaStepperType.horizontal,
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final spacing = Zeta.of(getBuildContext(tester, Container)).spacing;

      expect(container.constraints?.maxHeight, spacing.xl_4);
      expect(container.constraints?.maxWidth, spacing.xl_4);
    });

    testWidgets('StepIcon vertical has the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: StepIcon(
            completed: false,
            disabled: false,
            index: 0,
            type: ZetaStepperType.vertical,
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final spacing = Zeta.of(getBuildContext(tester, Container)).spacing;

      expect(container.constraints?.maxHeight, spacing.xl_6);
      expect(container.constraints?.maxWidth, spacing.xl_6);
    });

    testWidgets('StepDivider horizontal has the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: StepDivider(
            completed: false,
            disabled: false,
            type: ZetaStepperType.horizontal,
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, ZetaBorders.medium);
      expect(container.constraints?.maxWidth, double.infinity);
    });

    testWidgets('StepDivider vertical has the correct size', (WidgetTester tester) async {
      await tester.pumpWidget(
        const TestApp(
          home: StepDivider(
            completed: false,
            disabled: false,
            type: ZetaStepperType.vertical,
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));
      final spacing = Zeta.of(getBuildContext(tester, Container)).spacing;
      expect(container.constraints?.maxHeight, spacing.xl_8);
      expect(container.constraints?.maxWidth, spacing.minimum);
    });
  });

  group('ZetaStepper Styling Tests', () {
    testWidgets(
      'StepIcon has the correct colour when enabled',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: StepIcon(
              completed: false,
              disabled: false,
              index: 0,
              type: ZetaStepperType.horizontal,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration! as BoxDecoration).color,
          Zeta.of(getBuildContext(tester, Container)).colors.primary,
        );
      },
    );
    testWidgets(
      'StepIcon has the correct colour when completed',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: StepIcon(
              completed: true,
              disabled: false,
              index: 0,
              type: ZetaStepperType.horizontal,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration! as BoxDecoration).color,
          Zeta.of(getBuildContext(tester, Container)).colors.surfacePositive,
        );
      },
    );
    testWidgets(
      'StepIcon has the correct colour when disabled',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: StepIcon(
              completed: true,
              disabled: true,
              index: 0,
              type: ZetaStepperType.horizontal,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration! as BoxDecoration).color,
          Zeta.of(getBuildContext(tester, Container)).colors.iconDisabled,
        );
      },
    );
    testWidgets(
      'StepDivider has the correct colour when enabled',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: StepDivider(
              completed: false,
              disabled: false,
              type: ZetaStepperType.horizontal,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration! as BoxDecoration).color,
          Zeta.of(getBuildContext(tester, Container)).colors.borderPrimary,
        );
      },
    );
    testWidgets(
      'StepDivider has the correct colour when completed',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: StepDivider(
              completed: true,
              disabled: false,
              type: ZetaStepperType.horizontal,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration! as BoxDecoration).color,
          Zeta.of(getBuildContext(tester, Container)).colors.borderPositive,
        );
      },
    );
    testWidgets(
      'StepDivider has the correct colour when disabled',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: StepDivider(
              completed: true,
              disabled: true,
              type: ZetaStepperType.horizontal,
            ),
          ),
        );

        final container = tester.widget<Container>(find.byType(Container));
        expect(
          (container.decoration! as BoxDecoration).color,
          Zeta.of(getBuildContext(tester, Container)).colors.borderDefault,
        );
      },
    );
  });

  group('ZetaStepper Interaction Tests', () {
    testWidgets('Horizontal stepper calls onStepTapped when a step is tapped', (WidgetTester tester) async {
      int tappedStep = -1;
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [
              ZetaStep(title: Text('Title 1')),
              ZetaStep(title: Text('Title 2')),
              ZetaStep(title: Text('Title 3')),
            ],
            currentStep: 0,
            onStepTapped: (step) {
              tappedStep = step;
            },
          ),
        ),
      );

      await tester.tap(find.text('Title 2'));
      expect(tappedStep, 1);
    });

    testWidgets('Vertical stepper calls onStepTapped when a step is tapped', (WidgetTester tester) async {
      int tappedStep = -1;
      await tester.pumpWidget(
        TestApp(
          home: ZetaStepper(
            steps: const [
              ZetaStep(title: Text('Title 1')),
              ZetaStep(title: Text('Title 2')),
              ZetaStep(title: Text('Title 3')),
            ],
            type: ZetaStepperType.vertical,
            currentStep: 0,
            onStepTapped: (step) {
              tappedStep = step;
            },
          ),
        ),
      );

      await tester.tap(find.text('Title 2'));
      expect(tappedStep, 1);
    });
  });

  group('ZetaStepper Golden Tests', () {
    goldenTest(
      goldenFile,
      const ZetaStepper(
        steps: [
          ZetaStep(title: Text('Title 1')),
          ZetaStep(title: Text('Title 2')),
          ZetaStep(title: Text('Title 3')),
        ],
        currentStep: 0,
      ),
      'stepper_horizontal_incomplete',
    );

    goldenTest(
      goldenFile,
      const ZetaStepper(
        steps: [
          ZetaStep(title: Text('Title 1')),
          ZetaStep(title: Text('Title 2')),
          ZetaStep(title: Text('Title 3')),
        ],
        currentStep: 4,
      ),
      'stepper_horizontal_complete',
    );
    goldenTest(
      goldenFile,
      const ZetaStepper(
        steps: [
          ZetaStep(title: Text('Title 1')),
          ZetaStep(title: Text('Title 2'), disabled: true),
          ZetaStep(title: Text('Title 3')),
        ],
        currentStep: 0,
      ),
      'stepper_horizontal_step_disabled',
    );
    goldenTest(
      goldenFile,
      const ZetaStepper(
        type: ZetaStepperType.vertical,
        steps: [
          ZetaStep(title: Text('Title 1')),
          ZetaStep(title: Text('Title 2')),
          ZetaStep(title: Text('Title 3')),
        ],
        currentStep: 0,
      ),
      'stepper_vertical_incomplete',
    );

    goldenTest(
      goldenFile,
      const ZetaStepper(
        type: ZetaStepperType.vertical,
        steps: [
          ZetaStep(title: Text('Title 1')),
          ZetaStep(title: Text('Title 2')),
          ZetaStep(title: Text('Title 3')),
        ],
        currentStep: 4,
      ),
      'stepper_vertical_complete',
    );
    goldenTest(
      goldenFile,
      const ZetaStepper(
        type: ZetaStepperType.vertical,
        steps: [
          ZetaStep(title: Text('Title 1')),
          ZetaStep(title: Text('Title 2'), disabled: true),
          ZetaStep(title: Text('Title 3')),
        ],
        currentStep: 0,
      ),
      'stepper_vertical_step_disabled',
    );
  });

  group('Performance Tests', () {});
}
