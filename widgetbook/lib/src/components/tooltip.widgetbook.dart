import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

@widgetbook.UseCase(
  name: 'Tooltip',
  type: ZetaTooltip,
  path: '$componentsPath/Tooltip',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21816-222&t=eEOivHU9uV4K8qJq-4',
)
Widget tooltip(BuildContext context) {
  return ZetaTooltip(
    arrowDirection: context.knobs.object.dropdown<ZetaTooltipArrowDirection>(
      label: 'Arrow direction',
      options: ZetaTooltipArrowDirection.values,
      labelBuilder: (direction) => direction.name,
    ),
    color: context.knobs.color(label: 'Color', initialValue: Colors.black),
    child: Text(context.knobs.string(label: 'Tooltip text', initialValue: 'Label')),
  );
}
