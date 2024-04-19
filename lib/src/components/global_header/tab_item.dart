import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

class ZetaTabItem extends StatefulWidget {
  const ZetaTabItem({super.key});

  @override
  State<ZetaTabItem> createState() => _ZetaTabItemState();
}

class _ZetaTabItemState extends State<ZetaTabItem> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    var colors = Zeta.of(context).colors;

    final foregroundColor = active ? colors.textSubtle : colors.primary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            active = !active;
          });
        },
        child: Row(
          children: [
            Text(
              'Button',
              style: TextStyle(color: foregroundColor),
            ),
            const SizedBox(
              width: ZetaSpacing.x2,
            ),
            Icon(
              ZetaIcons.expand_more_round,
              color: foregroundColor,
            )
          ],
        ),
      ),
    );
  }
}
