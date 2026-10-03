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

  final minYearOffset = context.knobs.object.dropdown(
    label: 'Min date (years from now)',
    options: [-10, -5, -3, -1, 0],
    labelBuilder: (value) => value == 0 ? 'Today' : '$value years',
    initialOption: -5,
  );
  final maxYearOffset = context.knobs.object.dropdown(
    label: 'Max date (years from now)',
    options: [0, 1, 3, 5, 10],
    labelBuilder: (value) => value == 0 ? 'Today' : '+$value years',
    initialOption: 5,
  );

  return ZetaCalendar(
    visibleMonthCount: context.knobs.object.dropdown(
      label: 'Number of months',
      options: [1, 2, 3],
      labelBuilder: (value) => '$value',
      initialOption: 2,
    ),
    initialStartDate: preSelect ? DateTime(now.year, now.month, 10) : null,
    initialEndDate: preSelect ? DateTime(now.year, now.month + 1, 15) : null,
    minDate: DateTime(now.year + minYearOffset),
    maxDate: DateTime(now.year + maxYearOffset),
    onRangeChanged: (range) {},
    onApply: (range) {},
    onCancel: () {},
    onReset: () {},
  );
}
