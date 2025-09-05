import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

/// A widget that displays a horizontal action menu with given action buttons.
class ActionsPanel extends StatelessWidget {
  /// Creates an [ActionsPanel] with the given [actions].
  const ActionsPanel({
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
                child: action,
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
