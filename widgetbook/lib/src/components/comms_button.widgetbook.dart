import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Comms Buttons',
  type: ZetaCommsButton,
  path: '$componentsPath/Comms Button',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=20816-11402&t=6jmGZpLRLKTDIfJL-4',
)
Widget commsButtonUseCase(BuildContext context) {
  return ZetaCommsButton(
      label: context.knobs.string(label: 'Label', initialValue: 'Answer'),
      size: context.knobs.object.dropdown(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
        initialOption: ZetaWidgetSize.medium,
      ),
      type: context.knobs.object.dropdown(
        label: 'Type',
        options: ZetaCommsButtonType.values,
        labelBuilder: enumLabelBuilder,
        initialOption: ZetaCommsButtonType.positive,
      ),
      icon: iconKnob(context, nullable: false, initial: ZetaIcons.phone),
      onPressed: disabledKnob(context) ? null : () => {});
}
