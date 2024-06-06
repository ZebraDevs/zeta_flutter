import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

enum _MenuPosition { top, bottom }

/// Class for [ZetaSelectInput]
class ZetaSelectInput extends StatefulWidget {
  ///Constructor of [ZetaSelectInput]
  const ZetaSelectInput({
    super.key,
    required this.items,
    this.onChanged,
    this.onTextChanged,
    this.selectedItem,
    this.size,
    this.leadingIcon,
    this.label,
    this.hint,
    this.enabled = true,
    this.rounded = true,
    this.hasError = false,
    this.errorText,
  });

  /// Input items as list of [ZetaSelectInputItem]
  final List<ZetaSelectInputItem> items;

  /// Currently selected item
  final ZetaSelectInputItem? selectedItem;

  /// Handles changes of select menu
  final ValueSetter<ZetaSelectInputItem?>? onChanged;

  /// Handles changes of input text
  final ValueSetter<String>? onTextChanged;

  /// Determines the size of the input field.
  /// Default is `ZetaDateInputSize.large`
  final ZetaWidgetSize? size;

  /// The input's leading icon.
  final Widget? leadingIcon;

  /// If provided, displays a label above the input field.
  final Widget? label;

  /// If provided, displays a hint below the input field.
  final String? hint;

  /// Determines if the input field should be enabled (default) or disabled.
  final bool enabled;

  /// Determines if the input field should be displayed in error style.
  /// Default is `false`.
  /// If `enabled` is `false`, this has no effect.
  final bool hasError;

  /// In combination with `hasError: true`, provides the error message
  /// to be displayed below the input field.
  final String? errorText;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  @override
  State<ZetaSelectInput> createState() => _ZetaSelectInputState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(
        ObjectFlagProperty<ValueSetter<ZetaSelectInputItem?>?>.has(
          'onChanged',
          onChanged,
        ),
      )
      ..add(EnumProperty<ZetaWidgetSize?>('size', size))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('hasError', hasError))
      ..add(StringProperty('errorText', errorText))
      ..add(ObjectFlagProperty<ValueSetter<String>?>.has('onTextChanged', onTextChanged));
  }
}

class _ZetaSelectInputState extends State<ZetaSelectInput> {
  final OverlayPortalController _overlayController = OverlayPortalController();
  final _link = LayerLink();
  late String? _selectedValue;
  late List<ZetaSelectInputItem> _menuItems;
  Size _menuSize = Size.zero;
  _MenuPosition? _menuPosition = _MenuPosition.bottom;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.selectedItem?.value;
    _menuItems = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: _menuPosition == _MenuPosition.top ? Alignment.topLeft : Alignment.bottomLeft,
            followerAnchor: _menuPosition == _MenuPosition.top ? Alignment.bottomLeft : Alignment.topLeft,
            child: Align(
              alignment: _menuPosition == _MenuPosition.top ? Alignment.bottomLeft : Alignment.topLeft,
              child: _ZetaSelectInputMenu(
                size: _menuSize,
                itemSize: widget.size,
                items: _menuItems,
                selectedValue: _selectedValue,
                onSelected: (item) {
                  if (item != null) {
                    _selectedValue = item.value;
                    widget.onChanged?.call(item);
                  }
                  _overlayController.hide();
                },
                rounded: widget.rounded,
              ),
            ),
          );
        },
        child: _InputComponent(
          size: widget.size,
          label: widget.label,
          hint: widget.hint,
          leadingIcon: widget.leadingIcon,
          enabled: widget.enabled,
          rounded: widget.rounded,
          hasError: widget.hasError,
          errorText: widget.errorText,
          initialValue: _selectedValue,
          onToggleMenu: widget.items.isEmpty
              ? null
              : () {
                  if (_overlayController.isShowing) {
                    _overlayController.hide();
                    return setState(() {});
                  }
                  final box = context.findRenderObject() as RenderBox?;
                  final offset = box?.size.topLeft(
                    box.localToGlobal(Offset.zero),
                  );
                  final upperHeight = offset?.dy ?? 0;
                  final lowerHeight = MediaQuery.of(context).size.height - upperHeight - (box?.size.height ?? 0);
                  setState(() {
                    _menuPosition = upperHeight > lowerHeight ? _MenuPosition.top : _MenuPosition.bottom;
                    _menuSize = Size(
                      box?.size.width ?? (MediaQuery.of(context).size.width - ZetaSpacing.xL6),
                      (upperHeight > lowerHeight ? upperHeight : lowerHeight) - ZetaSpacing.xL2,
                    );
                    _menuItems = List.from(widget.items);
                  });
                  _overlayController.show();
                },
          menuIsShowing: _overlayController.isShowing,
          onChanged: (value) {
            widget.onTextChanged?.call(value);
            _selectedValue = value;
            _menuItems = widget.items
                .where(
                  (item) => item.value.toLowerCase().contains(value.toLowerCase()),
                )
                .toList();
            final item = widget.items.firstWhereOrNull(
              (item) => item.value.toLowerCase() == value.toLowerCase(),
            );
            widget.onChanged?.call(item);
            setState(() {});
          },
        ),
      ),
    );
  }
}

class _InputComponent extends StatefulWidget {
  const _InputComponent({
    this.size,
    this.label,
    this.hint,
    this.leadingIcon,
    this.enabled = true,
    this.rounded = true,
    this.hasError = false,
    this.errorText,
    this.initialValue,
    this.onChanged,
    this.onToggleMenu,
    this.menuIsShowing = false,
  });

  final ZetaWidgetSize? size;
  final Widget? label;
  final String? hint;
  final Widget? leadingIcon;
  final bool enabled;
  final bool rounded;
  final bool hasError;
  final String? errorText;
  final String? initialValue;
  final void Function(String)? onChanged;
  final VoidCallback? onToggleMenu;
  final bool menuIsShowing;

  @override
  State<_InputComponent> createState() => _InputComponentState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetSize>('size', size))
      ..add(StringProperty('hint', hint))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('hasError', hasError))
      ..add(StringProperty('errorText', errorText))
      ..add(ObjectFlagProperty<void Function(String p1)?>.has('onChanged', onChanged))
      ..add(ObjectFlagProperty<void Function()?>.has('onToggleMenu', onToggleMenu))
      ..add(DiagnosticsProperty<bool>('menuIsShowing', menuIsShowing))
      ..add(StringProperty('initialValue', initialValue));
  }
}

class _InputComponentState extends State<_InputComponent> {
  final _controller = TextEditingController();
  late ZetaWidgetSize _size;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _setParams();
  }

  @override
  void didUpdateWidget(_InputComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    _setParams();
  }

  void _setParams() {
    _controller.text = widget.initialValue ?? '';
    _size = widget.size ?? ZetaWidgetSize.large;
    _hasError = widget.hasError;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final showError = _hasError && widget.errorText != null;
    final hintErrorColor = widget.enabled
        ? showError
            ? zeta.colors.red
            : zeta.colors.cool.shade70
        : zeta.colors.cool.shade50;
    final iconSize = _iconSize(_size);
    final inputVerticalPadding = _inputVerticalPadding(_size);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: DefaultTextStyle(
              style: ZetaTextStyles.bodyMedium.copyWith(
                color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
              ),
              child: widget.label!,
            ),
          ),
        TextFormField(
          enabled: widget.enabled,
          controller: _controller,
          onChanged: widget.onChanged,
          style: _size == ZetaWidgetSize.small ? ZetaTextStyles.bodyXSmall : ZetaTextStyles.bodyMedium,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: inputVerticalPadding,
            ),
            prefixIcon: widget.leadingIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: ZetaSpacingBase.x2_5, right: ZetaSpacing.small),
                    child: IconTheme(
                      data: IconThemeData(
                        color: widget.enabled ? zeta.colors.cool.shade70 : zeta.colors.cool.shade50,
                        size: iconSize,
                      ),
                      child: widget.leadingIcon!,
                    ),
                  ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: ZetaSpacing.xL2,
              minWidth: ZetaSpacing.xL2,
            ),
            suffixIcon: widget.onToggleMenu == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: ZetaSpacing.minimum),
                    child: IconButton(
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      onPressed: widget.onToggleMenu,
                      icon: Icon(
                        widget.menuIsShowing
                            ? (widget.rounded ? ZetaIcons.expand_less_round : ZetaIcons.expand_less_sharp)
                            : (widget.rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp),
                        color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                        size: iconSize,
                      ),
                    ),
                  ),
            suffixIconConstraints: const BoxConstraints(
              minHeight: ZetaSpacing.xL2,
              minWidth: ZetaSpacing.xL2,
            ),
            hintStyle: _size == ZetaWidgetSize.small
                ? ZetaTextStyles.bodyXSmall.copyWith(
                    color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                  )
                : ZetaTextStyles.bodyMedium.copyWith(
                    color: widget.enabled ? zeta.colors.textDefault : zeta.colors.cool.shade50,
                  ),
            filled: !widget.enabled || _hasError ? true : null,
            fillColor: widget.enabled
                ? _hasError
                    ? zeta.colors.red.shade10
                    : null
                : zeta.colors.cool.shade30,
            enabledBorder: _hasError
                ? _errorInputBorder(zeta, rounded: widget.rounded)
                : _defaultInputBorder(zeta, rounded: widget.rounded),
            focusedBorder: _hasError
                ? _errorInputBorder(zeta, rounded: widget.rounded)
                : _focusedInputBorder(zeta, rounded: widget.rounded),
            disabledBorder: _defaultInputBorder(zeta, rounded: widget.rounded),
            errorBorder: _errorInputBorder(zeta, rounded: widget.rounded),
            focusedErrorBorder: _errorInputBorder(zeta, rounded: widget.rounded),
          ),
        ),
        if (widget.hint != null || showError)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: ZetaSpacing.small),
                  child: Icon(
                    showError && widget.enabled
                        ? (widget.rounded ? ZetaIcons.error_round : ZetaIcons.error_sharp)
                        : (widget.rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp),
                    size: ZetaSpacing.large,
                    color: hintErrorColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    showError && widget.enabled ? widget.errorText! : widget.hint!,
                    style: ZetaTextStyles.bodyXSmall.copyWith(
                      color: hintErrorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  double _inputVerticalPadding(ZetaWidgetSize size) => switch (size) {
        ZetaWidgetSize.large => ZetaSpacing.medium,
        ZetaWidgetSize.medium => ZetaSpacing.small,
        ZetaWidgetSize.small => ZetaSpacing.small,
      };

  double _iconSize(ZetaWidgetSize size) => switch (size) {
        ZetaWidgetSize.large => ZetaSpacing.xL,
        ZetaWidgetSize.medium => ZetaSpacing.xL,
        ZetaWidgetSize.small => ZetaSpacing.large,
      };

  OutlineInputBorder _defaultInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.cool.shade40),
      );

  OutlineInputBorder _focusedInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.blue.shade50),
      );

  OutlineInputBorder _errorInputBorder(
    Zeta zeta, {
    required bool rounded,
  }) =>
      OutlineInputBorder(
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        borderSide: BorderSide(color: zeta.colors.red.shade50),
      );
}

/// Class for [ZetaSelectInputItem]
class ZetaSelectInputItem extends StatelessWidget {
  ///Public constructor for [ZetaSelectInputItem]
  const ZetaSelectInputItem({
    super.key,
    required this.value,
    this.size = ZetaWidgetSize.large,
  })  : rounded = true,
        selected = false,
        onPressed = null;

  const ZetaSelectInputItem._({
    super.key,
    required this.rounded,
    required this.selected,
    required this.value,
    this.onPressed,
    this.size = ZetaWidgetSize.large,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// If [ZetaSelectInputItem] is selected
  final bool selected;

  /// Value of [ZetaSelectInputItem]
  final String value;

  /// Handles clicking for [ZetaSelectInputItem]
  final VoidCallback? onPressed;

  /// The size of [ZetaSelectInputItem]
  final ZetaWidgetSize size;

  /// Returns copy of [ZetaSelectInputItem] with those private variables included
  ZetaSelectInputItem copyWith({
    bool? rounded,
    bool? selected,
    VoidCallback? onPressed,
    ZetaWidgetSize? size,
  }) {
    return ZetaSelectInputItem._(
      rounded: rounded ?? this.rounded,
      selected: selected ?? this.selected,
      onPressed: onPressed ?? this.onPressed,
      size: size ?? this.size,
      value: value,
      key: key,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(StringProperty('value', value))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onPressed', onPressed))
      ..add(EnumProperty<ZetaWidgetSize>('size', size));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return DefaultTextStyle(
      style: ZetaTextStyles.bodyMedium,
      child: OutlinedButton(
        onPressed: onPressed,
        style: _getStyle(colors, size),
        child: Text(value),
      ),
    );
  }

  ButtonStyle _getStyle(ZetaColors colors, ZetaWidgetSize size) {
    final visualDensity = switch (size) {
      ZetaWidgetSize.large => 0.0,
      ZetaWidgetSize.medium => -2.0,
      ZetaWidgetSize.small => -4.0,
    };
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return colors.surfaceHover;
        }

        if (states.contains(WidgetState.pressed)) {
          return colors.surfaceSelected;
        }

        if (states.contains(WidgetState.disabled) || onPressed == null) {
          return colors.surfaceDisabled;
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
          borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        ),
      ),
      side: WidgetStatePropertyAll(
        selected ? BorderSide(color: colors.primary.shade60) : BorderSide.none,
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: ZetaSpacing.large),
      ),
      elevation: const WidgetStatePropertyAll(0),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      textStyle: WidgetStatePropertyAll<TextStyle>(
        size == ZetaWidgetSize.small ? ZetaTextStyles.bodyXSmall : ZetaTextStyles.bodyMedium,
      ),
      minimumSize: const WidgetStatePropertyAll<Size>(Size.fromHeight(ZetaSpacing.xL8)),
      alignment: Alignment.centerLeft,
      visualDensity: VisualDensity(
        horizontal: visualDensity,
        vertical: visualDensity,
      ),
    );
  }
}

class _ZetaSelectInputMenu extends StatelessWidget {
  const _ZetaSelectInputMenu({
    required this.items,
    required this.onSelected,
    required this.size,
    this.selectedValue,
    this.rounded = true,
    this.itemSize,
  });

  /// Input items for the menu
  final List<ZetaSelectInputItem> items;

  /// Handles selecting an item from the menu
  final ValueSetter<ZetaSelectInputItem?> onSelected;

  /// The value of the currently selected item
  final String? selectedValue;

  /// The size of the menu.
  final Size size;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// The size of [ZetaSelectInputItem]
  final ZetaWidgetSize? itemSize;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<ValueSetter<ZetaSelectInputItem?>>.has(
          'onSelected',
          onSelected,
        ),
      )
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('selectedValue', selectedValue))
      ..add(DiagnosticsProperty<Size>('size', size))
      ..add(EnumProperty<ZetaWidgetSize>('itemSize', itemSize));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: size.width,
        maxHeight: size.height,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) {
              return item.copyWith(
                rounded: rounded,
                selected: selectedValue?.toLowerCase() == item.value.toLowerCase(),
                onPressed: () => onSelected(item),
                size: itemSize,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
