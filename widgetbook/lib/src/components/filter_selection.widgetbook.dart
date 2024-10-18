import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Filter Selection',
  type: ZetaFilterSelection,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24607-736&m=dev',
)
Widget filterSelection(BuildContext context) {
  final items = List.generate(12, (index) => false);

  return StatefulBuilder(
    builder: (_, setState) {
      return ZetaFilterSelection(
        items: [
          for (int i = 0; i < items.length; i++)
            ZetaFilterChip(
              label: 'Label ${i + 1}',
              selected: items[i],
              onTap: (value) => setState(() => items[i] = value),
            ),
        ],
        onPressed: () {},
      );
    },
  );
}
