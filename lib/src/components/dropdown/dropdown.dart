import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Sets the type of a [ZetaDropdown]
enum ZetaDropdownMenuType {
  /// No leading elements before each item unless an icon is given to the [ZetaDropdownItem]
  standard,

  /// Displays a [ZetaCheckbox] before each item.
  checkbox,

  /// Displays a [ZetaRadio] before each item.
  radio
}

/// Used to set the size of a [ZetaDropdown]
enum ZetaDropdownSize {
  /// Initial width of 320dp.
  standard,

  /// Initial width of 120dp.
  mini,
}

/// A class for controlling a [ZetaDropdown]
///
/// Can be acquired from the builder method of a [ZetaDropdown]
abstract class ZetaDropdownController {
  /// Returns true if the dropdown is open.
  bool get isOpen;

  /// Opens the dropdown.
  void open();

  /// Closes the dropdown.
  void close();

  /// Toggles the dropdown open or closed depending on its current state.
  void toggle();
}

class _DropdownControllerImpl implements ZetaDropdownController {
  _DropdownControllerImpl({required this.overlayPortalController});

  final OverlayPortalController overlayPortalController;

  @override
  bool get isOpen => overlayPortalController.isShowing;

  @override
  void close() => overlayPortalController.hide();

  @override
  void open() => overlayPortalController.show();

  @override
  void toggle() => overlayPortalController.toggle();
}

/// An item used in a [ZetaDropdown] or a [ZetaSelectInput].
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
class ZetaDropdown<T> extends ZetaStatefulWidget {
  /// Creates a new [ZetaDropdown].
  const ZetaDropdown({
    required this.items,
    this.onChange,
    @Deprecated('Set onChange to null. ' 'Disabled is deprecated as of 0.11.0') bool disabled = false,
    this.value,
    this.type = ZetaDropdownMenuType.standard,
    this.size = ZetaDropdownSize.standard,
    this.builder,
    this.onDismissed,
    super.key,
    super.rounded,
  });

  /// The items displayed in the dropdown.
  final List<ZetaDropdownItem<T>> items;

  /// The value of the selected item.
  ///
  /// If no [ZetaDropdownItem] in [items] has a matching value, the first item in [items] will be set as the selected item.
  final T? value;

  /// Called with the selected value whenever the dropdown is changed.
  ///
  /// {@macro on-change-disable}
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

  /// A custom builder for the child of the dropdown.
  ///
  /// Provides a build context, the currently selected item in the dropdown and a controller which can be used to open/close the dropdown.
  final Widget Function(
    BuildContext context,
    ZetaDropdownItem<T>? selectedItem,
    ZetaDropdownController controller,
  )? builder;

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
      );
  }
}

/// Enum possible menu positions
enum MenuPosition {
  /// IF Menu is rendered above
  up,

  /// If menu is rendered below
  down,
}

/// The state for a [ZetaDropdown]
class ZetaDropDownState<T> extends State<ZetaDropdown<T>> {
  final _DropdownControllerImpl _dropdownController = _DropdownControllerImpl(
    overlayPortalController: OverlayPortalController(),
  );
  final _link = LayerLink();
  final _menuKey = GlobalKey();
  final _childKey = GlobalKey();
  MenuPosition _menuPosition = MenuPosition.down;

  ZetaDropdownItem<T>? _selectedItem;

  bool get _allocateLeadingSpace {
    return widget.type != ZetaDropdownMenuType.standard || widget.items.map((item) => item.icon != null).contains(true);
  }

  @override
  void initState() {
    super.initState();
    _setSelectedItem();
  }

  /// Returns true if the dropdown is open.
  bool get isOpen => _dropdownController.isOpen;

  @override
  void didUpdateWidget(ZetaDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(_setSelectedItem);
    }
    if (widget.onChange == null) {
      unawaited(
        Future<void>.delayed(Duration.zero).then(
          (value) => _dropdownController.close(),
        ),
      );
    }
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
        onPress: widget.onChange != null ? _onTap : null,
        value: _selectedItem ?? widget.items.first,
        allocateLeadingSpace: widget.type == ZetaDropdownMenuType.standard && _selectedItem?.icon != null,
        key: _childKey,
      );
    }

    return SizedBox(
      width: _size,
      child: CompositedTransformTarget(
        link: _link,
        child: OverlayPortal(
          controller: _dropdownController.overlayPortalController,
          overlayChildBuilder: (BuildContext context) {
            return CompositedTransformFollower(
              link: _link,
              targetAnchor: _menuPosition == MenuPosition.up
                  ? Alignment.topLeft
                  : Alignment.bottomLeft, // Align overlay dropdown in its correct position
              followerAnchor: _menuPosition == MenuPosition.up ? Alignment.bottomLeft : Alignment.topLeft,
              offset: const Offset(0, ZetaSpacing.xl_1 * -1),
              child: Align(
                alignment:
                    _menuPosition == MenuPosition.up ? AlignmentDirectional.bottomStart : AlignmentDirectional.topStart,
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
                    width: _size,
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

  double get _size => widget.size == ZetaDropdownSize.mini ? 120 : 320;

  void _onTap() {
    /// Version 1 : Calculate if overflow happens based on using calculations from sizes.
    final height = MediaQuery.of(context).size.height;
    final headerRenderBox = _childKey.currentContext!.findRenderObject()! as RenderBox;
    final dropdownItemHeight = headerRenderBox.size.height;

    /// Calculate if overflow can happen
    final headerPosY = _headerPos.dy;

    if (headerPosY + (dropdownItemHeight * (widget.items.length + 1)) > height) {
      setState(() {
        _menuPosition = MenuPosition.up;
      });
    } else {
      setState(() {
        _menuPosition = MenuPosition.down;
      });
    }

    _dropdownController.toggle();
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
class _DropdownItem<T> extends StatefulWidget {
  ///Public constructor for [_DropdownItem]
  const _DropdownItem({
    super.key,
    required this.value,
    required this.allocateLeadingSpace,
    this.selected = false,
    this.menuType = ZetaDropdownMenuType.standard,
    this.itemKey,
    this.onPress,
  });

  final bool allocateLeadingSpace;

  /// If [_DropdownItem] is selected
  final bool selected;

  /// Value of [_DropdownItem]
  final ZetaDropdownItem<T> value;

  /// Handles clicking for [_DropdownItem]
  final VoidCallback? onPress;

  /// If checkbox is to be shown, the type of it.
  final ZetaDropdownMenuType menuType;

  /// Key for item
  final GlobalKey? itemKey;

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
      ..add(DiagnosticsProperty<ZetaDropdownItem<T>>('value', value));
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
        padding: const EdgeInsets.only(right: ZetaSpacing.medium),
        child: leading,
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: ZetaSpacing.xl_6),
      child: DefaultTextStyle(
        style: ZetaTextStyles.bodyMedium,
        child: OutlinedButton(
          key: widget.itemKey,
          onPressed: widget.onPress,
          statesController: controller,
          style: _getStyle(colors),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: ZetaSpacing.medium),
              if (leading != null) leading,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: ZetaSpacing.small),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Text(
                        widget.value.label,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ).paddingVertical(ZetaSpacingBase.x2_5),
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
        return Radio(
          value: widget.selected,
          groupValue: true,
          onChanged: (val) {
            widget.onPress?.call();
          },
        );
      case ZetaDropdownMenuType.standard:
        return widget.value.icon ?? const SizedBox(width: ZetaSpacing.xl_2);
    }
  }

  ButtonStyle _getStyle(ZetaColors colors) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (widget.selected) {
          return colors.surfaceSelected;
        }
        if (states.contains(WidgetState.pressed)) {
          return colors.surfaceSelected;
        }
        if (states.contains(WidgetState.hovered)) {
          return colors.surfaceHover;
        }

        return colors.surfacePrimary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.textDisabled;
        }
        return colors.textDefault;
      }),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: context.rounded ? ZetaRadius.minimal : ZetaRadius.none,
        ),
      ),
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.focused)) {
          return BorderSide(color: colors.borderPrimary, width: ZetaSpacing.xl_1);
        }
        return BorderSide.none;
      }),
      padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      elevation: const WidgetStatePropertyAll(0),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
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
    this.width,
    this.menuType = ZetaDropdownMenuType.standard,
    super.key,
  });

  /// Input items for the menu
  final List<ZetaDropdownItem<T>> items;

  ///Handles clicking of item in menu
  final ValueSetter<ZetaDropdownItem<T>> onSelected;

  final bool allocateLeadingSpace;

  final T? selected;

  /// Width for menu
  final double? width;

  /// If items have checkboxes, the type of that checkbox.
  final ZetaDropdownMenuType menuType;

  @override
  State<_ZetaDropDownMenu<T>> createState() => _ZetaDropDownMenuState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('width', width))
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
      padding: const EdgeInsets.all(ZetaSpacing.medium),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: context.rounded ? ZetaRadius.minimal : ZetaRadius.none,
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
      width: widget.width,
      child: Builder(
        builder: (BuildContext bcontext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
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
                .divide(const SizedBox(height: ZetaSpacing.minimum))
                .toList(),
          );
        },
      ),
    );
  }
}
