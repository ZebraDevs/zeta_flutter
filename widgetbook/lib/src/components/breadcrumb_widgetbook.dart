import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:zeta_widgetbook/main.dart';

@widgetbook.UseCase(
  name: 'Breadcrumb',
  type: ZetaBreadcrumb,
  path: '$componentsPath/Breadcrumb',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-27106&t=N8coJ9AFu6DS3mOF-4',
)
Widget breadcrumbUseCase(BuildContext context) {
  final children = List.generate(
    context.knobs.int.slider(
      label: 'Items',
      initialValue: 3,
      min: 2,
      max: 20,
    ),
    (index) => ZetaBreadcrumbItem(label: 'Item $index', onPressed: () {}),
  );

  return ZetaBreadcrumb(
    maxItemsShown: context.knobs.int.slider(
      label: 'Max Items Shown',
      initialValue: 2,
      min: 1,
      max: 10,
    ),
    children: children,
  );
}
