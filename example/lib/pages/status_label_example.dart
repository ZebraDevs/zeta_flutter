import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class LabelExample extends StatelessWidget {
  static const String name = 'StatusLabel';

  const LabelExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: LabelExample.name,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            statusLabelExampleRow(WidgetSeverity.neutral),
            statusLabelExampleRow(WidgetSeverity.info),
            statusLabelExampleRow(WidgetSeverity.positive),
            statusLabelExampleRow(WidgetSeverity.warning),
            statusLabelExampleRow(WidgetSeverity.negative),
            statusLabelExampleRow(
              WidgetSeverity.custom,
              colors: ZetaStatusLabelColors(accentColor: Colors.blue, backgroundColor: Colors.blue.shade50),
            ),
          ],
        ),
      ),
    );
  }
}

Widget statusLabelExampleRow(WidgetSeverity type, {ZetaStatusLabelColors? colors}) {
  return Padding(
    padding: EdgeInsets.all(10),
    child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center, children: [
      ZetaStatusLabel(
        label: 'Label',
        severity: type,
        isDefaultIcon: false,
        customColors: colors,
      ),
      ZetaStatusLabel(
        label: 'Label',
        severity: type,
        borderType: BorderType.rounded,
        customColors: colors,
      ),
    ]),
  );
}
