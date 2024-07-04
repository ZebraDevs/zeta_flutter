import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget filterSelectionUseCase(BuildContext context) {
  final items = List.generate(12, (index) => false);

  return WidgetBookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (_, setState) {
        return Column(
          children: [
            const SizedBox(height: ZetaSpacing.xl_2),
            ZetaFilterSelection(
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
