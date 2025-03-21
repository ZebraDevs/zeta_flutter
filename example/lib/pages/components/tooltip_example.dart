import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TooltipExample extends StatelessWidget {
  static const String name = 'Tooltip';

  const TooltipExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Tooltip',
      paddingAll: 40,
      children: [
        Column(
          spacing: 36,
          children: [
            ZetaTooltip(child: Text('Label')),
            ZetaTooltip(child: Text('Label'), arrowDirection: ZetaTooltipArrowDirection.right),
            ZetaTooltip(child: Text('Label'), arrowDirection: ZetaTooltipArrowDirection.up),
            ZetaTooltip(child: Text('Label'), arrowDirection: ZetaTooltipArrowDirection.left),
          ],
        )
      ],
    );
  }
}
