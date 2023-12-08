import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';
import 'package:zeta_flutter/src/utils/enums.dart';

class PriorityPillExample extends StatelessWidget {
  static const String name = 'PriorityPill';

  const PriorityPillExample();

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'PriorityPill',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ZetaPriorityPill(
              index: 1,
              priority: 'Rounded',
              borderType: BorderType.rounded,
            ),
            ZetaPriorityPill(
              index: 2,
              priority: 'Sharp',
            )
          ],
        ),
      ),
    );
  }
}
