import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

import 'dropdown_controller.dart';

class _DropdownControllerImpl implements ZetaDropdownController {
  _DropdownControllerImpl({required this.overlayPortalController, required this.toggleDropdown});

  final OverlayPortalController overlayPortalController;
  final VoidCallback toggleDropdown;

  @override
  bool get isOpen => overlayPortalController.isShowing;

  @override
  void close() => overlayPortalController.hide();

  @override
  void open() => overlayPortalController.show();

  @override
  void toggle() => toggleDropdown();
}

/// An item used in a [ZetaDropdown] or a [ZetaSelectInput].
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22391-10146
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/dropdown-menu/zetadropdown/dropdown-menu
class ZetaDropdownItem<T> {
  /// Creates a new [ZetaDropdownItem]
  ZetaDropdownItem({
    String? label,
    required this.value,
    this.icon,
  }) {
    this.label = label ?? this.value.toString();
  }

  /// The label for the item.
  late final String label;

  /// The value of the item.
  final T value;

  /// The icon shown next to the dropdown item.
  ///
  /// Will not be shown if the type of [ZetaDropdown] is set to anything other than [ZetaDropdownMenuType.standard]
  final Widget? icon;
}

/// Class for [ZetaDropdown]
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22391-10146
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/dropdown-menu/zetadropdown/dropdown-menu
class ZetaDropdown<T> extends ZetaStatefulWidget {
  /// Creates a new [ZetaDropdown].
  const ZetaDropdown({
    super.key,
    super.rounded,
    required this.items,
    this.onChange,
    this.value,
    this.type = ZetaDropdownMenuType.standard,
    this.size = ZetaDropdownSize.standard,
    this.offset = Offset.zero,
    this.builder,
    this.onDismissed,
    this.onOpen,
    this.semanticDropdownLabel,
    this.disableButtonSemantics = false,
    this.menuPosition,
  });

  /// {@template dropdown-items}
  /// The items displayed in the dropdown.
  /// {@endtemplate}
  final List<ZetaDropdownItem<T>> items;

  /// {@template dropdown-value}
  /// The value of the selected item.
  ///
  /// A [ZetaDropdownItem] in [items] must have a corresponding value for this to be set.
  /// {@endtemplate}
  final T? value;

  /// {@template dropdown-on-change}
  /// Called with the selected value whenever the dropdown is changed.
  ///
  /// {@macro zeta-widget-change-disable}
  /// {@endtemplate}
  final ValueSetter<ZetaDropdownItem<T>>? onChange;

  /// Called when the dropdown is dismissed.
  final VoidCallback? onDismissed;

  /// The type of the dropdown menu.
  ///
  /// Defaults to [ZetaDropdownMenuType.standard]
  final ZetaDropdownMenuType type;

  /// The size of the dropdown menu.
  ///
  /// Defaults to [ZetaDropdownSize.mini]
  final ZetaDropdownSize size;

  /// The offset of the dropdown menu from its parent.
  final Offset offset;

  /// Called when the dropdown is opened.
  final VoidCallback? onOpen;

  /// A semantic label for the dropdown.
  ///
  /// If null, the label will be set to the selected item's label.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticDropdownLabel;

  /// If true, [Semantics] will not include the button variable.
  final bool disableButtonSemantics;

  /// A custom builder for the child of the dropdown.
  ///
  /// Provides a build context, the currently selected item in the dropdown and a controller which can be used to open/close the dropdown.
  final Widget Function(
    BuildContext context,
    ZetaDropdownItem<T>? selectedItem,
    ZetaDropdownController controller,
  )? builder;

  /// Override the direction the dropdown menu is rendered.
  ///
  /// Defaults to [ZetaDropdownMenuPosition.down] if there is space, otherwise renders above.
  final ZetaDropdownMenuPosition? menuPosition;

  @override
  State<ZetaDropdown<T>> createState() => ZetaDropDownState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaDropdownMenuType>('leadingType', type))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(IterableProperty<ZetaDropdownItem<T>>('items', items))
      ..add(DiagnosticsProperty<T?>('selectedItem', value))
      ..add(EnumProperty<ZetaDropdownSize>('size', size))
      ..add(ObjectFlagProperty<ValueSetter<ZetaDropdownItem<T>>?>.has('onChange', onChange))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDismissed', onDismissed))
      ..add(
        ObjectFlagProperty<
            Widget Function(
              BuildContext context,
              ZetaDropdownItem<T>? selectedItem,
              ZetaDropdownController controller,
            )?>.has('builder', builder),
      )
      ..add(DiagnosticsProperty<Offset>('offset', offset))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onOpen', onOpen))
      ..add(StringProperty('semanticDropdownLabel', semanticDropdownLabel))
      ..add(DiagnosticsProperty<bool>('disableButtonSemantics', disableButtonSemantics))
      ..add(EnumProperty<ZetaDropdownMenuPosition>('menuPosition', menuPosition));
  }
}

/// Enum possible menu positions
enum ZetaDropdownMenuPosition {
  /// IF Menu is rendered above
  up,

  /// If menu is rendered below
  down,
}

/// The state for a [ZetaDropdown].
class ZetaDropDownState<T> extends State<ZetaDropdown<T>> {
  late final _DropdownControllerImpl _dropdownController;
  final OverlayPortalController _overlayPortalController = OverlayPortalController();

  final _link = LayerLink();
  final _menuKey = GlobalKey();
  final _childKey = GlobalKey();
  late ZetaDropdownMenuPosition _menuPosition = widget.menuPosition ?? ZetaDropdownMenuPosition.down;

  double? _menuSize;

  ZetaDropdownItem<T>? _selectedItem;

  bool get _allocateLeadingSpace {
    return widget.type != ZetaDropdownMenuType.standard || widget.items.map((item) => item.icon != null).contains(true);
  }

  @override
  void initState() {
    super.initState();
    _dropdownController = _DropdownControllerImpl(
      overlayPortalController: _overlayPortalController,
      toggleDropdown: _toggleDropdown,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setMenuSize();
    });
    _setSelectedItem();
  }

  /// Returns true if the dropdown is open.
  bool get isOpen => _dropdownController.isOpen;

  @override
  void didUpdateWidget(ZetaDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _setSelectedItem();
    }
    if (oldWidget.size != widget.size) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setMenuSize();
      });
    }
    if (oldWidget.onChange != widget.onChange && widget.onChange == null) {
      unawaited(
        Future<void>.delayed(Duration.zero).then(
          (value) => _dropdownController.close(),
        ),
      );
    }
  }

  void _toggleDropdown() {
    if (!isOpen) {
      widget.onOpen?.call();
    } else {
      widget.onDismissed?.call();
    }

    /// Version 1 : Calculate if overflow happens based on using calculations from sizes.
    final height = MediaQuery.of(context).size.height;
    final headerRenderBox = _childKey.currentContext!.findRenderObject()! as RenderBox;
    final headerHeight = headerRenderBox.size.height;
    const dropdownButtonHeight = 40;
    const dropdownPadding = 32;

    /// Calculate if overflow can happen
    final headerPosY = _headerPos.dy;
    final totalDropdownHeight = (widget.items.length * dropdownButtonHeight) + dropdownPadding;

    setState(() {
      if (headerPosY + headerHeight + totalDropdownHeight > height && headerPosY - totalDropdownHeight > 0) {
        _menuPosition = ZetaDropdownMenuPosition.up;
      } else {
        _menuPosition = ZetaDropdownMenuPosition.down;
      }
    });

    _overlayPortalController.toggle();
  }

  /// Return position of header
  Offset get _headerPos {
    final headerBox = _childKey.currentContext!.findRenderObject()! as RenderBox;
    return headerBox.localToGlobal(Offset.zero);
  }

  void _setSelectedItem() {
    if (widget.items.isNotEmpty) {
      try {
        _selectedItem = widget.items.firstWhere((item) => item.value == widget.value);
      } catch (e) {
        _selectedItem = null;
      }
    }
  }

  void _setMenuSize() {
    _dropdownController.close();
    if (widget.size == ZetaDropdownSize.mini) {
      _menuSize = null;
    } else {
      _menuSize = _childKey.currentContext?.size?.width ?? 0;
    }
  }

  // Returns if click event position is within the header.
  bool _isInHeader(
    Offset headerPosition,
    Size headerSize,
    Offset clickPosition,
  ) {
    return clickPosition.dx >= headerPosition.dx &&
        clickPosition.dx <= headerPosition.dx + headerSize.width &&
        clickPosition.dy >= headerPosition.dy &&
        clickPosition.dy <= headerPosition.dy + headerSize.height;
  }

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if (widget.builder != null) {
      child = Container(
        key: _childKey,
        child: widget.builder!(context, _selectedItem, _dropdownController),
      );
    } else {
      child = _DropdownItem(
        onPress: widget.onChange != null ? _toggleDropdown : null,
        value: _selectedItem ?? widget.items.first,
        allocateLeadingSpace: widget.type == ZetaDropdownMenuType.standard && _selectedItem?.icon != null,
        key: _childKey,
        explicitChildNodes: false,
      );
      if (widget.size == ZetaDropdownSize.mini) {
        child = IntrinsicWidth(
          child: child,
        );
      }
    }

    return CompositedTransformTarget(
      link: _link,
      child: Semantics(
        button: !widget.disableButtonSemantics && true,
        selected: isOpen,
        label: widget.semanticDropdownLabel ?? _selectedItem?.label,
        child: OverlayPortal(
          controller: _dropdownController.overlayPortalController,
          overlayChildBuilder: (BuildContext context) {
            return CompositedTransformFollower(
              link: _link,
              targetAnchor: _menuPosition == ZetaDropdownMenuPosition.up
                  ? Alignment.topLeft
                  : Alignment.bottomLeft, // Align overlay dropdown in its correct position
              followerAnchor: _menuPosition == ZetaDropdownMenuPosition.up ? Alignment.bottomLeft : Alignment.topLeft,
              offset: widget.offset,
              child: Align(
                alignment: _menuPosition == ZetaDropdownMenuPosition.up
                    ? AlignmentDirectional.bottomStart
                    : AlignmentDirectional.topStart,
                child: TapRegion(
                  onTapOutside: (event) {
                    final headerBox = _childKey.currentContext!.findRenderObject()! as RenderBox;

                    final headerPosition = headerBox.localToGlobal(Offset.zero);
                    final inHeader = _isInHeader(
                      headerPosition,
                      headerBox.size,
                      event.position,
                    );
                    if (!inHeader) {
                      _dropdownController.close();
                      widget.onDismissed?.call();
                    }
                  },
                  child: _ZetaDropDownMenu<T>(
                    items: widget.items,
                    selected: _selectedItem?.value,
                    allocateLeadingSpace: _allocateLeadingSpace,
                    menuSize: _menuSize,
                    key: _menuKey,
                    menuType: widget.type,
                    onSelected: (item) {
                      setState(() {
                        _selectedItem = item;
                      });
                      widget.onChange?.call(item);
                      _dropdownController.close();
                    },
                  ),
                ),
              ),
            );
          },
          child: child,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>(
          'menuKey',
          _menuKey,
        ),
      )
      ..add(DiagnosticsProperty<bool>('isOpen', isOpen));
  }
}

/// Class for [_DropdownItem]
class _DropdownItem<T> extends ZetaStatefulWidget {
  ///Public constructor for [_DropdownItem]
  const _DropdownItem({
    super.key,
    super.rounded,
    required this.value,
    required this.allocateLeadingSpace,
    this.selected = false,
    this.menuType = ZetaDropdownMenuType.standard,
    this.itemKey,
    this.onPress,
    this.explicitChildNodes = true,
  });

  final bool allocateLeadingSpace;

  /// If [_DropdownItem] is selected.
  final bool selected;

  /// Value of [_DropdownItem]
  final ZetaDropdownItem<T> value;

  /// Handles clicking for [_DropdownItem].
  final VoidCallback? onPress;

  /// If checkbox is to be shown, the type of it.
  final ZetaDropdownMenuType menuType;

  /// Key for item.
  final GlobalKey? itemKey;

  /// If child nodes are explicitly defined.
  final bool explicitChildNodes;

  @override
  State<_DropdownItem<T>> createState() => _DropdownItemState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPress', onPress))
      ..add(EnumProperty<ZetaDropdownMenuType?>('leadingType', menuType))
      ..add(
        DiagnosticsProperty<GlobalKey<State<StatefulWidget>>?>(
          'itemKey',
          itemKey,
        ),
      )
      ..add(DiagnosticsProperty<bool>('allocateLeadingSpace', allocateLeadingSpace))
      ..add(DiagnosticsProperty<ZetaDropdownItem<T>>('value', value))
      ..add(DiagnosticsProperty<bool>('explicitChildNodes', explicitChildNodes));
  }
}

class _DropdownItemState<T> extends State<_DropdownItem<T>> {
  final controller = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (context.mounted && mounted && !controller.value.contains(WidgetState.disabled)) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    Widget? leading = _getLeadingWidget();

    if (leading != null) {
      leading = Padding(
        padding: EdgeInsets.only(right: Zeta.of(context).spacing.medium),
        child: leading,
      );
    }

    return ExcludeSemantics(
      excluding: !widget.explicitChildNodes,
      child: DefaultTextStyle(
        style: ZetaTextStyles.bodyMedium,
        child: OutlinedButton(
          key: widget.itemKey,
          onPressed: widget.onPress,
          statesController: controller,
          style: _getStyle(colors),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Zeta.of(context).spacing.small,
              horizontal: Zeta.of(context).spacing.medium,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null) leading,
                Expanded(
                  child: Text(
                    widget.value.label,
                    style: ZetaTextStyles.bodyMedium.copyWith(color: colors.mainDefault, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? _getLeadingWidget() {
    if (!widget.allocateLeadingSpace) return null;
    switch (widget.menuType) {
      case ZetaDropdownMenuType.checkbox:
        return Checkbox(
          value: widget.selected,
          onChanged: (val) {
            widget.onPress!.call();
          },
        );
      case ZetaDropdownMenuType.radio:
        return ZetaRadio(
          value: widget.selected,
          groupValue: true,
          onChanged: (val) {
            widget.onPress?.call();
          },
        );
      case ZetaDropdownMenuType.standard:
        return widget.value.icon ?? SizedBox(width: Zeta.of(context).spacing.xl);
    }
  }

  ButtonStyle _getStyle(ZetaColors colors) {
    return ButtonStyle(
      iconColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.mainDisabled;
        }
        return colors.mainDefault;
      }),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (widget.selected) {
          return colors.surfaceSelected;
        }
        if (states.contains(WidgetState.pressed)) {
          return colors.surfaceSelectedHover;
        }
        if (states.contains(WidgetState.hovered)) {
          return colors.surfaceHover;
        }

        return colors.surfaceDefault;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.mainDisabled;
        }
        return colors.mainDefault;
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(context.rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
        ),
      ),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: colors.borderPrimary, width: Zeta.of(context).spacing.xl);
        }
        return BorderSide.none;
      }),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      elevation: const WidgetStatePropertyAll(0),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<WidgetStatesController>(
        'controller',
        controller,
      ),
    );
  }
}

class _ZetaDropDownMenu<T> extends ZetaStatefulWidget {
  ///Constructor for [_ZetaDropDownMenu]
  const _ZetaDropDownMenu({
    required this.items,
    required this.onSelected,
    required this.selected,
    required this.allocateLeadingSpace,
    required this.menuSize,
    this.menuType = ZetaDropdownMenuType.standard,
    super.key,
  });

  /// Input items for the menu
  final List<ZetaDropdownItem<T>> items;

  ///Handles clicking of item in menu
  final ValueSetter<ZetaDropdownItem<T>> onSelected;

  final bool allocateLeadingSpace;

  final T? selected;

  /// Width for menu. If set to null the menu will shrink to the width of its widest child.
  final double? menuSize;

  /// If items have checkboxes, the type of that checkbox.
  final ZetaDropdownMenuType menuType;

  @override
  State<_ZetaDropDownMenu<T>> createState() => _ZetaDropDownMenuState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('width', menuSize))
      ..add(EnumProperty<ZetaDropdownMenuType?>('boxType', menuType))
      ..add(IterableProperty<ZetaDropdownItem<T>>('items', items))
      ..add(ObjectFlagProperty<ValueSetter<ZetaDropdownItem<T>>>.has('onSelected', onSelected))
      ..add(DiagnosticsProperty<bool>('allocateLeadingSpace', allocateLeadingSpace))
      ..add(DiagnosticsProperty<T?>('selected', selected));
  }
}

class _ZetaDropDownMenuState<T> extends State<_ZetaDropDownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return Container(
      padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
      decoration: BoxDecoration(
        color: colors.surfaceDefault,
        borderRadius:
            BorderRadius.all(context.rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
        boxShadow: const [
          BoxShadow(blurRadius: 2, color: Color.fromRGBO(40, 51, 61, 0.04)),
          BoxShadow(
            blurRadius: 8,
            color: Color.fromRGBO(96, 104, 112, 0.16),
            blurStyle: BlurStyle.outer,
            offset: Offset(0, 4),
          ),
        ],
      ),
      constraints: widget.menuSize != null
          ? BoxConstraints(
              minWidth: widget.menuSize!,
            )
          : null,
      child: IntrinsicWidth(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.items
                .map((item) {
                  return _DropdownItem(
                    value: item,
                    onPress: () => widget.onSelected(item),
                    selected: item.value == widget.selected,
                    allocateLeadingSpace: widget.allocateLeadingSpace,
                    menuType: widget.menuType,
                  );
                })
                .divide(SizedBox(height: Zeta.of(context).spacing.minimum))
                .toList(),
          ),
        ),
      ),
    );
  }
}
