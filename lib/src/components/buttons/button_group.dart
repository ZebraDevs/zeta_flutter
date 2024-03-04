<<<<<<< HEAD
import 'package:flutter/foundation.dart';
=======
>>>>>>> d72661e (Initial version, no border customization)
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

<<<<<<< HEAD
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
=======
class ZetaButtonGroup extends StatelessWidget {
  const ZetaButtonGroup({
    super.key,
    required this.buttons,
  });

>>>>>>> d72661e (Initial version, no border customization)
  final List<GroupButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
<<<<<<< HEAD
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
    ..add(DiagnosticsProperty<bool>('rounded', rounded))
    ;
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
    this.onPress,
  });

  /// Constructs dropdown group button
  GroupButton.dropdown({
    super.key,
    required this.onPress,
    this.icon,
    this.label,
  });

  ///Constructs group button with icon
  GroupButton.icon({
    super.key,
    required this.icon,
    this.onPress,
    this.label,
  });

  /// Label for [GroupButton]
  final String? label;

  /// Optional icon for [GroupButton]
  final IconData? icon;

  /// Function for when [GroupButton] is clicked.
  final VoidCallback? onPress;

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
      onPress: onPress,
      // isFinal: isFinal ?? this.isFinal,
      // isInitial: isInitial ?? this.isInitial,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('Label', label))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPress', onPress));
  }
=======
      children: buttons,
    );
  }
}

class GroupButton extends StatefulWidget {
  const GroupButton(
      {super.key,
      required this.isLarge,
      required this.rounded,
      this.label,
      this.icon,
      this.onExpand,
      this.controller});

  final bool isLarge;

  final bool rounded;

  final String? label;

  final IconData? icon;

  final VoidCallback? onExpand;

  final MaterialStatesController? controller;

  @override
  State<GroupButton> createState() => _GroupButtonState();
>>>>>>> d72661e (Initial version, no border customization)
}

class _GroupButtonState extends State<GroupButton> {
  late bool selected;
<<<<<<< HEAD
  late MaterialStatesController controller;
=======
>>>>>>> d72661e (Initial version, no border customization)

  @override
  void initState() {
    super.initState();
    selected = false;
<<<<<<< HEAD
    controller = MaterialStatesController();
  }

  void onPress() {
    widget.onPress!();
    setState(() {
      selected = !selected;
    });
=======
  }

  void onPress() {
    if (widget.onExpand != null) {
      widget.onExpand!();
      setState(() {
        selected = !selected;
      });
    }
>>>>>>> d72661e (Initial version, no border customization)
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final borderType =
<<<<<<< HEAD
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
        onPressed: onPress,
        style: getStyle(borderType, colors),
        child: SelectionContainer.disabled(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) Icon(widget.icon),
              Text(widget.label!),
              if (widget.onPress != null)
                const Icon(ZetaIcons.expand_more_round),
            ],
          ).paddingAll(_padding),
        ),
=======
        widget.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp;

    return FilledButton(
      onPressed: onPress,
      statesController: widget.controller,
      style: getStyle(borderType, colors, false),
      child: SelectionContainer.disabled(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) Icon(widget.icon),
            Text(widget.label!),
            if (widget.onExpand != null) const Icon(ZetaIcons.expand_more_round)
          ],
        ).paddingAll(_padding),
>>>>>>> d72661e (Initial version, no border customization)
      ),
    );
  }

<<<<<<< HEAD
  double get _padding => widget._isLarge ? ZetaSpacing.x4 : ZetaSpacing.x3;

  BorderSide _getBorderSide(
    Set<MaterialState> states,
    ZetaColors colors,
    bool finalButton,
  ) {
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
    final ZetaColorSwatch color =
        selected ? colors.cool : ZetaColorSwatch.fromColor(colors.black);

    return ButtonStyle(
=======
  double get _padding => widget.isLarge ? 16 : 12;

  ButtonStyle getStyle(
      ZetaWidgetBorder borderType, ZetaColors colors, bool finalButton) {
    ZetaColorSwatch color =
        selected ? colors.cool : ZetaColorSwatch.fromColor(colors.black);

    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size.square(32)),
>>>>>>> d72661e (Initial version, no border customization)
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: borderType.radius,
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
<<<<<<< HEAD
        if (selected) return colors.black;

=======
>>>>>>> d72661e (Initial version, no border customization)
        if (states.contains(MaterialState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (states.contains(MaterialState.pressed)) {
          return colors.primary.shade10;
        }
        if (states.contains(MaterialState.hovered)) {
          return colors.cool.shade20;
        }
<<<<<<< HEAD
        return colors.white;
=======
        if (selected) return colors.black;
        return Colors.transparent;
>>>>>>> d72661e (Initial version, no border customization)
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.disabled)) {
          return colors.textDisabled;
        }
        if (selected) return color.onColor;
        return colors.textDefault;
      }),
<<<<<<< HEAD
=======
      side: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(color: colors.cool.shade40);
        }
        if (states.contains(MaterialState.focused)) {
          return BorderSide(color: colors.blue, width: ZetaSpacing.x0_5);
        }
        return BorderSide(
          color: finalButton ? colors.borderDefault : colors.borderSubtle,
        );
      }),
>>>>>>> d72661e (Initial version, no border customization)
      elevation: const MaterialStatePropertyAll(0),
      padding: MaterialStateProperty.all(EdgeInsets.zero),
    );
  }
<<<<<<< HEAD

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(
        DiagnosticsProperty<MaterialStatesController>('controller', controller),
      );
  }
=======
>>>>>>> d72661e (Initial version, no border customization)
}
