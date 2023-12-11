import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/indicator_example.dart';

WidgetbookComponent indicatorWidgetBook() {
  return WidgetbookComponent(
    name: 'Indicator',
    useCases: [
      WidgetbookUseCase(
        name: 'Icon',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: IndicatorExample.indicatorIconExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Notification',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: IndicatorExample.indicatorNotificationExample,
        ),
      ),
    ],
  );
}
