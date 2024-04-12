import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

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
    this.leadingType = LeadingStyle.none,
    this.isMinimized = false,
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
  final LeadingStyle leadingType;

  /// If menu is minimised.
  final bool isMinimized;

  @override
  State<ZetaDropdown<T>> createState() => _ZetaDropDownState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<LeadingStyle>('leadingType', leadingType))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('isMinimized', isMinimized));
  }
}

class _ZetaDropDownState<T> extends State<ZetaDropdown<T>> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();
  final _menuKey = GlobalKey(); // declare a global key

  ZetaDropdownItem<T>? _selectedItem;

  @override
  void initState() {
    super.initState();
    try {
      _selectedItem = widget.items.firstWhere((item) => item.value == widget.selectedItem);
    } catch (e) {
      _selectedItem = null;
    }
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
                    final headerBox = _menuKey.currentContext!.findRenderObject()! as RenderBox;

                    final headerPosition = headerBox.localToGlobal(Offset.zero);

                    if (!_isInHeader(
                      headerPosition,
                      headerBox.size,
                      event.position,
                    )) _tooltipController.hide();
                  },
                  child: _ZetaDropDownMenu<T>(
                    items: widget.items,
                    selected: widget.selectedItem,
                    rounded: widget.rounded,
                    width: _size,
                    boxType: widget.leadingType,
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
          child: GestureDetector(onTap: onTap, child: Text(_selectedItem?.label ?? 'Select...')),
        ),
      ),
    );
  }

  double get _size => widget.isMinimized ? 120 : 320;

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

/// Checkbox enum for different checkbox types
enum LeadingStyle {
  /// No Leading
  none,

  /// Circular checkbox
  checkbox,

  /// Square checkbox
  radio
}

/// Class for [_DropdownItem]
class _DropdownItem<T> extends StatefulWidget {
  ///Public constructor for [_DropdownItem]
  const _DropdownItem({
    super.key,
    required this.value,
    this.leadingIcon,
    this.rounded = true,
    this.selected = false,
    this.leadingType = LeadingStyle.none,
    this.itemKey = null,
    this.onPress = null,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// If [_DropdownItem] is selected
  final bool selected;

  /// Value of [_DropdownItem]
  final ZetaDropdownItem<T> value;

  /// Leading icon for [_DropdownItem]
  final Icon? leadingIcon;

  /// Handles clicking for [_DropdownItem]
  final VoidCallback? onPress;

  /// If checkbox is to be shown, the type of it.
  final LeadingStyle? leadingType;

  /// Key for item
  final GlobalKey? itemKey;

  @override
  State<_DropdownItem> createState() => _ZetaDropdownMenuItemState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPress', onPress))
      ..add(EnumProperty<LeadingStyle?>('leadingType', leadingType))
      ..add(
        DiagnosticsProperty<GlobalKey<State<StatefulWidget>>?>(
          'itemKey',
          itemKey,
        ),
      );
  }
}

class _ZetaDropdownMenuItemState extends State<_DropdownItem> {
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
    switch (widget.leadingType!) {
      case LeadingStyle.checkbox:
        return Checkbox(
          value: widget.selected,
          onChanged: (val) {
            widget.onPress!.call();
          },
        );
      case LeadingStyle.radio:
        return Radio(
          value: widget.selected,
          groupValue: true,
          onChanged: (val) {
            widget.onPress!.call();
          },
        );
      case LeadingStyle.none:
        return widget.leadingIcon ??
            const SizedBox(
              width: 24,
            );
    }
  }

  ButtonStyle _getStyle(ZetaColors colors) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return colors.surfaceHovered;
        }

        if (states.contains(MaterialState.pressed)) {
          return colors.surfaceSelected;
        }

        if (states.contains(MaterialState.disabled) || widget.onPress == null) {
          return colors.surfaceDisabled;
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
      side: MaterialStatePropertyAll(
        widget.selected ? BorderSide(color: colors.primary.shade60) : BorderSide.none,
      ),
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
    this.rounded = false,
    this.width,
    this.boxType,
  });

  /// Input items for the menu
  final List<ZetaDropdownItem<T>> items;

  ///Handles clicking of item in menu
  final ValueSetter<ZetaDropdownItem<T>> onSelected;

  final T? selected;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Width for menu
  final double? width;

  /// If items have checkboxes, the type of that checkbox.
  final LeadingStyle? boxType;

  @override
  State<_ZetaDropDownMenu<T>> createState() => _ZetaDropDownMenuState<T>();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DoubleProperty('width', width))
      ..add(EnumProperty<LeadingStyle?>('boxType', boxType));
  }
}

class _ZetaDropDownMenuState<T> extends State<_ZetaDropDownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return Container(
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
            children: widget.items.map((item) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DropdownItem(
                    value: item,
                    onPress: () => widget.onSelected(item),
                  ),
                  const SizedBox(height: ZetaSpacing.x1),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
