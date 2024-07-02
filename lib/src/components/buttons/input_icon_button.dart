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

  double get _iconSize {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.xl_2;
      case ZetaWidgetSize.medium:
        return ZetaSpacing.xl_1;
      case ZetaWidgetSize.small:
        return ZetaSpacing.large;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return IconButton(
      padding: EdgeInsets.all(_iconSize / 2),
      constraints: BoxConstraints(
        maxHeight: _iconSize * 2,
        maxWidth: _iconSize * 2,
        minHeight: _iconSize * 2,
        minWidth: _iconSize * 2,
      ),
      color: !disabled ? color : colors.iconDisabled,
      onPressed: disabled ? null : onTap,
      iconSize: _iconSize,
      icon: ZetaIcon(icon),
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
      ..add(EnumProperty<ZetaWidgetSize>('size', size));
  }
}
