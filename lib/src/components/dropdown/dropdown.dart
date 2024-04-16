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

/// An item used in a [ZetaDropdown].
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
class ZetaDropdown<T> extends StatefulWidget {
  /// Creates a new [ZetaDropdown].
  const ZetaDropdown({
    required this.items,
    this.onChange,
    this.value,
    this.rounded = true,
    this.disabled = false,
    this.type = ZetaDropdownMenuType.standard,
    this.size = ZetaDropdownSize.standard,
    super.key,
  }) : assert(items.length > 0, 'Items must be greater than 0.');

  /// The items displayed in the dropdown.
  final List<ZetaDropdownItem<T>> items;

  /// The value of the selected item.
  ///
  /// If no [ZetaDropdownItem] in [items] has a matching value, the first item in [items] will be set as the selected item.
  final T? value;

  /// Called with the selected value whenever the dropdown is changed.
  final ValueSetter<T>? onChange;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Disables the dropdown.
  final bool disabled;

  /// The type of the dropdown menu.
  ///
  /// Defaults to [ZetaDropdownMenuType.standard]
  final ZetaDropdownMenuType type;

  /// The size of the dropdown menu.
  ///
  /// Defaults to [ZetaDropdownSize.mini]
  final ZetaDropdownSize size;

  @override
  State<ZetaDropdown<T>> createState() => _ZetaDropDownState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaDropdownMenuType>('leadingType', type))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(IterableProperty<ZetaDropdownItem<T>>('items', items))
      ..add(DiagnosticsProperty<T?>('selectedItem', value))
      ..add(ObjectFlagProperty<ValueSetter<T>?>.has('onChange', onChange))
      ..add(EnumProperty<ZetaDropdownSize>('size', size))
      ..add(DiagnosticsProperty<bool>('disabled', disabled));
  }
}

class _ZetaDropDownState<T> extends State<ZetaDropdown<T>> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  final _menuKey = GlobalKey();
  final _headerKey = GlobalKey();

  ZetaDropdownItem<T>? _selectedItem;

  bool get _allocateLeadingSpace {
    return widget.type != ZetaDropdownMenuType.standard || widget.items.map((item) => item.icon != null).contains(true);
  }

  @override
  void initState() {
    super.initState();
    _setSelectedItem();
  }

  @override
  void didUpdateWidget(ZetaDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(_setSelectedItem);
    }
    if (widget.disabled) {
      unawaited(
        Future<void>.delayed(Duration.zero).then(
          (value) => _tooltipController.hide(),
        ),
      );
    }
  }

  void _setSelectedItem() {
    try {
      _selectedItem = widget.items.firstWhere((item) => item.value == widget.value);
    } catch (e) {
      _selectedItem = widget.items.first;
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
    return SizedBox(
      width: _size,
      child: CompositedTransformTarget(
        link: _link,
        child: OverlayPortal(
          controller: _tooltipController,
          overlayChildBuilder: (BuildContext context) {
            return CompositedTransformFollower(
              link: _link,
              targetAnchor: Alignment.bottomLeft, // Align overlay dropdown in its correct position
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: TapRegion(
                  onTapOutside: (event) {
                    final headerBox = _headerKey.currentContext!.findRenderObject()! as RenderBox;

                    final headerPosition = headerBox.localToGlobal(Offset.zero);
                    final inHeader = _isInHeader(
                      headerPosition,
                      headerBox.size,
                      event.position,
                    );
                    if (!inHeader) _tooltipController.hide();
                  },
                  child: _ZetaDropDownMenu<T>(
                    items: widget.items,
                    selected: _selectedItem?.value,
                    rounded: widget.rounded,
                    allocateLeadingSpace: _allocateLeadingSpace,
                    width: _size,
                    key: _menuKey,
                    menuType: widget.type,
                    onSelected: (item) {
                      setState(() {
                        _selectedItem = item;
                      });
                      widget.onChange?.call(item.value);
                      _tooltipController.hide();
                    },
                  ),
                ),
              ),
            );
          },
          child: _DropdownItem(
            onPress: !widget.disabled ? onTap : null,
            value: _selectedItem ?? widget.items.first,
            allocateLeadingSpace: widget.type == ZetaDropdownMenuType.standard && _selectedItem?.icon != null,
            rounded: widget.rounded,
            key: _headerKey,
          ),
        ),
      ),
    );
  }

  double get _size => widget.size == ZetaDropdownSize.mini ? 120 : 320;

  void onTap() {
    _tooltipController.toggle();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<GlobalKey<State<StatefulWidget>>>(
        'menuKey',
        _menuKey,
      ),
    );
  }
}

/// Class for [_DropdownItem]
class _DropdownItem<T> extends StatefulWidget {
  ///Public constructor for [_DropdownItem]
  const _DropdownItem({
    super.key,
    required this.value,
    required this.allocateLeadingSpace,
    required this.rounded,
    this.selected = false,
    this.menuType = ZetaDropdownMenuType.standard,
    this.itemKey,
    this.onPress,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

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
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
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
  final controller = MaterialStatesController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (context.mounted && mounted && !controller.value.contains(MaterialState.disabled)) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    Widget? leading = _getLeadingWidget();

    if (leading != null) {
      leading = Padding(
        padding: const EdgeInsets.only(right: ZetaSpacing.x3),
        child: leading,
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: ZetaSpacing.x10),
      child: DefaultTextStyle(
        style: ZetaTextStyles.bodyMedium,
        child: OutlinedButton(
          key: widget.itemKey,
          onPressed: widget.onPress,
          style: _getStyle(colors),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: ZetaSpacing.x3),
              if (leading != null) leading,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: ZetaSpacing.x2),
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
          ).paddingVertical(ZetaSpacing.x2_5),
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
        return widget.value.icon ??
            const SizedBox(
              width: 24,
            );
    }
  }

  ButtonStyle _getStyle(ZetaColors colors) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (widget.selected) {
          return colors.surfaceSelected;
        }
        if (states.contains(MaterialState.pressed)) {
          return colors.surfaceSelected;
        }
        if (states.contains(MaterialState.hovered)) {
          return colors.surfaceHovered;
        }

        return colors.surfacePrimary;
      }),
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.disabled)) {
          return colors.textDisabled;
        }
        return colors.textDefault;
      }),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
        ),
      ),
      side: const MaterialStatePropertyAll(BorderSide.none),
      padding: const MaterialStatePropertyAll(EdgeInsets.zero),
      elevation: const MaterialStatePropertyAll(0),
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<MaterialStatesController>(
        'controller',
        controller,
      ),
    );
  }
}

class _ZetaDropDownMenu<T> extends StatefulWidget {
  ///Constructor for [_ZetaDropDownMenu]
  const _ZetaDropDownMenu({
    required this.items,
    required this.onSelected,
    required this.selected,
    required this.allocateLeadingSpace,
    this.rounded = false,
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

  /// {@macro zeta-component-rounded}
  final bool rounded;

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
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
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
      padding: const EdgeInsets.all(ZetaSpacing.x3),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
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
                    rounded: widget.rounded,
                  );
                })
                .divide(const SizedBox(height: ZetaSpacing.x1))
                .toList(),
          );
        },
      ),
    );
  }
}
