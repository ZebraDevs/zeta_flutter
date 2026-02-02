import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

import 'button_style.dart';

/// Buttons are used to trigger actions.
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23126-110945
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/button/zetabutton/button
class ZetaButton extends ZetaStatelessWidget {
  ///Constructs [ZetaButton]
  const ZetaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ZetaButtonType.primary,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  });

  /// Constructs [ZetaButton] with Primary theme.
  const ZetaButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.primary;

  /// Constructs [ZetaButton] with Secondary theme.
  @Deprecated('Secondary buttons are deprecated and will be removed in a future version.')
  const ZetaButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.secondary;

  /// Constructs [ZetaButton] with Positive theme.
  const ZetaButton.positive({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.positive;

  /// Constructs [ZetaButton] with Negative theme.
  const ZetaButton.negative({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.negative;

  /// Constructs [ZetaButton] with Outline theme.
  const ZetaButton.outline({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.outline;

  /// Constructs [ZetaButton] with Outline Subtle  theme.
  const ZetaButton.outlineSubtle({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.outlineSubtle;

  /// Constructs [ZetaButton] with text theme.
  const ZetaButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType,
    this.leadingIcon,
    this.trailingIcon,
    this.focusNode,
    this.semanticLabel,
    this.child,
  }) : type = ZetaButtonType.text;

  /// Button label
  final String label;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// The coloring type of the button
  final ZetaButtonType type;

  /// Whether or not the button is sharp or rounded
  /// Defaults to [ZetaWidgetBorder.rounded]
  final ZetaWidgetBorder? borderType;

  /// Size of the button. Defaults to large.
  final ZetaWidgetSize size;

  /// Leading icon of button. Goes in front of button.
  final IconData? leadingIcon;

  /// Trailing icon of button. Goes behind button.
  final IconData? trailingIcon;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label of the button.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If this property is null, [label] will be used instead.
  final String? semanticLabel;

  /// Child widget to display inside the button, if any.
  /// Will be placed after the leading icon and label, but before the trailing icon.
  /// This can be used to add custom widgets within the button.
  final Widget? child;

  /// Creates a clone.
  ZetaButton copyWith({
    String? label,
    VoidCallback? onPressed,
    ZetaButtonType? type,
    ZetaWidgetSize? size,
    ZetaWidgetBorder? borderType,
    IconData? leadingIcon,
    IconData? trailingIcon,
    Key? key,
  }) {
    return ZetaButton(
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      type: type ?? this.type,
      size: size ?? this.size,
      borderType: borderType ?? this.borderType,
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      key: key ?? this.key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final minConstraints = _minConstraints(context);
    final iconSize = _iconSize(context);
    final zeta = Zeta.of(context);

    // Override to sharp if in AAA contrast mode
    final contrastBorderType = zeta.contrast == ZetaContrast.aaa
        ? ZetaWidgetBorder.sharp
        : borderType ?? (context.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp);

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: semanticLabel ?? label,
      excludeSemantics: true,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minConstraints, minWidth: minConstraints),
        child: FilledButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: buttonStyle(
            context,
            contrastBorderType,
            type,
          ),
          child: SelectionContainer.disabled(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null)
                  Icon(
                    leadingIcon,
                    size: iconSize,
                  ),
                if (label.isNotEmpty)
                  Flexible(
                    child: Text(
                      label,
                      style: size == ZetaWidgetSize.small
                          ? Zeta.of(context).textStyles.labelSmall
                          : Zeta.of(context).textStyles.labelLarge,
                      textAlign: TextAlign.center,
                    ).paddingVertical(Zeta.of(context).spacing.minimum),
                  ),
                if (child != null) child!,
                if (trailingIcon != null)
                  Icon(
                    trailingIcon,
                    size: iconSize,
                  ),
              ]
                  .divide(
                    SizedBox(
                      width: Zeta.of(context).spacing.small,
                    ),
                  )
                  .toList(),
            ).paddingHorizontal(_textPadding(context)),
          ),
        ),
      ),
    );
  }

  double _minConstraints(BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.xl_8;

      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.xl_6;

      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.xl_4;
    }
  }

  double _textPadding(BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.large;

      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.medium;

      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.small;
    }
  }

  double _iconSize(BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.xl;
      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.large;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(EnumProperty<ZetaButtonType>('type', type))
      ..add(EnumProperty<ZetaWidgetBorder>('borderType', borderType))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(DiagnosticsProperty<IconData?>('leadingIcon', leadingIcon))
      ..add(DiagnosticsProperty<IconData?>('trailingIcon', trailingIcon))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
