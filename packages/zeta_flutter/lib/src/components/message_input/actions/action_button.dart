import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

/// Action button for the action menu in the message input
class ActionButton extends StatelessWidget {
  /// Creates an [ActionButton].
  const ActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.onLongPress,
    this.color,
  });

  /// The icon to display.
  final IconData icon;

  /// The callback invoked when the button is pressed.
  final VoidCallback? onPressed;

  /// The callback invoked when the button is long pressed.
  final VoidCallback? onLongPress;

  /// The color of the icon. Defaults to mainDefault.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return IconButton(
      icon: ZetaIcon(
        icon,
        color: color ?? (onPressed != null ? colors.mainDefault : colors.mainDisabled),
        size: spacing.xl_3,
      ),
      onPressed: onPressed,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback>.has('callback', onPressed))
      ..add(ColorProperty('color', color))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onLongPressed', onLongPress));
  }
}
