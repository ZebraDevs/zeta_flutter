import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

@widgetbook.UseCase(
  name: 'Accordion',
  type: ZetaAccordion,
  path: '$componentsPath/Accordion',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-10318&t=N8coJ9AFu6DS3mOF-4',
)
Widget accordion(BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      ZetaAccordion(
        title: context.knobs.string(label: 'Accordion Title', initialValue: 'Title'),
        contained: context.knobs.boolean(label: 'Contained'),
        child: context.knobs.boolean(label: 'Disabled')
            ? null
            : const Column(
                children: [
                  ListTile(title: Text('Item One')),
                  ListTile(title: Text('Item  two')),
                  ListTile(title: Text('Item three')),
                  ListTile(title: Text('Item four')),
                ],
              ),
      ),
    ],
  );
}
