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
    final List<ZetaGroupButton> mappedButtons = [];

    for (final (index, button) in buttons.indexed) {
      mappedButtons.add(
        button.copyWith(
          isLarge: isLarge,
          isInverse: isInverse,
          rounded: rounded,
          isFinal: index == buttons.length - 1,
          isInitial: index == 0,
        ),
      );
    }

    return mappedButtons;
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
class ZetaGroupButton extends StatefulWidget {
  /// Public Constructor for [ZetaGroupButton]
  const ZetaGroupButton({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.dropdown,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        rounded = true;

  /// Private constructor
  const ZetaGroupButton._({
    super.key,
    this.label,
    this.icon,
    this.onPressed,
    this.dropdown,
    required this.isFinal,
    required this.isInitial,
    required this.isInverse,
    required this.isLarge,
    required this.rounded,
  });

  /// Constructs dropdown group button
  const ZetaGroupButton.dropdown({
    super.key,
    required this.onPressed,
    required this.dropdown,
    this.icon,
    this.label,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        rounded = true;

  ///Constructs group button with icon
  const ZetaGroupButton.icon({
    super.key,
    required this.icon,
    this.dropdown,
    this.onPressed,
    this.label,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        rounded = true;

  /// Label for [ZetaGroupButton].
  final String? label;

  /// Optional icon for [ZetaGroupButton].
  final IconData? icon;

  /// Function for when [ZetaGroupButton] is clicked.
  final VoidCallback? onPressed;

  /// Content of dropdown.
  final Widget? dropdown;

  ///If [ZetaGroupButton] is large.
  final bool isLarge;

  ///If [ZetaGroupButton] is rounded.
  final bool rounded;

  /// If [ZetaGroupButton] is the first button in its list.
  final bool isInitial;

  /// If [ZetaGroupButton] is the final button in its list.
  final bool isFinal;

  /// If [ZetaGroupButton] is inverse.

  final bool isInverse;

  @override
  State<ZetaGroupButton> createState() => _ZetaGroupButtonState();

  /// Returns copy of [ZetaGroupButton] with fields.
  ZetaGroupButton copyWith({
    bool? isFinal,
    bool? isInitial,
    bool? isLarge,
    bool? rounded,
    bool? isInverse,
  }) {
    return ZetaGroupButton._(
      key: key,
      label: label,
      icon: icon,
      onPressed: onPressed,
      dropdown: dropdown,
      isFinal: isFinal ?? this.isFinal,
      isInitial: isInitial ?? this.isInitial,
      isLarge: isLarge ?? this.isLarge,
      rounded: rounded ?? this.rounded,
      isInverse: isInverse ?? this.isInverse,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('Label', label))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(DiagnosticsProperty<bool>('isInitial', isInitial))
      ..add(DiagnosticsProperty<bool>('isLarge', isLarge))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('isFinal', isFinal))
      ..add(DiagnosticsProperty<bool>('isInverse', isInverse));
  }
}

class _ZetaGroupButtonState extends State<ZetaGroupButton> {
  late WidgetStatesController controller;

  @override
  void initState() {
    super.initState();
    controller = WidgetStatesController();
    controller.addListener(() {
      if (!controller.value.contains(WidgetState.disabled) && context.mounted && mounted) {
        // TODO(UX-1005): setState causing exception when going from disabled to enabled.
        setState(() {});
      }
    });
  }

  @override
  void didUpdateWidget(ZetaGroupButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onPressed != widget.onPressed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final borderType = widget.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp;

    final BorderSide borderSide = _getBorderSide(controller.value, colors, false);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: borderSide,
          left: borderSide,
          bottom: borderSide,
          right: controller.value.contains(WidgetState.focused)
              ? BorderSide(color: colors.blue.shade50, width: 2)
              : (widget.isFinal)
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
              if (widget.icon != null) Icon(widget.icon, size: ZetaSpacing.xL),
              Text(widget.label ?? '', style: ZetaTextStyles.labelMedium),
              if (widget.dropdown != null) // TODO(UX-1006): Dropdown
                Icon(
                  widget.rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp,
                  size: ZetaSpacing.xL,
                ),
            ].divide(const SizedBox(width: ZetaSpacing.minimum)).toList(),
          ).paddingAll(_padding),
        ),
      ),
    );
  }

  double get _padding => widget.isLarge ? ZetaSpacing.large : ZetaSpacing.medium;

  BorderSide _getBorderSide(
    Set<WidgetState> states,
    ZetaColors colors,
    bool finalButton,
  ) {
    if (states.contains(WidgetState.focused)) {
      return BorderSide(color: colors.blue.shade50, width: ZetaSpacingBase.x0_5);
    }
    if (widget.isInverse) return BorderSide(color: colors.black);
    if (states.contains(WidgetState.disabled)) {
      return BorderSide(color: colors.cool.shade40);
    }
    return BorderSide(
      color: finalButton ? colors.borderDefault : colors.borderSubtle,
    );
  }

  BorderRadius _getRadius(ZetaWidgetBorder borderType) {
    if (widget.isInitial) {
      return borderType.radius.copyWith(
        topRight: Radius.zero,
        bottomRight: Radius.zero,
      );
    }
    if (widget.isFinal) {
      return borderType.radius.copyWith(
        topLeft: Radius.zero,
        bottomLeft: Radius.zero,
      );
    }
    return ZetaRadius.none;
  }

  ButtonStyle getStyle(ZetaWidgetBorder borderType, ZetaColors colors) {
    return ButtonStyle(
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: _getRadius(borderType),
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (widget.isInverse) return colors.cool.shade100;

        if (states.contains(WidgetState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (states.contains(WidgetState.pressed)) {
          return colors.primary.shade10;
        }
        if (states.contains(WidgetState.hovered)) {
          return colors.cool.shade20;
        }
        return colors.surfacePrimary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.textDisabled;
        }
        if (widget.isInverse) return colors.cool.shade100.onColor;
        return colors.textDefault;
      }),
      elevation: const WidgetStatePropertyAll(0),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WidgetStatesController>('controller', controller));
  }
}
