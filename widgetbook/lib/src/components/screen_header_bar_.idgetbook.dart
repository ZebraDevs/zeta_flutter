import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Screen Header',
  type: ZetaScreenHeaderBar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24601-9222&t=9UKEEDe1Zek0JZal-4',
)
Widget screenHeaderBarUseCase(BuildContext context) {
  return ZetaScreenHeaderBar(
    title: Text(context.knobs.string(
      label: 'Title',
      initialValue: 'Add Subscribers',
    )),
    actionButtonLabel: 'Done',
    onActionButtonPressed: () {},
  );
}
