import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Radio',
  type: ZetaRadio,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21510-54345&t=9UKEEDe1Zek0JZal-4',
)
Widget radioButtonUseCase(BuildContext context) {
  const option1 = 'Label 1';
  const option2 = 'Label 2';
  String? groupValue;

  return StatefulBuilder(
    builder: (context, setState) {
      final onChanged = !disabledKnob(context) ? (value) => setState(() => groupValue = value) : null;
      return Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Zeta.of(context).spacing.xl),
              child: const Text('Radio Button'),
            ),
            ZetaRadio<String>(
              value: option1,
              groupValue: groupValue,
              onChanged: onChanged,
              label: const Text(option1),
            ),
            ZetaRadio<String>(
              value: option2,
              groupValue: groupValue,
              onChanged: onChanged,
              label: const Text(option2),
            ),
          ],
        ),
      );
    },
  );
}
