import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class BadgeExample extends StatelessWidget {
  static const String name = 'Badge';

  const BadgeExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: BadgeExample.name,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            badgeExampleRow(WidgetSeverity.info),
            badgeExampleRow(WidgetSeverity.positive),
            badgeExampleRow(WidgetSeverity.warning),
            badgeExampleRow(WidgetSeverity.negative),
            badgeExampleRow(WidgetSeverity.neutral),
          ],
        ),
      ),
    );
  }
}

Widget badgeExampleRow(WidgetSeverity type) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ZetaBadge(
          label: 'Label',
          severity: type,
          borderType: BorderType.sharp,
        ),
        ZetaBadge(
          label: 'Label',
          severity: type,
        ),
      ]);
}
