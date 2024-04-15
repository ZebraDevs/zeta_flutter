import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta Button
class ZetaButton extends StatelessWidget {
  ///Constructs [ZetaButton]
  const ZetaButton({
    required this.label,
    this.onPressed,
    this.type = ZetaButtonType.primary,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  });

  /// Constructs [ZetaButton] with Primary theme.
  const ZetaButton.primary({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.primary;

  /// Constructs [ZetaButton] with Secondary theme.
  const ZetaButton.secondary({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.secondary;

  /// Constructs [ZetaButton] with Positive theme.
  const ZetaButton.positive({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.positive;

  /// Constructs [ZetaButton] with Negative theme.
  const ZetaButton.negative({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.negative;

  /// Constructs [ZetaButton] with Outline theme.
  const ZetaButton.outline({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.outline;

  /// Constructs [ZetaButton] with Outline Subtle  theme.
  const ZetaButton.outlineSubtle({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.outlineSubtle;

  /// Constructs [ZetaButton] with text theme.
  const ZetaButton.text({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    this.zeta,
    super.key,
  }) : type = ZetaButtonType.text;

  ///Button label
  final String label;

  ///Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  ///The coloring type of the button
  final ZetaButtonType type;

  ///Whether or not the button is sharp or rounded
  ///Defaults to rounded
  final ZetaWidgetBorder borderType;

  /// Size of the button. Defaults to large.
  final ZetaWidgetSize size;

  /// Sometimes we need to pass Zeta from outside,
  /// like for example from [showZetaDialog]
  final Zeta? zeta;

  /// Creates a clone.
  ZetaButton copyWith({
    String? label,
    VoidCallback? onPressed,
    ZetaButtonType? type,
    ZetaWidgetSize? size,
    ZetaWidgetBorder? borderType,
    Key? key,
  }) {
    return ZetaButton(
      label: label ?? this.label,
      onPressed: onPressed ?? this.onPressed,
      type: type ?? this.type,
      size: size ?? this.size,
      borderType: borderType ?? this.borderType,
      zeta: zeta,
      key: key ?? this.key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final zeta = this.zeta ?? Zeta.of(context);
    final colors = zeta.colors;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _minConstraints, minWidth: _minConstraints),
      child: FilledButton(
        onPressed: onPressed,
        style: buttonStyle(colors, borderType, type, null),
        child: SelectionContainer.disabled(
          child: label.isEmpty
              ? const SizedBox()
              : Text(
                  label,
                  style: _textStyle,
                ).paddingHorizontal(_textPadding),
        ),
      ),
    );
  }

  TextStyle get _textStyle => size == ZetaWidgetSize.small ? ZetaTextStyles.labelSmall : ZetaTextStyles.labelLarge;

  double get _minConstraints {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.x12;

      case ZetaWidgetSize.medium:
        return ZetaSpacing.x10;

      case ZetaWidgetSize.small:
        return ZetaSpacing.x8;
    }
  }

  double get _textPadding {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.m;

      case ZetaWidgetSize.medium:
        return ZetaSpacing.x3_5;

      case ZetaWidgetSize.small:
        return ZetaSpacing.x2_5;
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
      ..add(EnumProperty<ZetaWidgetSize>('size', size));
  }
}
