import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';

@widgetbook.UseCase(
  name: 'Calendar',
  type: ZetaCalendar,
  path: '$componentsPath/Calendar',
)
Widget calendar(BuildContext context) {
  final now = DateTime.now();
  final preSelect = context.knobs.boolean(label: 'Pre-select range', initialValue: true);

  return ZetaCalendar(
    visibleMonthCount: context.knobs.object.dropdown(
      label: 'Number of months',
      options: [1, 2, 3],
      labelBuilder: (value) => '$value',
      initialOption: 2,
    ),
    initialStartDate: preSelect ? DateTime(now.year, now.month, 10) : null,
    initialEndDate: preSelect ? DateTime(now.year, now.month + 1, 15) : null,
    minDate: DateTime(now.year - 5),
    maxDate: DateTime(now.year + 5),
    onRangeChanged: (range) {},
    onApply: (range) {},
    onCancel: () {},
    onReset: () {},
  );
}
