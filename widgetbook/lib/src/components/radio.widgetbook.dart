import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Radio',
  type: ZetaRadio,
  path: '$componentsPath/Radio',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21510-54345&t=AZEbv7Mm0mjIx0Or-4',
)
Widget radioButtonUseCase(BuildContext context) {
  String checkedValue = 'A';

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaRadio<String>(
        groupValue: 'A',
        onChanged: disabledKnob(context) ? null : (value) => setState(() => checkedValue = (value == 'A' ? 'B' : 'A')),
        value: checkedValue,
        label: Text(context.knobs.string(label: 'Label', initialValue: 'Label')),
      );
    },
  );
}
