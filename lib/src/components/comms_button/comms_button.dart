import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Enum for the type of comms button.
enum ZetaCommsButtonType {
  /// Green background, no border, white icon
  answer,

  /// Red background, no border, white icon
  reject,

  /// Light grey background, dark grey border, black icon
  on,

  /// Dark grey background, light grey border, white icon
  off,

  /// Transparent background, red border, red icon
  security,
}

/// Comms button component.
/// This component is used to display a button for communication action. Answer, reject, mute, hold, speaker, etc.
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=20816-7765&node-type=canvas&t=nc1YR061CeZRr6IJ-0
///
/// Widgetbook:
class ZetaCommsButton extends StatefulWidget {
  /// Constructs [ZetaCommsButton]
  const ZetaCommsButton({
    super.key,
    this.label,
    this.type = ZetaCommsButtonType.on,
    this.size = ZetaWidgetSize.medium,
    this.icon,
    this.onToggle,
    this.toggledIcon,
    this.toggledLabel,
    this.toggledType,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  });

  /// Button label
  final String? label;

  /// Called when the button is toggled.
  /// If null, the button will not be toggleable.
  final VoidCallback? onToggle;

  /// Icon to display when the button is toggled.
  final IconData? toggledIcon;

  /// Label to display when the button is toggled.
  /// If null, the [label] will be used instead.
  /// If both [label] and [toggledLabel] are null, the button will not display a label.
  final String? toggledLabel;

  /// The coloring type of the button when toggled.
  /// Defaults to [ZetaCommsButtonType.on].
  final ZetaCommsButtonType? toggledType;

  /// Called when the button is tapped or otherwise activated.
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// The coloring type of the button
  final ZetaCommsButtonType type;

  /// Size of the button. Defaults to large.
  final ZetaWidgetSize size;

  /// Leading icon of button. Goes in front of button.
  final IconData? icon;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label of the button.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If this property is null, [label] will be used instead.
  final String? semanticLabel;

  @override
  State<ZetaCommsButton> createState() => _ZetaCommsButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onToggle', onToggle))
      ..add(ObjectFlagProperty<IconData?>.has('toggledIcon', toggledIcon))
      ..add(StringProperty('toggledLabel', toggledLabel))
      ..add(EnumProperty<ZetaCommsButtonType>('type', type))
      ..add(EnumProperty<ZetaCommsButtonType>('toggledType', toggledType))
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<FocusNode?>('focusNode', focusNode))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _ZetaCommsButtonState extends State<ZetaCommsButton> {
  bool isToggled = false;
  late ZetaCommsButtonType type;
  late Color iconColor = _iconColor(context, type);
  late Color backgroundColor = _backgroundColor(context, type);
  late Color borderColor = _borderColor(context, type);

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    final iconSize = _iconSize(context);
    final labelSize = _labelSize(context);

    return Semantics(
      button: true,
      label: widget.semanticLabel ?? widget.label,
      value: widget.semanticLabel ?? widget.label,
      toggled: isToggled,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filled(
            tooltip: widget.label ?? widget.semanticLabel,
            constraints: BoxConstraints(
              minWidth: _minConstraints(context),
              minHeight: _minConstraints(context),
            ),
            iconSize: iconSize,
            onPressed: () {
              if (widget.onToggle != null) {
                widget.onToggle!();
                setState(() {
                  isToggled = !isToggled;
                  if (widget.toggledType != null) {
                    type = isToggled ? widget.toggledType! : widget.type;
                    iconColor = _iconColor(context, type);
                    backgroundColor = _backgroundColor(context, type);
                    borderColor = _borderColor(context, type);
                  }
                });
              }
              if (widget.onPressed != null) {
                widget.onPressed?.call();
              }
            },
            isSelected: isToggled,
            icon: Icon(widget.icon),
            selectedIcon: Icon(widget.toggledIcon),
            style: ButtonStyle(
              iconColor: WidgetStateProperty.all(iconColor),
              backgroundColor: WidgetStateProperty.all(backgroundColor),
              side: WidgetStateProperty.all(
                BorderSide(color: borderColor, width: 2),
              ),
            ),
          ),
          if (widget.label != null)
            Text(
              isToggled
                  ? widget.toggledLabel != null
                      ? widget.toggledLabel!
                      : widget.label!
                  : widget.label!,
              style: labelSize,
            ),
        ],
      ),
    );
  }

  Color _borderColor(BuildContext context, ZetaCommsButtonType type) {
    switch (type) {
      case ZetaCommsButtonType.answer:
      case ZetaCommsButtonType.reject:
        return Colors.transparent;
      case ZetaCommsButtonType.off:
      case ZetaCommsButtonType.on:
        return Zeta.of(context).colors.borderSubtle;
      case ZetaCommsButtonType.security:
        return Zeta.of(context).colors.surfaceNegative;
    }
  }

  Color _backgroundColor(BuildContext context, ZetaCommsButtonType type) {
    switch (type) {
      case ZetaCommsButtonType.answer:
        return Zeta.of(context).colors.surfacePositive;
      case ZetaCommsButtonType.reject:
        return Zeta.of(context).colors.surfaceNegative;
      case ZetaCommsButtonType.off:
        return Zeta.of(context).colors.textDefault;
      case ZetaCommsButtonType.on:
        return Zeta.of(context).colors.textInverse;
      case ZetaCommsButtonType.security:
        return Colors.transparent;
    }
  }

  Color _iconColor(BuildContext context, ZetaCommsButtonType type) {
    switch (type) {
      case ZetaCommsButtonType.answer:
      case ZetaCommsButtonType.reject:
      case ZetaCommsButtonType.off:
        return Zeta.of(context).colors.iconInverse;
      case ZetaCommsButtonType.on:
        return Zeta.of(context).colors.iconDefault;
      case ZetaCommsButtonType.security:
        return Zeta.of(context).colors.surfaceNegative;
    }
  }

  TextStyle? _labelSize(BuildContext context) {
    switch (widget.size) {
      case ZetaWidgetSize.small:
        return Theme.of(context).textTheme.labelSmall;
      case ZetaWidgetSize.medium:
      case ZetaWidgetSize.large:
        return Theme.of(context).textTheme.labelLarge;
    }
  }

  double _iconSize(BuildContext context) {
    switch (widget.size) {
      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.xl_2;
      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.xl_4;
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.xl_6;
    }
  }

  double _minConstraints(BuildContext context) {
    switch (widget.size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.xl_10;

      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.xl_9;

      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.xl_7;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isToggled', isToggled))
      ..add(ColorProperty('iconColor', iconColor))
      ..add(ColorProperty('backgroundColor', backgroundColor))
      ..add(ColorProperty('borderColor', borderColor))
      ..add(EnumProperty<ZetaCommsButtonType>('type', type));
  }
}
