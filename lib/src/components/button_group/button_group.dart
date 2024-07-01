import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Button Group
class ZetaButtonGroup extends ZetaStatelessWidget {
  /// Constructs [ZetaButtonGroup] from a list of [ZetaGroupButton]s
  const ZetaButtonGroup({
    super.key,
    required this.buttons,
    this.isLarge = false,
    this.isInverse = false,
    super.rounded,
  });

  /// Determines size of [ZetaGroupButton].
  final bool isLarge;

  /// [ZetaGroupButton]s to be rendered in list.
  final List<ZetaGroupButton> buttons;

  /// If widget should be rendered in inverted colors.
  final bool isInverse;

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: getButtons(),
      ),
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
class ZetaGroupButton extends ZetaStatefulWidget {
  /// Public Constructor for [ZetaGroupButton]
  const ZetaGroupButton({
    super.key,
    this.onPressed,
    this.label,
    this.icon,
    super.rounded,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        initialValue = null,
        items = null,
        onChange = null;

  /// Private constructor
  const ZetaGroupButton._({
    required this.isFinal,
    required this.isInitial,
    required this.isInverse,
    required this.isLarge,
    this.onChange,
    this.label,
    this.initialValue,
    this.icon,
    this.onPressed,
    this.items,
    super.key,
    super.rounded,
  });

  /// Constructs dropdown group button
  const ZetaGroupButton.dropdown({
    required this.items,
    this.onChange,
    this.initialValue,
    this.icon,
    this.label,
    super.key,
    super.rounded,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        onPressed = null;

  ///Constructs group button with icon
  const ZetaGroupButton.icon({
    super.key,
    super.rounded,
    required this.icon,
    this.onPressed,
    this.label,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        items = null,
        onChange = null,
        initialValue = null;

  /// Label for [ZetaGroupButton].
  final String? label;

  /// Optional icon for [ZetaGroupButton].
  final IconData? icon;

  /// Function for when [ZetaGroupButton] is clicked.
  ///
  /// {@template zeta-widget-change-disable}
  /// Setting this to null will disable the widget.
  /// {@endtemplate}
  final VoidCallback? onPressed;

  /// {@macro dropdown-items}
  final List<ZetaDropdownItem<dynamic>>? items;

  /// {@macro dropdown-on-change}
  /// {@macro zeta-widget-change-disable}
  final void Function(ZetaDropdownItem<dynamic> selectedItem)? onChange;

  /// {@macro dropdown-value}
  final dynamic initialValue;

  ///If [ZetaGroupButton] is large.
  final bool isLarge;

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
      items: items,
      onChange: onChange,
      isFinal: isFinal ?? this.isFinal,
      initialValue: initialValue,
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
      ..add(DiagnosticsProperty<bool>('isFinal', isFinal))
      ..add(DiagnosticsProperty<bool>('isInverse', isInverse))
      ..add(IterableProperty<ZetaDropdownItem<dynamic>>('dropdownItems', items))
      ..add(ObjectFlagProperty<void Function(ZetaDropdownItem<dynamic> selectedItem)?>.has('onChange', onChange))
      ..add(DiagnosticsProperty('initialValue', initialValue));
  }
}

class _ZetaGroupButtonState extends State<ZetaGroupButton> {
  WidgetStatesController controller = WidgetStatesController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(ZetaGroupButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onPressed != widget.onPressed) {
      setState(() {});
    }
  }

  double get _padding => widget.isLarge ? ZetaSpacing.large : ZetaSpacing.medium;

  BorderSide _getBorderSide(
    ZetaColors colors,
    bool finalButton,
  ) {
    if (controller.value.contains(WidgetState.focused)) {
      return BorderSide(color: colors.blue.shade50, width: ZetaSpacingBase.x0_5);
    }
    if (controller.value.contains(WidgetState.disabled)) {
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
        if (states.contains(WidgetState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (states.contains(WidgetState.pressed)) {
          return widget.isInverse ? colors.cool.shade100 : colors.primary.shade10;
        }
        if (states.contains(WidgetState.hovered)) {
          return widget.isInverse ? colors.cool.shade90 : colors.cool.shade20;
        }
        if (widget.isInverse) return colors.cool.shade100;

        return colors.surfacePrimary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.textDisabled;
        }
        if (widget.isInverse) return colors.cool.shade100.onColor;
        return colors.textDefault;
      }),
      elevation: const WidgetStatePropertyAll(ZetaSpacing.none),
      padding: WidgetStateProperty.all(EdgeInsets.zero),
    );
  }

  Widget _getButton(
    VoidCallback? onPressed, {
    bool dropdownOpen = false,
    ZetaDropdownItem<dynamic>? selectedItem,
  }) {
    final colors = Zeta.of(context).colors;
    final rounded = context.rounded;
    final borderType = rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp;
    final BorderSide borderSide = _getBorderSide(colors, false);

    late final IconData dropdownIcon;

    if (!dropdownOpen || onPressed == null) {
      dropdownIcon = ZetaIcons.expand_more;
    } else {
      dropdownIcon = ZetaIcons.expand_less;
    }

    const iconSize = ZetaSpacing.xl_1;

    Widget? leadingIcon;
    if (selectedItem?.icon != null) {
      leadingIcon = IconTheme(
        data: const IconThemeData(
          size: iconSize,
        ),
        child: selectedItem!.icon!,
      );
    } else if (selectedItem == null && widget.icon != null) {
      leadingIcon = ZetaIcon(widget.icon, size: iconSize);
    }

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
        onPressed: onPressed,
        style: getStyle(borderType, colors),
        child: SelectionContainer.disabled(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              leadingIcon ?? const SizedBox(),
              Text(selectedItem?.label ?? widget.label ?? '', style: ZetaTextStyles.labelMedium),
              if (widget.items != null)
                ZetaIcon(
                  dropdownIcon,
                  size: ZetaSpacing.xl_1,
                ),
            ].divide(const SizedBox(width: ZetaSpacing.minimum)).toList(),
          ).paddingAll(_padding),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;

    late final Widget child;

    if (widget.items != null) {
      child = ZetaDropdown(
        items: widget.items!,
        onChange: widget.onChange,
        onDismissed: () => setState(() {}),
        value: widget.initialValue,
        rounded: rounded,
        builder: (context, selectedItem, controller) {
          return _getButton(
            widget.onChange != null ? controller.toggle : null,
            dropdownOpen: controller.isOpen,
            selectedItem: selectedItem,
          );
        },
      );
    } else {
      child = _getButton(widget.onPressed);
    }

    return child;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WidgetStatesController>('controller', controller));
  }
}
