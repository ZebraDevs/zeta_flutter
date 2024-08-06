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
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Zeta.of(context).spacing.xl_4),
            ZetaTooltip(
              child: Text('Label'),
            ),
            SizedBox(height: Zeta.of(context).spacing.xl_4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.right,
            ),
            SizedBox(height: Zeta.of(context).spacing.xl_4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.up,
            ),
            SizedBox(height: Zeta.of(context).spacing.xl_4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.left,
            ),
          ],
        ),
      ),
    );
  }
}
