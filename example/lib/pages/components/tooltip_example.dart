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
            Text('Rounded'),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
            ),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.right,
            ),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.up,
            ),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.left,
            ),
            Divider(height: ZetaSpacing.xL11),
            Text('Sharp'),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              rounded: false,
            ),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.right,
              rounded: false,
            ),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.up,
              rounded: false,
            ),
            const SizedBox(height: ZetaSpacing.xL4),
            ZetaTooltip(
              child: Text('Label'),
              arrowDirection: ZetaTooltipArrowDirection.left,
              rounded: false,
            ),
          ],
        ),
      ),
    );
  }
}
