import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Button types
enum ZetaButtonType {
  /// Background: Primary color; defaults to blue.
  /// Border: None.
  primary,

  /// Background: Secondary color; defaults to yellow.
  /// Border: None.
  secondary,

  /// Background: Positive color; defaults to green.
  /// Border: None.
  positive,

  /// Background: Negative color; defaults to red.
  /// Border: None.
  negative,

  /// Background: None.
  /// Border: Primary color; defaults to blue.
  outline,

  /// Background: None.
  /// Border: Subtle color; defaults to cool grey.
  outlineSubtle,

  /// Background: None.
  /// Border: None.
  /// Foreground color: Primary; defaults to blue.
  text,
}

extension on ZetaButtonType {
  ZetaColorSwatch color(ZetaColors colors) {
    switch (this) {
      case ZetaButtonType.secondary:
        return colors.secondary;
      case ZetaButtonType.positive:
        return colors.positive;
      case ZetaButtonType.negative:
        return colors.negative;
      case ZetaButtonType.outline:
      case ZetaButtonType.primary:
        return colors.primary;
      case ZetaButtonType.outlineSubtle:
      case ZetaButtonType.text:
        return colors.cool;
    }
  }

  bool get border => this == ZetaButtonType.outline || this == ZetaButtonType.outlineSubtle;
  bool get solid => index < 4;
}

extension on ZetaWidgetBorder {
  BorderRadius get radius {
    switch (this) {
      case ZetaWidgetBorder.sharp:
        return ZetaRadius.none;
      case ZetaWidgetBorder.rounded:
        return ZetaRadius.minimal;
      case ZetaWidgetBorder.full:
        return ZetaRadius.full;
    }
  }
}

///Zeta Button
class ZetaButton extends StatelessWidget {
  ///Constructs [ZetaButton]
  const ZetaButton({
    required this.label,
    this.onPressed,
    this.type = ZetaButtonType.primary,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  });

  /// Constructs [ZetaButton] with Primary theme.
  const ZetaButton.primary({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  }) : type = ZetaButtonType.primary;

  /// Constructs [ZetaButton] with Secondary theme.
  const ZetaButton.secondary({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  }) : type = ZetaButtonType.secondary;

  /// Constructs [ZetaButton] with Positive theme.
  const ZetaButton.positive({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  }) : type = ZetaButtonType.positive;

  /// Constructs [ZetaButton] with Negative theme.
  const ZetaButton.negative({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  }) : type = ZetaButtonType.negative;

  /// Constructs [ZetaButton] with Outline theme.
  const ZetaButton.outline({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  }) : type = ZetaButtonType.outline;

  /// Constructs [ZetaButton] with Outline Subtle  theme.
  const ZetaButton.outlineSubtle({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
    super.key,
  }) : type = ZetaButtonType.outlineSubtle;

  /// Constructs [ZetaButton] with text theme.
  const ZetaButton.text({
    required this.label,
    this.onPressed,
    this.size = ZetaWidgetSize.medium,
    this.borderType = ZetaWidgetBorder.rounded,
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
      key: key ?? this.key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: _minConstraints, minWidth: _minConstraints),
      child: FilledButton(
        onPressed: onPressed,
        style: _buttonStyle(colors),
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

  ButtonStyle _buttonStyle(ZetaColors colors) {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size.square(32)),
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: borderType.radius)),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.surfaceDisabled;
          }
          if (states.contains(MaterialState.pressed)) {
            return type.solid ? type.color(colors).shade70 : colors.primary.shade10;
          }
          if (states.contains(MaterialState.hovered)) {
            return type.solid ? type.color(colors).shade50 : colors.cool.shade20;
          }
          return type.solid ? type.color(colors) : Colors.transparent;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.textDisabled;
          }
          switch (type) {
            case ZetaButtonType.outline:
            case ZetaButtonType.text:
              return colors.primary;
            case ZetaButtonType.outlineSubtle:
              return colors.textDefault;
            case ZetaButtonType.primary:
            case ZetaButtonType.secondary:
            case ZetaButtonType.positive:
            case ZetaButtonType.negative:
              return type.color(colors).onColor;
          }
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        return null;
      }),
      side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (type.border && states.contains(MaterialState.disabled)) {
          return BorderSide(color: colors.cool.shade40);
        }
        // TODO(thelukewalton): This removes a defualt border when focused, rather than adding a second border when focused.
        if (states.contains(MaterialState.focused)) {
          return BorderSide(color: colors.blue, width: ZetaSpacing.x0_5);
        }
        if (type.border) {
          return BorderSide(color: type == ZetaButtonType.outline ? colors.primary.border : colors.borderDefault);
        }

        return null;
      }),
      elevation: const MaterialStatePropertyAll(0),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    );
  }

  TextStyle get _textStyle => size == ZetaWidgetSize.small ? ZetaTextStyles.labelMedium : ZetaTextStyles.labelLarge;

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
