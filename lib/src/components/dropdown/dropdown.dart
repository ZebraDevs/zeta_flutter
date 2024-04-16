import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

enum ZetaDropdownMenuType {
  /// No Leading
  none,

  /// Circular checkbox
  checkbox,

  /// Square checkbox
  radio
}

enum ZetaDropdownSize {
  standard,
  mini,
}

class ZetaDropdownItem<T> {
  ZetaDropdownItem({
    String? label,
    required this.value,
    this.icon,
  }) {
    this.label = label ?? this.value.toString();
  }

  late final String label;
  final T value;
  final Widget? icon;
}

/// Class for [ZetaDropdown]
class ZetaDropdown<T> extends StatefulWidget {
  ///Constructor of [ZetaDropdown]
  const ZetaDropdown({
    super.key,
    required this.items,
    required this.onChange,
    required this.selectedItem,
    this.rounded = true,
    this.type = ZetaDropdownMenuType.none,
    this.size = ZetaDropdownSize.standard,
  });

  /// Input items as list of [_DropdownItem]
  final List<ZetaDropdownItem<T>> items;

  /// Currently selected item
  final T? selectedItem;

  /// Handles changes of dropdown menu
  final ValueSetter<T> onChange;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// The style for the leading widget. Can be a checkbox or radio button
  final ZetaDropdownMenuType type;

  /// If menu is minimised.
  final ZetaDropdownSize size;

  @override
  State<ZetaDropdown<T>> createState() => _ZetaDropDownState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaDropdownMenuType>('leadingType', type))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

class _ZetaDropDownState<T> extends State<ZetaDropdown<T>> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  final _menuKey = GlobalKey(); // declare a global key
  final _headerKey = GlobalKey();

  ZetaDropdownItem<T>? _selectedItem;

  late final bool showLeading;

  @override
  void initState() {
    super.initState();
    try {
      _selectedItem = widget.items.firstWhere((item) => item.value == widget.selectedItem);
    } catch (e) {
      _selectedItem = null;
    }
    showLeading =
        widget.type != ZetaDropdownMenuType.none || widget.items.map((item) => item.icon != null).contains(true);
  }

  /// Returns if click event position is within the header.
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
                    selected: widget.selectedItem,
                    rounded: widget.rounded,
                    showLeading: showLeading,
                    width: _size,
                    key: _menuKey,
                    menuType: widget.type,
                    onSelected: (item) {
                      setState(() {
                        _selectedItem = item;
                      });
                      widget.onChange(item.value);
                      _tooltipController.hide();
                    },
                  ),
                ),
              ),
            );
          },
          child: _DropdownItem(
            onPress: onTap,
            value: _selectedItem ?? widget.items.first,
            showLeading: showLeading,
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
    required this.showLeading,
    this.rounded = true,
    this.selected = false,
    this.menuType = ZetaDropdownMenuType.none,
    this.itemKey,
    this.onPress,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  final bool showLeading;

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
      );
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

    return DefaultTextStyle(
      style: ZetaTextStyles.bodyMedium,
      child: OutlinedButton(
        key: widget.itemKey,
        onPressed: widget.onPress,
        style: _getStyle(colors),
        child: Row(
          children: [
            const SizedBox(width: ZetaSpacing.x3),
            _getLeadingWidget(),
            const SizedBox(width: ZetaSpacing.x3),
            Text(
              widget.value.label,
            ),
          ],
        ).paddingVertical(ZetaSpacing.x2_5),
      ),
    );
  }

  Widget _getLeadingWidget() {
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
      case ZetaDropdownMenuType.none:
        return widget.value.icon ??
            SizedBox(
              width: widget.showLeading ? 24 : 0,
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
        if (states.contains(MaterialState.hovered)) {
          return colors.surfaceHovered;
        }
        if (states.contains(MaterialState.pressed)) {
          return colors.surfaceSelected;
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
    required this.showLeading,
    this.rounded = false,
    this.width,
    this.menuType = ZetaDropdownMenuType.none,
    super.key,
  });

  /// Input items for the menu
  final List<ZetaDropdownItem<T>> items;

  ///Handles clicking of item in menu
  final ValueSetter<ZetaDropdownItem<T>> onSelected;

  final bool showLeading;

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
      ..add(EnumProperty<ZetaDropdownMenuType?>('boxType', menuType));
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
                    showLeading: widget.showLeading,
                    menuType: widget.menuType,
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
