import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Screen Header',
  type: ZetaScreenHeaderBar,
  path: '$componentsPath/Screen Header Bar',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24601-9207&t=sHwT9f9HuPjkpi1x-4',
)
Widget screenHeaderBarUseCase(BuildContext context) {
  return SmallContentWrapper(
    child: ZetaScreenHeaderBar(
      title: Text(context.knobs.string(label: 'Title', initialValue: 'Add Subscribers')),
      actionButtonLabel: context.knobs.stringOrNull(label: 'Button', initialValue: 'Done'),
      onActionButtonPressed: context.knobs.boolean(label: 'Button Disabled') ? null : () {},
    ),
  );
}
