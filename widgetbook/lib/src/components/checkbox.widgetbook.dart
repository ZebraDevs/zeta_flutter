import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

// TODO(luke): Test this
@widgetbook.UseCase(
  name: 'Checkbox',
  type: ZetaCheckbox,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-10317&t=fFNXUv3Vk4zGNrMG-4',
)
Widget checkbox(BuildContext context) {
  bool b = true;
  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaCheckbox(
        value: b,
        onChanged: !disabledKnob(context) ? (b2) => setState(() => b = b2) : null,
        useIndeterminate: context.knobs.boolean(label: 'Use Indeterminate', initialValue: true),
        label: context.knobs.string(label: 'Label', initialValue: 'Checkbox'),
      );
    },
  );
}
