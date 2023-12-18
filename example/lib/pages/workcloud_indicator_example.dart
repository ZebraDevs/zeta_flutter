import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class WorkcloudIndicatorExample extends StatelessWidget {
  static const String name = 'WorkcloudIndicator';

  const WorkcloudIndicatorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: WorkcloudIndicatorExample.name,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ZetaWorkcloudIndicator(
                  label: 'Test Status Badge',
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(children: [ZetaWorkcloudIndicator.status(label: 'Status')]),
            SizedBox(height: 10),
            Row(children: [ZetaWorkcloudIndicator.status(label: 'In Progress')]),
            SizedBox(height: 10),
            Row(children: [ZetaWorkcloudIndicator.status(label: 'Reviewed')]),
            SizedBox(height: 10),
            Row(children: [ZetaWorkcloudIndicator.status(label: 'Resolved')]),
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Medium'), Text('Small'), Text('X-Small')],
              ),
            ),
            workcloudIndicatorExampleRow('Urgent', 'U', ZetaWorkcloudIndicatorType.urgent),
            SizedBox(height: 10),
            workcloudIndicatorExampleRow('High', '1', ZetaWorkcloudIndicatorType.high),
            SizedBox(height: 10),
            workcloudIndicatorExampleRow('Medium', '2', ZetaWorkcloudIndicatorType.medium),
            SizedBox(height: 10),
            workcloudIndicatorExampleRow('Low', '3', ZetaWorkcloudIndicatorType.low),
            SizedBox(height: 10),
            workcloudIndicatorExampleRow('Custom', '4', ZetaWorkcloudIndicatorType.custom,
                colors: ZetaWidgetColor(backgroundColor: Colors.purple, foregroundColor: Colors.purple.shade50)),
          ],
        ),
      ),
    );
  }
}

List<Widget> workcloudIndicatorStatusRow(String label) {
  return [
    Row(children: [ZetaWorkcloudIndicator.status(label: label)]),
    SizedBox(height: 10)
  ];
}

Widget workcloudIndicatorExampleRow(String label, String index, ZetaWorkcloudIndicatorType type,
    {ZetaWidgetColor? colors}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ZetaWorkcloudIndicator.priorityPill(
          index: index,
          label: label,
          priorityType: type,
          prioritySize: ZetaWidgetSize.large,
          customColors: colors,
        ),
        ZetaWorkcloudIndicator.priorityPill(
          index: index,
          label: label,
          prioritySize: ZetaWidgetSize.medium,
          priorityType: type,
          customColors: colors,
        ),
        ZetaWorkcloudIndicator.priorityPill(
          index: index,
          label: label,
          priorityType: type,
          customColors: colors,
        ),
      ],
    ),
  );
}
