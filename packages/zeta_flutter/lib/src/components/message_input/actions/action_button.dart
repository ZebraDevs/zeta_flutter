import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../zeta_flutter.dart';

/// Action button for the action menu in the message input
class ActionButton extends ZetaStatelessWidget {
  /// Creates an [ActionButton].
  const ActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.onLongPress,
    this.color,
    this.disabled,
    this.size,
    this.semanticLabel,
  });

  /// The icon to display.
  final IconData icon;

  /// The callback invoked when the button is pressed.
  final VoidCallback? onPressed;

  /// The callback invoked when the button is long pressed.
  final VoidCallback? onLongPress;

  /// The color of the icon. Defaults to mainDefault.
  final Color? color;

  /// Whether or not the button is disabled.
  final bool? disabled;

  /// A size override.
  final double? size;

  /// The semantic label on the icon button (used for screen readers).
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final ZetaColors colors = Zeta.of(context).colors;
    final ZetaSpacing spacing = Zeta.of(context).spacing;

    return Semantics(
      label: semanticLabel,
      child: IconButton(
        icon: Icon(
          icon,
          color: color ?? (onPressed == null || (disabled ?? false) ? colors.mainDisabled : colors.mainDefault),
          size: size ?? spacing.xl_3,
        ),
        onPressed: (disabled ?? false) ? null : onPressed,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback>.has('callback', onPressed))
      ..add(ColorProperty('color', color))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onLongPressed', onLongPress))
      ..add(DiagnosticsProperty<bool?>('disabled', disabled))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DoubleProperty('size', size));
  }
}
