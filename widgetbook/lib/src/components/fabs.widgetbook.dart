import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Floating Action Button',
  type: ZetaFAB,
  path: '$componentsPath/Fabs',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22163-76639',
)
Widget fab(BuildContext context) => ZetaFAB(
      label: context.knobs.stringOrNull(label: 'Label'),
      onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
      expanded: context.knobs.boolean(label: 'Expanded'),
      icon: iconKnob(context, nullable: false)!,
      shape: context.knobs.object
          .dropdown(label: 'Shape', options: ZetaWidgetBorder.values, labelBuilder: enumLabelBuilder),
      size: context.knobs.object.dropdown(label: 'Size', options: ZetaFabSize.values, labelBuilder: enumLabelBuilder),
      type: context.knobs.object.dropdown(label: 'Type', options: ZetaFabType.values, labelBuilder: enumLabelBuilder),
    );
