import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget filterSelectionUseCase(BuildContext context) {
  final items = List.generate(12, (index) => false);
  final rounded = context.knobs.boolean(
    label: 'Rounded',
    initialValue: true,
  );

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (_, setState) {
        return Column(
          children: [
            const SizedBox(height: ZetaSpacing.m),
            ZetaFilterSelection(
              rounded: rounded,
              items: [
                for (int i = 0; i < items.length; i++)
                  ZetaFilterChip(
                    label: 'Label ${i + 1}',
                    selected: items[i],
                    onTap: (value) => setState(() => items[i] = value),
                  ),
              ],
              onPressed: () {},
            ),
          ],
        );
      },
    ),
  );
}
