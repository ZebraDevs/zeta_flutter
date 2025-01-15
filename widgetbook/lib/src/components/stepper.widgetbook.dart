import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String stepperPath = '$componentsPath/Stepper';

@widgetbook.UseCase(
  name: 'Stepper Horizontal',
  type: ZetaStepper,
  path: stepperPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23105-92242&t=eEOivHU9uV4K8qJq-4',
)
Widget stepperHorizontalUseCase(BuildContext context) {
  int currentStep = 0;
  final String title = context.knobs.string(label: 'Title', initialValue: 'Title');
  final int numItems = context.knobs.int.slider(label: 'Number of items', initialValue: 3, min: 1, max: 6);
  final bool disabled = disabledKnob(context);
  return StatefulBuilder(builder: (context, setState) {
    return ZetaStepper(
      currentStep: currentStep,
      onStepTapped: (index) => setState(() => currentStep = index),
      type: ZetaStepperType.horizontal,
      steps: List.generate(
        numItems,
        (e) => ZetaStep(title: Text("$title ${e + 1}"), disabled: disabled),
      ),
    );
  });
}

@widgetbook.UseCase(
  name: 'Stepper Vertical',
  type: ZetaStepper,
  path: '$componentsPath/Stepper',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23105-92242&t=eEOivHU9uV4K8qJq-4',
)
Widget stepperVerticalUseCase(BuildContext context) {
  int currentStep = 0;
  final String title = context.knobs.string(label: 'Title', initialValue: 'Title');
  final String subtitle = context.knobs.string(label: 'Subtitle', initialValue: 'Subtitle');
  final int numItems = context.knobs.int.slider(label: 'Number of items', initialValue: 3, min: 1, max: 6);
  final bool disabled = disabledKnob(context);

  return StatefulBuilder(builder: (context, setState) {
    return ZetaStepper(
      currentStep: currentStep,
      onStepTapped: (index) => setState(() => currentStep = index),
      type: ZetaStepperType.vertical,
      steps: List.generate(
        numItems,
        (e) => ZetaStep(title: Text("$title ${e + 1}"), subtitle: Text("$subtitle ${e + 1}"), disabled: disabled),
      ),
    );
  });
}
