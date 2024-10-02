import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Enum for the type of comms button.
enum ZetaCommsButtonType {
  /// Green background, no border, white icon.
  positive,

  /// Red background, no border, white icon.
  negative,

  /// Light grey background, dark grey border, black icon.
  on,

  /// Dark grey background, light grey border, white icon.
  off,

  /// White background, red border, red icon.
  warning,
}

/// Comms button component.
/// This component is used to display a button for communication action. Answer, reject, mute, hold, speaker, etc.
///
/// Use the constructors to create preconfigured comms buttons.
///
/// `ZetaCommsButton.answer()`, `ZetaCommsButton.reject()`, `ZetaCommsButton.mute()`,
/// `ZetaCommsButton.hold()`, `ZetaCommsButton.speaker()`, `ZetaCommsButton.record()`, etc.
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=20816-7765&node-type=canvas&t=nc1YR061CeZRr6IJ-0
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/comms-button
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

  /// Constructs answer call [ZetaCommsButton]
  const ZetaCommsButton.answer({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.positive,
        icon = ZetaIcons.phone,
        onToggle = null,
        toggledIcon = null,
        toggledLabel = null,
        toggledType = null;

  /// Constructs reject call [ZetaCommsButton]
  const ZetaCommsButton.reject({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.negative,
        icon = ZetaIcons.end_call,
        onToggle = null,
        toggledIcon = null,
        toggledLabel = null,
        toggledType = null;

  /// Constructs mute [ZetaCommsButton]
  const ZetaCommsButton.mute({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onToggle,
    this.toggledLabel,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.microphone,
        toggledIcon = ZetaIcons.microphone_off,
        toggledType = ZetaCommsButtonType.off;

  /// Constructs video [ZetaCommsButton]
  const ZetaCommsButton.video({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onToggle,
    this.toggledLabel,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.video,
        toggledIcon = ZetaIcons.video_off,
        toggledType = ZetaCommsButtonType.off;

  /// Constructs transfer [ZetaCommsButton]
  const ZetaCommsButton.transfer({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.forward,
        onToggle = null,
        toggledIcon = null,
        toggledLabel = null,
        toggledType = null;

  /// Constructs hold [ZetaCommsButton]
  const ZetaCommsButton.hold({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onToggle,
    this.toggledLabel,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.pause,
        toggledIcon = ZetaIcons.pause,
        toggledType = ZetaCommsButtonType.off;

  /// Constructs speaker [ZetaCommsButton]
  const ZetaCommsButton.speaker({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onToggle,
    this.toggledLabel,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.volume_up,
        toggledIcon = ZetaIcons.volume_off,
        toggledType = ZetaCommsButtonType.off;

  /// Constructs record [ZetaCommsButton]
  const ZetaCommsButton.record({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onToggle,
    this.toggledLabel,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.recording,
        toggledIcon = ZetaIcons.stop,
        toggledType = ZetaCommsButtonType.off;

  /// Constructs add [ZetaCommsButton]
  const ZetaCommsButton.add({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.on,
        icon = ZetaIcons.add_group,
        onToggle = null,
        toggledIcon = null,
        toggledLabel = null,
        toggledType = null;

  /// Constructs security [ZetaCommsButton]
  const ZetaCommsButton.security({
    super.key,
    this.label,
    this.size = ZetaWidgetSize.medium,
    this.onPressed,
    this.focusNode,
    this.semanticLabel,
  })  : type = ZetaCommsButtonType.warning,
        icon = ZetaIcons.alert_active,
        onToggle = null,
        toggledIcon = null,
        toggledLabel = null,
        toggledType = null;

  /// Comms button label
  final String? label;

  /// Called when the comms button is toggled.
  /// If null, the comms button will not be toggleable.
  final ValueChanged<bool>? onToggle;

  /// Icon to display when the comms button is toggled.
  final IconData? toggledIcon;

  /// Label to display when the comms button is toggled.
  /// If null, the [label] will be used instead.
  /// If both [label] and [toggledLabel] are null, the comms button will not display a label.
  final String? toggledLabel;

  /// The coloring type of the comms button when toggled.
  /// Defaults to [ZetaCommsButtonType.on].
  final ZetaCommsButtonType? toggledType;

  /// Called when the comms button is tapped or otherwise activated.
  ///
  /// {@macro zeta-widget-change-disable}
  final VoidCallback? onPressed;

  /// The coloring type of the comms button
  final ZetaCommsButtonType type;

  /// Size of the comms button. Defaults to [ZetaWidgetSize.medium].
  final ZetaWidgetSize size;

  /// Icon of comms button. Goes in centre of button.
  final IconData? icon;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// The semantic label of the comms button.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If this property is null, [label] or [toggledLabel] will be used instead.
  final String? semanticLabel;

  @override
  State<ZetaCommsButton> createState() => _ZetaCommsButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(ObjectFlagProperty<ValueChanged<bool>?>.has('onToggle', onToggle))
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
      label: widget.semanticLabel ?? (isToggled ? widget.toggledLabel : widget.label),
      toggled: isToggled,
      excludeSemantics: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton.filled(
            constraints: BoxConstraints(
              minWidth: _minConstraints(context),
              minHeight: _minConstraints(context),
            ),
            iconSize: iconSize,
            onPressed: () {
              if (widget.onToggle != null) {
                widget.onToggle!(isToggled);
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
              widget.onPressed?.call();
            },
            isSelected: isToggled,
            icon: Icon(
              widget.icon,
              semanticLabel: isToggled ? widget.toggledLabel : widget.label,
            ),
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

  /// Gets the border color based on the type
  Color _borderColor(BuildContext context, ZetaCommsButtonType type) {
    switch (type) {
      case ZetaCommsButtonType.positive:
      case ZetaCommsButtonType.negative:
        return Zeta.of(context).colors.surfaceDefault;
      case ZetaCommsButtonType.off:
      case ZetaCommsButtonType.on:
        return Zeta.of(context).colors.borderSubtle;
      case ZetaCommsButtonType.warning:
        return Zeta.of(context).colors.surfaceNegative;
    }
  }

  /// Gets the background color based on the type
  Color _backgroundColor(BuildContext context, ZetaCommsButtonType type) {
    switch (type) {
      case ZetaCommsButtonType.positive:
        return Zeta.of(context).colors.surfacePositive;
      case ZetaCommsButtonType.negative:
        return Zeta.of(context).colors.surfaceNegative;
      case ZetaCommsButtonType.off:
        return Zeta.of(context).colors.textDefault;
      case ZetaCommsButtonType.on:
        return Zeta.of(context).colors.textInverse;
      case ZetaCommsButtonType.warning:
        return Zeta.of(context).colors.surfaceDefault;
    }
  }

  /// Gets the icon color based on the type
  Color _iconColor(BuildContext context, ZetaCommsButtonType type) {
    switch (type) {
      case ZetaCommsButtonType.positive:
      case ZetaCommsButtonType.negative:
      case ZetaCommsButtonType.off:
        return Zeta.of(context).colors.iconInverse;
      case ZetaCommsButtonType.on:
        return Zeta.of(context).colors.iconDefault;
      case ZetaCommsButtonType.warning:
        return Zeta.of(context).colors.surfaceNegative;
    }
  }

  /// Gets the label size
  TextStyle? _labelSize(BuildContext context) {
    switch (widget.size) {
      case ZetaWidgetSize.small:
        return Theme.of(context).textTheme.labelSmall;
      case ZetaWidgetSize.medium:
      case ZetaWidgetSize.large:
        return Theme.of(context).textTheme.labelLarge;
    }
  }

  /// Gets the icon size
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

  /// Gets the minimum constraints to set the size of the button
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
