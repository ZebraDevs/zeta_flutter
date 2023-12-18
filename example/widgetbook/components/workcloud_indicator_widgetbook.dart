import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/workcloud_indicator_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent workcloudIndicatorWidgetBook() {
  return WidgetbookComponent(
    name: 'Workcloud Indicator',
    useCases: [
      WidgetbookUseCase(
        name: 'Status',
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ZetaWorkcloudIndicator.status(label: 'Status'),
                )
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ZetaWorkcloudIndicator.status(label: 'In Progress'),
                )
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ZetaWorkcloudIndicator.status(label: 'Reviewed'),
                )
              ]),
              Row(children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: ZetaWorkcloudIndicator.status(label: 'Resolved'),
                )
              ]),
            ],
          ),
        ),
      ),
      WidgetbookUseCase(
          name: 'Priority Pill',
          builder: (context) => SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('Medium'), Text('Small'), Text('X-Small')],
                      ),
                    ),
                    workcloudIndicatorExampleRow('Urgent', 'U', ZetaWorkcloudIndicatorType.urgent),
                    workcloudIndicatorExampleRow('High', '1', ZetaWorkcloudIndicatorType.high),
                    workcloudIndicatorExampleRow('Medium', '2', ZetaWorkcloudIndicatorType.medium),
                    workcloudIndicatorExampleRow('Low', '3', ZetaWorkcloudIndicatorType.low),
                    workcloudIndicatorExampleRow('Custom', '4', ZetaWorkcloudIndicatorType.custom,
                        colors:
                            ZetaWidgetColor(backgroundColor: Colors.purple, foregroundColor: Colors.purple.shade50)),
                  ],
                ),
              ))
    ],
  );
}
