import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// An icon button to be used internally in inputs
class InputIconButton extends StatelessWidget {
  /// Creates a new [InputIconButton]
  const InputIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.disabled,
    required this.size,
    required this.color,
    this.semanticLabel,
  });

  /// The icon
  final IconData icon;

  /// On tap
  final VoidCallback onTap;

  /// {@template zeta-widget-disabled}
  ///  Disables the widget.
  /// {@endtemplate}
  final bool disabled;

  /// The size of the icon
  final ZetaWidgetSize size;

  /// The color of the icon
  final Color color;

  /// The semantic label of the icon.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  double _iconSize(BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.xl_2;
      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.xl;
      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.large;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final double iconSize = _iconSize(context);
    return Semantics(
      button: true,
      label: semanticLabel,
      enabled: !disabled,
      excludeSemantics: true,
      child: IconButton(
        padding: EdgeInsets.all(iconSize / 2),
        constraints: BoxConstraints(
          maxHeight: iconSize * 2,
          maxWidth: iconSize * 2,
          minHeight: iconSize * 2,
          minWidth: iconSize * 2,
        ),
        color: !disabled ? color : colors.iconDisabled,
        onPressed: disabled ? null : onTap,
        iconSize: iconSize,
        icon: ZetaIcon(icon),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(ColorProperty('color', color))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
