import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Button Group
class ZetaButtonGroup extends StatelessWidget {
  /// Constructs [ZetaButtonGroup] from a list of [GroupButton]s
  const ZetaButtonGroup(
      {super.key,
      required this.buttons,
      required this.rounded,
      required this.isLarge,});

  /// Determines size of [GroupButton]
  final bool isLarge;

  /// Determinses border radius of [GroupButton]
  final bool rounded;

  /// [GroupButton]s to be rendered in list
  final List<GroupButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: getButtons(),
    );
  }

  /// Returns [GroupButton]s with there appropriate styling.
  List<GroupButton> getButtons() {
    for (final element in buttons) {
      element
        .._isInitial = element._isFinal = false
        .._isLarge = isLarge
        .._rounded = rounded;
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
    ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

/// Group Button item
// ignore: must_be_immutable
class GroupButton extends StatefulWidget {
  /// Constructs [GroupButton]
  GroupButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
  });

  /// Constructs dropdown group button
  GroupButton.dropdown({
    super.key,
    required this.onPressed,
    this.icon,
    this.label,
  });

  ///Constructs group button with icon
  GroupButton.icon({
    super.key,
    required this.icon,
    this.onPressed,
    this.label,
  });

  /// Label for [GroupButton]
  final String? label;

  /// Optional icon for [GroupButton]
  final IconData? icon;

  /// Function for when [GroupButton] is clicked.
  final VoidCallback? onPressed;

  ///If [GroupButton] is large
  bool _isLarge = false;

  ///If [GroupButton] is rounded
  bool _rounded = false;

  /// If [GroupButton] is the first button in its list.
  bool _isInitial = false;

  /// If [GroupButton] is the final button in its list.
  bool _isFinal = false;

  @override
  State<GroupButton> createState() => _GroupButtonState();

  /// Returns copy of [GroupButton] with fields.
  GroupButton copyWith({bool? isFinal, bool? isInitial}) {
    return GroupButton(
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

class _GroupButtonState extends State<GroupButton> {
  late bool selected;
  late MaterialStatesController controller;

  @override
  void initState() {
    super.initState();
    selected = false;
    controller = MaterialStatesController();
  }

  void onPressed() {
    if(widget.onPressed != null){
      widget.onPressed?.call();
    setState(() {
      selected = !selected;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final borderType =
        widget._rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp;

    final BorderSide borderSide =
        _getBorderSide(controller.value, colors, false);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: borderSide,
          left: borderSide,
          bottom: borderSide,
          right: (widget._isFinal) ? borderSide : BorderSide.none,
        ),
        borderRadius: _getRadius(borderType),
      ),
      padding: EdgeInsets.zero,
      child: FilledButton(
        statesController: controller,
        onPressed: onPressed,
        style: getStyle(borderType, colors),
        child: SelectionContainer.disabled(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) Icon(widget.icon),
              Text(widget.label!),
              if (widget.onPressed != null)
                const Icon(ZetaIcons.expand_more_round),
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
    if(selected) return BorderSide(color: colors.black);
    if (states.contains(MaterialState.disabled)) {
      return BorderSide(color: colors.cool.shade40);
    }
    if (states.contains(MaterialState.focused)) {
      return BorderSide(color: colors.blue, width: ZetaSpacing.x0_5);
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
        if (selected) return colors.black;

        if (states.contains(MaterialState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (states.contains(MaterialState.pressed)) {
          return colors.primary.shade10;
        }
        if (states.contains(MaterialState.hovered)) {
          return colors.cool.shade20;
        }
        return colors.white;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return colors.textDisabled;
        }
        if (selected) return colors.black.onColor;
        return colors.textDefault;
      }),
      elevation: const MaterialStatePropertyAll(0),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(
        DiagnosticsProperty<MaterialStatesController>('controller', controller),
      );
  }
}
