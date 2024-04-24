import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget tooltipUseCase(BuildContext context) {
  final text = context.knobs.string(
    label: 'Tooltip text',
    initialValue: 'Label',
  );
  final direction = context.knobs.list<ZetaTooltipArrowDirection>(
    label: 'Arrow direction',
    options: ZetaTooltipArrowDirection.values,
    labelBuilder: (direction) => direction.name,
  );
  final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.l),
          child: ZetaTooltip(
            child: Text(text),
            rounded: rounded,
            arrowDirection: direction,
          ),
        );
      },
    ),
  );
}
