import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Card',
  type: ZetaCard,
  path: '$componentsPath/Card/Card',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-10&m=dev',
)
Widget card(BuildContext context) {
  return SmallContentWrapper(
      child: ZetaCard(
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    description: context.knobs.string(label: 'Description', initialValue: 'Description'),
    isRequired: context.knobs.boolean(label: 'Is Required', initialValue: false),
    isAi: context.knobs.boolean(label: 'Is AI', initialValue: false),
    content: context.knobs.boolean(label: 'Show placeholder content')
        ? Placeholder(color: Zeta.of(context).colors.surfaceDisabled)
        : null,
  ));
}

@widgetbook.UseCase(
  name: 'Collapsible Card',
  type: ZetaCollapsibleCard,
  path: '$componentsPath/Card/Collapsible',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-10&m=dev',
)
Widget collapsibleCard(BuildContext context) {
  return SmallContentWrapper(
      child: ZetaCollapsibleCard(
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    description: context.knobs.string(label: 'Description', initialValue: 'Description'),
    isRequired: context.knobs.boolean(label: 'Is Required', initialValue: false),
    isAi: context.knobs.boolean(label: 'Is AI', initialValue: false),
    content: Placeholder(color: Zeta.of(context).colors.surfaceDisabled),
    isExpanded: context.knobs.boolean(label: 'Is Expanded', initialValue: false),
  ));
}
