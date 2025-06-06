import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Button',
  type: ZetaButton,
  path: '$componentsPath/Button',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23132-166632&t=N8coJ9AFu6DS3mOF-4',
)
Widget button(BuildContext context) {
  final borderType = context.knobs.list(
    label: 'Border type',
    labelBuilder: enumLabelBuilder,
    options: ZetaWidgetBorder.values,
  );
  return ZetaButton(
    label: context.knobs.string(label: 'Text', initialValue: 'Button'),
    onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
    borderType: borderType,
    size: context.knobs.list(
      label: 'Size',
      options: ZetaWidgetSize.values,
      labelBuilder: enumLabelBuilder,
    ),
    type: context.knobs.list(
      label: 'Type',
      options: ZetaButtonType.values,
      labelBuilder: enumLabelBuilder,
    ),
    leadingIcon: iconKnob(context, nullable: true, name: 'Leading Icon'),
    trailingIcon: iconKnob(context, nullable: true, name: 'Trailing Icon'),
  );
}

@widgetbook.UseCase(
  name: 'Icon Button',
  type: ZetaIconButton,
  path: '$componentsPath/Button',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23132-166001&t=N8coJ9AFu6DS3mOF-4',
)
Widget iconButton(BuildContext context) {
  return ZetaIconButton(
    icon: iconKnob(context)!,
    onPressed: disabledKnob(context) ? null : () {},
    borderType: context.knobs.list(
      label: 'Border type',
      options: ZetaWidgetBorder.values,
      labelBuilder: enumLabelBuilder,
    ),
    size: context.knobs.list(
      label: 'Size',
      labelBuilder: enumLabelBuilder,
      options: ZetaWidgetSize.values,
    ),
    type: context.knobs.list(
      label: 'Type',
      options: ZetaButtonType.values,
      labelBuilder: enumLabelBuilder,
    ),
  );
}
