import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Checkbox',
  type: ZetaCheckbox,
  path: '$componentsPath/Checkbox',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21510-54003&t=N8coJ9AFu6DS3mOF-4',
)
Widget checkbox(BuildContext context) {
  var b = true;
  return StatefulBuilder(
    builder: (context, setState) {
      final label = context.knobs.stringOrNull(label: 'Label', initialValue: 'Checkbox');
      return ZetaCheckbox(
        value: b,
        onChanged: !disabledKnob(context) ? (b2) => setState(() => b = b2) : null,
        useIndeterminate: context.knobs.boolean(label: 'Use Indeterminate', initialValue: true),
        label: label != null && label.isNotEmpty ? label : null,
      );
    },
  );
}
