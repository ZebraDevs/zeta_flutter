import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

const path = '$componentsPath/BottomSheet';

@widgetbook.UseCase(
  name: 'Bottom Sheet',
  type: ZetaBottomSheet,
  path: path,
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-9',
)
Widget bottomSheet(BuildContext context) {
  return ZetaBottomSheet(
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    centerTitle: context.knobs.boolean(label: 'Center Title'),
    body: context.knobs.object.dropdown(label: 'Body', options: ["Horizontal", "Vertical"]) == 'Vertical'
        ? Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              6,
              (index) => ZetaMenuItem.horizontal(
                label: Text('Menu Item'),
                onTap: () {},
              ),
            ),
          )
        : Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              6,
              (index) => ZetaMenuItem.vertical(
                label: Text('Menu Item'),
                icon: Icon(ZetaIcons.star),
                onTap: () {},
              ),
            ),
          ),
    showCloseButton: context.knobs.boolean(label: 'Show close button', initialValue: true),
    onDismissed: () {},
  ).paddingHorizontal(16);
}
