import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta Button
class ZetaButton extends StatelessWidget {
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
    final colors = Zeta.of(context).colors;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _minConstraints, minWidth: _minConstraints),
      child: FilledButton(
        focusNode: focusNode,
        onPressed: onPressed,
        style: buttonStyle(
          colors,
          borderType ?? (context.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp),
          type,
          null,
        ),
        child: SelectionContainer.disabled(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null)
                ZetaIcon(
                  leadingIcon,
                  size: _iconSize,
                ),
              if (label.isNotEmpty)
                Text(
                  label,
                  style: _textStyle,
                ),
              if (trailingIcon != null)
                ZetaIcon(
                  trailingIcon,
                  size: _iconSize,
                ),
            ]
                .divide(
                  const SizedBox(
                    width: ZetaSpacing.small,
                  ),
                )
                .toList(),
          ).paddingHorizontal(_textPadding),
        ),
      ),
    );
  }

  TextStyle get _textStyle => size == ZetaWidgetSize.small ? ZetaTextStyles.labelSmall : ZetaTextStyles.labelLarge;

  double get _minConstraints {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.xl_8;

      case ZetaWidgetSize.medium:
        return ZetaSpacing.xl_6;

      case ZetaWidgetSize.small:
        return ZetaSpacing.xl_4;
    }
  }

  double get _textPadding {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.large;

      case ZetaWidgetSize.medium:
        return ZetaSpacing.medium;

      case ZetaWidgetSize.small:
        return ZetaSpacing.minimum;
    }
  }

  double get _iconSize {
    switch (size) {
      case ZetaWidgetSize.large:
      case ZetaWidgetSize.medium:
        return ZetaSpacing.xl_1;
      case ZetaWidgetSize.small:
        return ZetaSpacing.large;
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
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode));
  }
}
