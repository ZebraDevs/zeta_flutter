import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

import 'button_style.dart';

/// Component [ZetaIconButton]
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23126-110314
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/button/zetaiconbutton/icon-button
class ZetaIconButton extends ZetaStatelessWidget {
  /// Constructor for [ZetaIconButton]
  const ZetaIconButton({
    super.key,
    super.rounded,
    this.onPressed,
    this.borderType,
    this.type = ZetaButtonType.primary,
    this.size = ZetaWidgetSize.medium,
    this.icon = ZetaIcons.more_horizontal,
    this.semanticLabel,
  });

  /// Constructs [ZetaIconButton] with Primary theme.
  const ZetaIconButton.primary({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.semanticLabel,
  }) : type = ZetaButtonType.primary;

  /// Constructs [ZetaIconButton] with Secondary theme.
  @Deprecated('Secondary buttons are deprecated and will be removed in a future version.')
  const ZetaIconButton.secondary({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.semanticLabel,
  }) : type = ZetaButtonType.secondary;

  /// Constructs [ZetaIconButton] with Positive theme.
  const ZetaIconButton.positive({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.semanticLabel,
  }) : type = ZetaButtonType.positive;

  /// Constructs [ZetaIconButton] with Negative theme.
  const ZetaIconButton.negative({
    super.key,
    super.rounded,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    required this.icon,
    this.semanticLabel,
  }) : type = ZetaButtonType.negative;

  /// Constructs [ZetaIconButton] with Outline theme.
  const ZetaIconButton.outline({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.semanticLabel,
  }) : type = ZetaButtonType.outline;

  /// Constructs [ZetaIconButton] with Outline Subtle  theme.
  const ZetaIconButton.outlineSubtle({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.semanticLabel,
  }) : type = ZetaButtonType.outlineSubtle;

  /// Constructs [ZetaIconButton] with text theme.
  const ZetaIconButton.text({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.semanticLabel,
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

  /// A semantic description of the button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: Semantics(
        label: semanticLabel,
        child: FilledButton(
          onPressed: onPressed,
          style: buttonStyle(
            context,
            borderType ?? (context.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp),
            type,
          ),
          child: SelectionContainer.disabled(
            child: Icon(icon, size: _iconSize(context)).paddingAll(_iconPadding(context)),
          ),
        ),
      ),
    );
  }

  double _iconPadding(BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.medium;
      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.small;
      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.minimum;
    }
  }

  double _iconSize(BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.xl_2;
      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.xl_2;
      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.xl;
    }
  }

  ZetaIconButton copyWith({ZetaButtonType? type}) {
    return ZetaIconButton(
      key: key,
      rounded: rounded,
      onPressed: onPressed,
      borderType: borderType,
      type: type ?? this.type,
      size: size,
      icon: icon,
      semanticLabel: semanticLabel,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(EnumProperty<ZetaWidgetBorder>('borderType', borderType))
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(EnumProperty<ZetaButtonType>('type', type))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
