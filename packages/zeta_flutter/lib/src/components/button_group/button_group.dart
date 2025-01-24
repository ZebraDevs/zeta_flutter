import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Button Group
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-45&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/buttons/group-button
class ZetaButtonGroup extends ZetaStatelessWidget {
  /// Constructs [ZetaButtonGroup] from a list of [ZetaGroupButton]s
  const ZetaButtonGroup({
    super.key,
    super.rounded,
    required this.buttons,
    this.isLarge = false,
    this.isInverse = false,
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
// TODO(UX-1132): Refactor to make group button a class, not a widget.

/// Group Button item.
///
class ZetaGroupButton extends ZetaStatefulWidget {
  /// Public Constructor for [ZetaGroupButton]
  const ZetaGroupButton({
    super.key,
    super.rounded,
    this.onPressed,
    this.label,
    this.icon,
    this.semanticLabel,
  })  : isFinal = false,
        isInitial = false,
        isInverse = false,
        isLarge = true,
        initialValue = null,
        items = null,
        onChange = null;

  /// Private constructor
  const ZetaGroupButton._({
    super.key,
    super.rounded,
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
    this.semanticLabel,
  });

  /// Constructs dropdown group button
  const ZetaGroupButton.dropdown({
    super.key,
    super.rounded,
    required this.items,
    this.onChange,
    this.initialValue,
    this.icon,
    this.label,
    this.semanticLabel,
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
    this.semanticLabel,
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

  /// Semantic label for [ZetaGroupButton].
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If this property is null, [label] will be used instead.
  final String? semanticLabel;

  @override
  State<ZetaGroupButton> createState() => _ZetaGroupButtonState();

  /// Returns copy of [ZetaGroupButton] with fields.
  ZetaGroupButton copyWith({
    bool? isFinal,
    bool? isInitial,
    bool? isLarge,
    bool? rounded,
    bool? isInverse,
    String? semanticLabel,
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
      semanticLabel: semanticLabel ?? this.semanticLabel,
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
      ..add(DiagnosticsProperty('initialValue', initialValue))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _ZetaGroupButtonState extends State<ZetaGroupButton> {
  final WidgetStatesController _controller = WidgetStatesController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  double get _padding => widget.isLarge ? Zeta.of(context).spacing.large : Zeta.of(context).spacing.medium;

  BorderSide _getBorderSide(
    ZetaColors colors,
    bool finalButton,
  ) {
    // TODO(UX-1200): Focus border does not work as expected.
    if (_controller.value.contains(WidgetState.focused)) {
      return BorderSide(color: colors.borderPrimary, width: ZetaBorders.medium);
    }
    if (_controller.value.contains(WidgetState.disabled)) {
      return BorderSide(color: colors.borderDisabled);
    }
    return BorderSide(
      color: finalButton ? colors.borderDefault : colors.borderSubtle,
    );
  }

  BorderRadius _getRadius(ZetaWidgetBorder borderType) {
    if (widget.isInitial) {
      return BorderRadius.all(borderType.radius(context)).copyWith(
        topRight: Radius.zero,
        bottomRight: Radius.zero,
      );
    }
    if (widget.isFinal) {
      return BorderRadius.all(borderType.radius(context)).copyWith(
        topLeft: Radius.zero,
        bottomLeft: Radius.zero,
      );
    }
    return BorderRadius.all(Zeta.of(context).radius.none);
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

    final iconSize = Zeta.of(context).spacing.xl;

    Widget? leadingIcon;
    if (selectedItem?.icon != null) {
      leadingIcon = IconTheme(
        data: IconThemeData(
          size: iconSize,
        ),
        child: selectedItem!.icon!,
      );
    } else if (selectedItem == null && widget.icon != null) {
      leadingIcon = ZetaIcon(
        widget.icon,
        size: iconSize,
        color: widget.isInverse ? colors.mainInverse : colors.mainDefault,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: borderSide,
          left: borderSide,
          bottom: borderSide,
          right: _controller.value.contains(WidgetState.focused)
              ? BorderSide(color: colors.borderPrimary, width: 2)
              : (widget.isFinal)
                  ? borderSide
                  : BorderSide.none,
        ),
        borderRadius: _getRadius(borderType),
      ),
      padding: EdgeInsets.zero,
      child: ExcludeSemantics(
        child: FilledButton(
          statesController: _controller,
          onPressed: onPressed,
          style: ButtonStyle(
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
                return widget.isInverse ? colors.stateInverseSelected : colors.stateDefaultSelected;
              }
              if (states.contains(WidgetState.hovered)) {
                return widget.isInverse ? colors.stateInverseHover : colors.surfaceHover;
              }
              if (widget.isInverse) return colors.stateInverseEnabled;

              return colors.surfaceDefault;
            }),
            foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.disabled)) {
                return colors.mainDisabled;
              }
              if (widget.isInverse) return colors.mainInverse;
              return colors.mainDefault;
            }),
            elevation: WidgetStatePropertyAll(Zeta.of(context).spacing.none),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          child: SelectionContainer.disabled(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                leadingIcon ?? const Nothing(),
                Text(selectedItem?.label ?? widget.label ?? '', style: ZetaTextStyles.labelMedium),
                if (widget.items != null)
                  Icon(
                    dropdownIcon,
                    size: Zeta.of(context).spacing.xl,
                    color: widget.onChange == null
                        ? colors.mainDisabled
                        : widget.isInverse
                            ? colors.mainInverse
                            : colors.mainDefault,
                  ),
              ].divide(SizedBox(width: Zeta.of(context).spacing.minimum)).toList(),
            ).paddingAll(_padding),
          ),
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

    // TODO(UX-1133): Selected prop in semantics does not work as expected.

    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      button: true,
      enabled: (widget.onPressed != null) || (widget.items != null),
      selected: (widget.items != null) ? _controller.value.contains(WidgetState.selected) : null,
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WidgetStatesController>('controller', _controller));
  }
}
