import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Button Group
class ZetaButtonGroup extends StatelessWidget {
  /// Constructs [ZetaButtonGroup] from a list of [ZetaGroupButton]s
  const ZetaButtonGroup({
    super.key,
    required this.buttons,
    required this.rounded,
    required this.isLarge,
    this.isInverse = false,
  });

  /// Determines size of [ZetaGroupButton].
  final bool isLarge;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// [ZetaGroupButton]s to be rendered in list.
  final List<ZetaGroupButton> buttons;

  /// If widget should be rendered in inverted colors.
  final bool isInverse;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: getButtons(),
    );
  }

  /// Returns [ZetaGroupButton]s with there appropriate styling.
  List<ZetaGroupButton> getButtons() {
    for (final element in buttons) {
      element
        .._isInitial = element._isFinal = false
        .._isLarge = isLarge
        .._rounded = rounded
        .._isInverse = isInverse;
    }

    buttons.first._isInitial = true;
    buttons.last._isFinal = true;

    return buttons;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isLarge', isLarge))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('isInverse', isInverse));
  }
}

// TODO(UX-854): Create country variant.

/// Group Button item
// ignore: must_be_immutable
class ZetaGroupButton extends StatefulWidget {
  /// Constructs [ZetaGroupButton]
  ZetaGroupButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.dropdown,
  });

  /// Constructs dropdown group button
  ZetaGroupButton.dropdown({
    super.key,
    required this.onPressed,
    required this.dropdown,
    this.icon,
    this.label,
  });

  ///Constructs group button with icon
  ZetaGroupButton.icon({
    super.key,
    required this.icon,
    this.dropdown,
    this.onPressed,
    this.label,
  });

  /// Label for [ZetaGroupButton].
  final String? label;

  /// Optional icon for [ZetaGroupButton].
  final IconData? icon;

  /// Function for when [ZetaGroupButton] is clicked.
  final VoidCallback? onPressed;

  /// Content of dropdown.
  final Widget? dropdown;

  ///If [ZetaGroupButton] is large.
  bool _isLarge = false;

  ///If [ZetaGroupButton] is rounded.
  bool _rounded = false;

  /// If [ZetaGroupButton] is the first button in its list.
  bool _isInitial = false;

  /// If [ZetaGroupButton] is the final button in its list.
  bool _isFinal = false;

  bool _isInverse = false;

  @override
  State<ZetaGroupButton> createState() => _ZetaGroupButtonState();

  /// Returns copy of [ZetaGroupButton] with fields.
  ZetaGroupButton copyWith({bool? isFinal, bool? isInitial}) {
    return ZetaGroupButton(
      key: key,
      label: label,
      icon: icon,
      onPressed: onPressed,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('Label', label))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed));
  }
}

class _ZetaGroupButtonState extends State<ZetaGroupButton> {
  late MaterialStatesController controller;

  @override
  void initState() {
    super.initState();
    controller = MaterialStatesController();
    controller.addListener(() {
      if (!controller.value.contains(MaterialState.disabled) && context.mounted && mounted) {
        // TODO(UX-1005): setState causing exception when going from disabled to enabled.
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final borderType = widget._rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp;

    final BorderSide borderSide = _getBorderSide(controller.value, colors, false);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: borderSide,
          left: borderSide,
          bottom: borderSide,
          right: controller.value.contains(MaterialState.focused)
              ? BorderSide(color: colors.blue.shade50, width: 2)
              : (widget._isFinal)
                  ? borderSide
                  : BorderSide.none,
        ),
        borderRadius: _getRadius(borderType),
      ),
      padding: EdgeInsets.zero,
      child: FilledButton(
        statesController: controller,
        onPressed: widget.onPressed, // TODO(UX-1006): Dropdown
        style: getStyle(borderType, colors),
        child: SelectionContainer.disabled(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) Icon(widget.icon),
              Text(widget.label!),
              if (widget.dropdown != null) // TODO(UX-1006): Dropdown
                Icon(widget._rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp, size: 20),
            ],
          ).paddingAll(_padding),
        ),
      ),
    );
  }

  double get _padding => widget._isLarge ? ZetaSpacing.x4 : ZetaSpacing.x3;

  BorderSide _getBorderSide(
    Set<MaterialState> states,
    ZetaColors colors,
    bool finalButton,
  ) {
    if (states.contains(MaterialState.focused)) {
      return BorderSide(color: colors.blue.shade50, width: ZetaSpacing.x0_5);
    }
    if (widget._isInverse) return BorderSide(color: colors.black);
    if (states.contains(MaterialState.disabled)) {
      return BorderSide(color: colors.cool.shade40);
    }
    return BorderSide(
      color: finalButton ? colors.borderDefault : colors.borderSubtle,
    );
  }

  BorderRadius _getRadius(ZetaWidgetBorder borderType) {
    if (widget._isInitial) {
      return borderType.radius.copyWith(
        topRight: Radius.zero,
        bottomRight: Radius.zero,
      );
    }
    if (widget._isFinal) {
      return borderType.radius.copyWith(
        topLeft: Radius.zero,
        bottomLeft: Radius.zero,
      );
    }
    return ZetaRadius.none;
  }

  ButtonStyle getStyle(ZetaWidgetBorder borderType, ZetaColors colors) {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: _getRadius(borderType),
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (widget._isInverse) return colors.cool.shade100;

        if (states.contains(MaterialState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (states.contains(MaterialState.pressed)) {
          return colors.primary.shade10;
        }
        if (states.contains(MaterialState.hovered)) {
          return colors.cool.shade20;
        }
        return colors.surfacePrimary;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return colors.textDisabled;
        }
        if (widget._isInverse) return colors.cool.shade100.onColor;
        return colors.textDefault;
      }),
      elevation: const MaterialStatePropertyAll(0),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<MaterialStatesController>('controller', controller));
  }
}
