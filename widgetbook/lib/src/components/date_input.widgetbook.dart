import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Date Input',
  type: ZetaDateInput,
  path: '$componentsPath/Date Input',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22667-52911&t=N8coJ9AFu6DS3mOF-4',
)
Widget dateInput(BuildContext context) {
  return SmallContentWrapper(
    child: ZetaDateInput(
      size: context.knobs.list<ZetaWidgetSize>(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      disabled: disabledKnob(context),
      label: context.knobs.stringOrNull(label: 'Label'),
      hintText: context.knobs.stringOrNull(label: 'Hint text'),
      dateFormat: context.knobs.list<String>(
        label: 'Date pattern',
        options: ['MM/dd/yyyy', 'dd/MM/yyyy', 'dd.MM.yyyy', 'yyyy-MM-dd'],
        labelBuilder: (pattern) => pattern,
      ),
      errorText: context.knobs.stringOrNull(label: 'Error message', initialValue: null),
      onChange: (value) {},
    ),
  );
}
