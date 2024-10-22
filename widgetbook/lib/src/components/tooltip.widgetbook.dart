import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Tooltip',
  type: ZetaTooltip,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21816-222&t=9UKEEDe1Zek0JZal-4',
)
Widget tooltip(BuildContext context) {
  return ZetaTooltip(
    arrowDirection: context.knobs.list<ZetaTooltipArrowDirection>(
      label: 'Arrow direction',
      options: ZetaTooltipArrowDirection.values,
      labelBuilder: (direction) => direction.name,
    ),
    child: Text(context.knobs.string(
      label: 'Tooltip text',
      initialValue: 'Label',
    ),),
  );
}
