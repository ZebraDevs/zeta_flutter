import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Filter Selection Bar',
  type: ZetaFilterSelection,
  path: '$componentsPath/Filter Selection Bar',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24607-736&t=N8coJ9AFu6DS3mOF-4',
)
Widget filterSelection(BuildContext context) {
  final items = List.generate(
    context.knobs.int.slider(label: 'Items', min: 1, max: 20, initialValue: 12),
    (index) => false,
  );

  return StatefulBuilder(
    builder: (_, setState) {
      return ZetaFilterSelection(
        icon: iconKnob(context, nullable: false)!,
        items: List.generate(
          items.length,
          (index) => ZetaFilterChip(
            label: 'Label ${index + 1}',
            selected: items[index],
            onTap: (value) => setState(() => items[index] = value),
            draggable: true,
          ),
        ),
        onPressed: () {},
      );
    },
  );
}
