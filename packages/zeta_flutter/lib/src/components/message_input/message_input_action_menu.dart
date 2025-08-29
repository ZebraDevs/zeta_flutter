
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// A widget that displays a horizontal action menu with given action buttons.
class MessageInputActionMenu extends StatelessWidget {
  const MessageInputActionMenu({
    super.key,
    required this.actions,
  });

  final List<IconButton> actions;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return ColoredBox(
      color: colors.surfaceDefault,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: actions
              .map(
                (action) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: spacing.small,
                  ),
                  child: IconButton(
                    icon: action.icon,
                    onPressed: action.onPressed,
                    iconSize: spacing.xl_3,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
