import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Password',
  type: ZetaPasswordInput,
  path: '$componentsPath/Password Input',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=948-13632&t=AZEbv7Mm0mjIx0Or-4',
)
Widget passwordInputUseCase(BuildContext context) {
  return SmallContentWrapper(
    child: ZetaPasswordInput(
      disabled: disabledKnob(context),
      size: context.knobs.list(label: 'Size', options: ZetaWidgetSize.values, labelBuilder: enumLabelBuilder),
      hintText: context.knobs.string(label: 'Hint Text'),
      placeholder: context.knobs.string(label: 'Placeholder'),
      label: context.knobs.string(label: 'Label'),
      errorText: context.knobs.stringOrNull(label: 'Error Text'),
    ),
  );
}
