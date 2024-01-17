import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Colors for the [ZetaButton] widget
class ZetaButtonColors extends ZetaWidgetColor {
  ///Construct [ZetaButtonColors]
  const ZetaButtonColors({
    this.actionColor,
    this.backgroundDisabled = ZetaColorBase.greyCool,
    this.foregroundDisabled = ZetaColorBase.greyWarm,
    this.borderColor = Colors.transparent,
    this.iconColor,
    super.backgroundColor = Colors.transparent,
    super.foregroundColor = Colors.black12,
  });

  ///Defines the color used when the Button is pressed
  final Color? actionColor;

  ///The color for the border when the [ZetaButton] is of type 'outlined'
  final Color borderColor;

  ///The color for the icon
  ///If color is not set, default color will be [foregroundColor]
  final Color? iconColor;

  ///Color for the [ZetaButton] when it is disabled
  final Color backgroundDisabled;

  ///Color for the [ZetaButton] icon and text when it is disabled
  final Color foregroundDisabled;
}

///Button types
enum ZetaButtonType {
  ///Standard button with background color
  filled,

  ///Button with border
  outlined,
}

///Zeta Button
class ZetaButton extends StatelessWidget {
  ///Constructs [ZetaButton]
  const ZetaButton({
    required this.label,
    required this.colors,
    this.icon,
    this.onPressed,
    this.iconOnRight = false,
    this.type = ZetaButtonType.filled,
    this.size = ZetaWidgetSize.large,
    this.borderType = BorderType.rounded,
    super.key,
  });

  ///Constructor for [ZetaButton] for type 'filled'
  factory ZetaButton.filled({
    required String label,
    required ZetaButtonColors colors,
    IconData? icon,
    VoidCallback? onPressed,
    bool iconOnRight = false,
    ZetaWidgetSize size = ZetaWidgetSize.small,
    BorderType borderType = BorderType.rounded,
  }) =>
      ZetaButton(
        label: label,
        icon: icon,
        onPressed: onPressed,
        iconOnRight: iconOnRight,
        size: size,
        colors: colors,
        borderType: borderType,
      );

  ///Constructor for [ZetaButton] for type 'outlined'
  factory ZetaButton.outlined({
    required String label,
    required ZetaButtonColors colors,
    IconData? icon,
    VoidCallback? onPressed,
    bool iconOnRight = false,
    ZetaWidgetSize size = ZetaWidgetSize.small,
    BorderType borderType = BorderType.rounded,
  }) =>
      ZetaButton(
        label: label,
        icon: icon,
        onPressed: onPressed,
        iconOnRight: iconOnRight,
        size: size,
        colors: colors,
        borderType: borderType,
        type: ZetaButtonType.outlined,
      );

  ///Button label
  final String label;

  ///The icon for the button
  final IconData? icon;

  ///Called when the button is tapped or otherwise activated.
  final VoidCallback? onPressed;

  ///Determines if the icon should be on the left or right side
  ///Defaults to 'false' (Left icon)
  final bool iconOnRight;

  ///The coloring type of the button
  final ZetaButtonType type;

  ///Colors for the button
  final ZetaButtonColors colors;

  ///Whether or not the button is sharp or rounded
  ///Defaults to rounded
  final BorderType borderType;

  ///Size of the button
  ///Defaults to large
  final ZetaWidgetSize size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: _buildButtonContent(),
    );
  }

  Widget _buildButtonContent() {
    List<Widget> children = [];
    if (icon != null) {
      children
        ..add(_buildIcon())
        ..add(const SizedBox(width: Dimensions.x2));
    }
    children.add(_buildLabel());
    if (iconOnRight) children = children.reversed.toList();
    return IntrinsicWidth(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _buildLabel() => Text(label, style: _getTextStyle());

  Widget _buildIcon() => Transform.translate(
        offset: const Offset(0, -1),
        child: Icon(
          icon,
          color: onPressed != null ? (colors.iconColor ?? colors.foregroundColor) : colors.foregroundDisabled,
          size: _iconSize(),
        ),
      );

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      minimumSize: _getButtonSize(),
      elevation: 0,
      padding: _buttonPadding(),
      shape: RoundedRectangleBorder(borderRadius: _getBorderRadius()),
    ).copyWith(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.backgroundDisabled;
          }
          return colors.backgroundColor;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return colors.foregroundDisabled;
          }
          return colors.foregroundColor;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) return colors.actionColor;
        return null;
      }),
      side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (type == ZetaButtonType.filled) return null;
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: colors.foregroundDisabled);
        }
        return BorderSide(color: colors.borderColor);
      }),
    );
  }

  BorderRadius _getBorderRadius() =>
      borderType == BorderType.rounded ? BorderRadius.circular(Dimensions.x1) : BorderRadius.zero;

  TextStyle _getTextStyle() => size == ZetaWidgetSize.small ? ZetaTextStyles.labelMedium : ZetaTextStyles.labelLarge;

  double _iconSize() => size == ZetaWidgetSize.small ? Dimensions.x4 : Dimensions.x5;

  EdgeInsets _buttonPadding() {
    if (size == ZetaWidgetSize.small) {
      return const EdgeInsets.fromLTRB(10, 6, 10, 6);
    } else if (size == ZetaWidgetSize.medium) {
      return const EdgeInsets.fromLTRB(14, 8, 14, 8);
    }
    return const EdgeInsets.fromLTRB(20, 12, 20, 12);
  }

  Size _getButtonSize() {
    if (size == ZetaWidgetSize.small) {
      return const Size(68, 32);
    } else if (size == ZetaWidgetSize.medium) {
      return const Size(82, 40);
    }
    return const Size(98, 48);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(DiagnosticsProperty<bool>('iconOnRight', iconOnRight))
      ..add(DiagnosticsProperty<ZetaButtonColors>('colors', colors))
      ..add(EnumProperty<ZetaButtonType>('type', type))
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(EnumProperty<ZetaWidgetSize>('size', size));
  }
}
