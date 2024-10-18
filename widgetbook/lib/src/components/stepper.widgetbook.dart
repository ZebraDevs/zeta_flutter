import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Stepper - Horizontal',
  type: ZetaStepper,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21529-11408&t=9UKEEDe1Zek0JZal-4',
)
Widget horizontal(BuildContext context) {
  int currentStep = 0;

  ZetaStepType getForStepIndex(int stepIndex) {
    if (currentStep == stepIndex) return ZetaStepType.enabled;
    if (currentStep > stepIndex) return ZetaStepType.complete;

    return ZetaStepType.disabled;
  }

  final enabledContent = context.knobs.boolean(label: 'Enabled Content', initialValue: true);

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaStepper(
        currentStep: currentStep,
        onStepTapped: (index) => setState(() => currentStep = index),
        type: ZetaStepperType.horizontal,
        steps: [
          ZetaStep(
            type: getForStepIndex(0),
            title: const Text("Title"),
            content: enabledContent ? const Text("Content") : null,
          ),
          ZetaStep(
            type: getForStepIndex(1),
            title: const Text("Title 2"),
            content: enabledContent ? const Text("Content 2") : null,
          ),
          ZetaStep(
            type: getForStepIndex(2),
            title: const Text("Title 3"),
            content: enabledContent ? const Text("Content 3") : null,
          ),
        ],
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Stepper - Vertical',
  type: ZetaStepper,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21529-11408&t=9UKEEDe1Zek0JZal-4',
)
Widget vertical(BuildContext context) {
  int currentStep = 0;

  ZetaStepType getForStepIndex(int stepIndex) {
    if (currentStep == stepIndex) return ZetaStepType.enabled;
    if (currentStep > stepIndex) return ZetaStepType.complete;

    return ZetaStepType.disabled;
  }

  final enabledContent = context.knobs.boolean(label: 'Enabled Content', initialValue: true);

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaStepper(
        currentStep: currentStep,
        onStepTapped: (index) => setState(() => currentStep = index),
        type: ZetaStepperType.vertical,
        steps: [
          ZetaStep(
            type: getForStepIndex(0),
            title: const Text("Title"),
            content: enabledContent ? const Text("Content") : null,
          ),
          ZetaStep(
            type: getForStepIndex(1),
            title: const Text("Title 2"),
            content: enabledContent ? const Text("Content 2") : null,
          ),
          ZetaStep(
            type: getForStepIndex(2),
            title: const Text("Title 3"),
            content: enabledContent ? const Text("Content 3") : null,
          ),
        ],
      );
    },
  );
}
