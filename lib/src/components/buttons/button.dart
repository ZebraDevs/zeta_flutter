import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Button
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23126-110945
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/buttons/button
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
  }) : type = ZetaButtonType.primary;

  /// Constructs [ZetaButton] with Secondary theme.
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
            borderType ?? (context.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp),
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
                      style: _textStyle,
                      textAlign: TextAlign.center,
                    ).paddingVertical(Zeta.of(context).spacing.minimum),
                  ),
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

  TextStyle get _textStyle => size == ZetaWidgetSize.small ? ZetaTextStyles.labelSmall : ZetaTextStyles.labelLarge;

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
