import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Switch',
  type: ZetaSwitch,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23105-92337&t=9UKEEDe1Zek0JZal-4',
)
Widget switchUseCase(BuildContext context) {
  bool? isOn = false;

  return StatefulBuilder(
    builder: (context, setState) {
      final onChanged = !disabledKnob(context) ? (value) => setState(() => isOn = value) : null;
      return Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
        child: Column(
          children: [
            ZetaSwitch(
              value: isOn,
              onChanged: onChanged,
              variant: context.knobs.listOrNull(
                label: 'Variant',
                options: ZetaSwitchType.values,
                labelBuilder: enumLabelBuilder,
              ),
            ),
            Text((isOn ?? false) ? 'On' : 'Off'),
          ],
        ),
      );
    },
  );
}
