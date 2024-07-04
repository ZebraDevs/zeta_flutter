import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Component [ZetaIconButton]
class ZetaIconButton extends ZetaStatelessWidget {
  /// Constructor for [ZetaIconButton]
  const ZetaIconButton({
    super.key,
    this.onPressed,
    this.borderType,
    this.type = ZetaButtonType.primary,
    this.size = ZetaWidgetSize.medium,
    this.icon = ZetaIcons.more_horizontal,
  });

  /// Constructs [ZetaIconButton] with Primary theme.
  const ZetaIconButton.primary({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
  }) : type = ZetaButtonType.primary;

  /// Constructs [ZetaIconButton] with Secondary theme.
  const ZetaIconButton.secondary({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
  }) : type = ZetaButtonType.secondary;

  /// Constructs [ZetaIconButton] with Positive theme.
  const ZetaIconButton.positive({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
  }) : type = ZetaButtonType.positive;

  /// Constructs [ZetaIconButton] with Negative theme.
  const ZetaIconButton.negative({
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    required this.icon,
    super.key,
  }) : type = ZetaButtonType.negative;

  /// Constructs [ZetaIconButton] with Outline theme.
  const ZetaIconButton.outline({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
  }) : type = ZetaButtonType.outline;

  /// Constructs [ZetaIconButton] with Outline Subtle  theme.
  const ZetaIconButton.outlineSubtle({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
  }) : type = ZetaButtonType.outlineSubtle;

  /// Constructs [ZetaIconButton] with text theme.
  const ZetaIconButton.text({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
  }) : type = ZetaButtonType.text;

  /// Button icon.
  final IconData icon;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// The coloring type of the button
  final ZetaButtonType type;

  /// Whether or not the button is sharp or rounded
  /// Defaults to rounded
  final ZetaWidgetBorder? borderType;

  /// Size of the button. Defaults to large.
  final ZetaWidgetSize size;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return FilledButton(
      onPressed: onPressed,
      style: buttonStyle(
        colors,
        borderType ?? (context.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp),
        type,
        null,
      ),
      child: SelectionContainer.disabled(child: ZetaIcon(icon, size: _iconSize).paddingAll(_iconPadding)),
    );
  }

  double get _iconPadding {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.medium;
      case ZetaWidgetSize.medium:
        return ZetaSpacing.small;
      case ZetaWidgetSize.small:
        return ZetaSpacing.minimum;
    }
  }

  double get _iconSize {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.xl_2;
      case ZetaWidgetSize.medium:
        return ZetaSpacing.xl_2;
      case ZetaWidgetSize.small:
        return ZetaSpacing.xl_1;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(EnumProperty<ZetaWidgetBorder>('borderType', borderType))
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(EnumProperty<ZetaButtonType>('type', type));
  }
}
