import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

// TODO(luke): Remove the scroll from this.
// TODO(luke): Both of these usecases are the same - should be one for extended and one for small
@widgetbook.UseCase(
  name: 'Floating Action Button',
  type: ZetaFAB,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22748-95311&t=6jmGZpLRLKTDIfJL-4',
)
Widget fab(BuildContext context) => ZetaFAB(
      label: context.knobs.stringOrNull(label: 'Label'),
      onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
      expanded: false,
      icon: iconKnob(context)!,
      shape: context.knobs.list(label: 'Shape', options: ZetaWidgetBorder.values, labelBuilder: enumLabelBuilder),
      size: context.knobs.list(label: 'Size', options: ZetaFabSize.values, labelBuilder: enumLabelBuilder),
      type: context.knobs.list(label: 'Type', options: ZetaFabType.values, labelBuilder: enumLabelBuilder),
    );

@widgetbook.UseCase(
  name: 'Extended Floating Action Button',
  type: ZetaFAB,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22163-75208&t=6jmGZpLRLKTDIfJL-4',
)
Widget extendedFab(BuildContext context) => ZetaFAB(
      label: context.knobs.string(label: 'Label', initialValue: 'Floating Action Button'),
      onPressed: context.knobs.boolean(label: 'Disabled') ? null : () {},
      expanded: true,
      icon: iconKnob(context)!,
      shape: context.knobs.list(label: 'Shape', options: ZetaWidgetBorder.values, labelBuilder: enumLabelBuilder),
      size: context.knobs.list(label: 'Size', options: ZetaFabSize.values, labelBuilder: enumLabelBuilder),
      type: context.knobs.list(label: 'Type', options: ZetaFabType.values, labelBuilder: enumLabelBuilder),
    );
