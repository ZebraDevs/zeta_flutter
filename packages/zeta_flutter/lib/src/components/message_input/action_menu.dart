import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// A widget that displays a horizontal action menu with given action buttons.
class ActionMenu extends StatelessWidget {
  /// Creates an [ActionMenu] with the given [actions].
  const ActionMenu({
    super.key,
    required this.actions,
  });

  /// The list of action buttons to display in the menu.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return ColoredBox(
      color: colors.surfaceDefault,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: actions.map(
            (action) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: spacing.small,
                ),
                child: action is IconButton
                    ? IconButton(
                        icon: action.icon,
                        onPressed: action.onPressed,
                        iconSize: spacing.xl_3,
                      )
                    : action,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
