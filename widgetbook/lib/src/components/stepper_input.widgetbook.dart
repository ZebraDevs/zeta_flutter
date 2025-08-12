import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Stepper Input',
  type: ZetaStepperInput,
  path: '$componentsPath/Stepper Input',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21529-9963&t=eEOivHU9uV4K8qJq-4',
)
Widget stepperInputUseCase(BuildContext context) {
  return ZetaStepperInput(
    value: context.knobs.int.input(label: 'Value'),
    min: context.knobs.int.input(label: 'Minimum value'),
    max: context.knobs.int.input(label: 'Maximum value', initialValue: 10),
    size: context.knobs.object
        .dropdown(label: 'Size', options: ZetaStepperInputSize.values, labelBuilder: enumLabelBuilder),
    onChange: disabledKnob(context) ? null : (_) {},
  );
}
