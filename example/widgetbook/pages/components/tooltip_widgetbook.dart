import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

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
  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.all(Zeta.of(context).spacing.xl_4),
          child: ZetaTooltip(
            child: Text(text),
            arrowDirection: direction,
          ),
        );
      },
    ),
  );
}
