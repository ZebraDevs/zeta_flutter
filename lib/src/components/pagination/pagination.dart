import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const _itemHeight = ZetaSpacing.x9;
const _itemWidth = ZetaSpacing.x8;

/// The type of a [ZetaPagination]
enum ZetaPaginationType {
  /// A standard pagination with buttons for each page.
  standard,

  /// A dropdown pagination.
  dropdown,
}

/// Pagination is used to switch between pages.
class ZetaPagination extends StatefulWidget {
  /// Creates a new [ZetaPagination]
  const ZetaPagination({
    required this.pages,
    this.type = ZetaPaginationType.standard,
    this.onChange,
    this.currentPage = 1,
    this.rounded = true,
    this.disabled = false,
    super.key,
  })  : assert(
          pages > 0,
          'Pages must be greater than zero',
        ),
        assert(
          currentPage >= 1 && currentPage <= pages,
          'currentPage must be greater than 1 and less than the number of pages',
        );

  /// The number of pages.
  final int pages;

  /// The current page.
  ///
  /// Defaults to 1
  final int currentPage;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Disables the pagination.
  final bool disabled;

  /// A callback executed every time the page changes.
  final void Function(int value)? onChange;

  /// The type of the pagination.
  /// A pagination dropdown will be enforced if there is not enough space for a standard dropdown.
  ///
  /// Default to [ZetaPaginationType.standard]
  final ZetaPaginationType type;

  @override
  State<ZetaPagination> createState() => _ZetaPaginationState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('pages', pages))
      ..add(IntProperty('currentPage', currentPage))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(ObjectFlagProperty<void Function(int value)?>.has('onChange', onChange))
      ..add(EnumProperty<ZetaPaginationType>('type', type));
  }
}

class _ZetaPaginationState extends State<ZetaPagination> {
  late int _currentPage;
  final _paginationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
  }

  @override
  void didUpdateWidget(covariant ZetaPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      setState(() {
        _currentPage = widget.currentPage;
      });
    }
  }

  void _onItemPressed(int value) {
    setState(() {
      _currentPage = value;
    });
    widget.onChange?.call(value);
  }

  _PaginationItem _getNumberedPaginationItem(int value) {
    return _PaginationItem(
      value: value,
      onPressed: () => _onItemPressed(value),
      selected: _currentPage == value,
      rounded: widget.rounded,
      disabled: widget.disabled,
    );
  }

  List<Widget> get numberedPaginationItems {
    if (widget.pages <= 6) {
      final List<Widget> items = [];
      for (int i = 1; i <= widget.pages; i++) {
        items.add(_getNumberedPaginationItem(i));
      }
      return items;
    }

    const totalCenterItems = 5;
    const initialIndex = 1;
    final finalIndex = widget.pages;

    final diffToEnd = finalIndex - _currentPage;
    final diffToStart = _currentPage - initialIndex;
    final showLeftElipsis = diffToStart > 2;
    final showRightElipsis = diffToEnd > 2;

    final List<Widget> items = [
      _getNumberedPaginationItem(initialIndex),
      if (showLeftElipsis) const _Elipsis(),
    ];

    if (!showLeftElipsis) {
      int itemCount = totalCenterItems;

      // Add items to the left of the current page
      for (int i = 0; i <= diffToStart; i++) {
        items.add(_getNumberedPaginationItem(i + 2));
        itemCount--;
      }
      // Add items to the right of the current page
      for (int i = _currentPage + 2; i <= _currentPage + itemCount; i++) {
        items.add(_getNumberedPaginationItem(i));
      }
    } else if (!showRightElipsis) {
      int itemCount = totalCenterItems;
      final List<Widget> newItems = [];
      for (int i = finalIndex - 1; i >= _currentPage; i--) {
        newItems.add(_getNumberedPaginationItem(i));
        itemCount--;
      }

      for (int i = _currentPage - 1; i >= _currentPage - itemCount + 1; i--) {
        newItems.add(_getNumberedPaginationItem(i));
      }
      items.addAll(newItems.reversed);
    } else {
      for (int i = -1; i <= 1; i++) {
        items.add(_getNumberedPaginationItem(_currentPage + i));
      }
    }

    items.addAll([
      if (showRightElipsis) const _Elipsis(),
      _getNumberedPaginationItem(finalIndex),
    ]);

    return items;
  }

  Widget get paginationDropdown {
    final colors = Zeta.of(context).colors;
    final List<DropdownMenuItem<int>> items = List.generate(
      widget.pages,
      (i) => DropdownMenuItem(
        value: i + 1,
        child: Text((i + 1).toString()),
      ),
    );
    return Container(
      height: ZetaSpacing.x10,
      decoration: BoxDecoration(
        border: Border.all(color: colors.borderSubtle),
        borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
      ),
      // TODO(mikecoomber): Replace with Zeta Dropdown
      child: DropdownButton(
        items: items,
        onChanged: (val) => _onItemPressed(val!),
        value: _currentPage,
        icon: Icon(
          widget.rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp,
        ).paddingStart(ZetaSpacing.x2),
        underline: const SizedBox(),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colors.textSubtle,
            ),
        padding: const EdgeInsets.symmetric(
          horizontal: ZetaSpacing.x3,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showDropdown =
            widget.type == ZetaPaginationType.dropdown || constraints.deviceType == DeviceType.mobilePortrait;

        final List<Widget> buttons = [
          if (!showDropdown)
            _PaginationItem(
              icon: widget.rounded ? ZetaIcons.first_page_round : ZetaIcons.first_page_sharp,
              onPressed: () => _onItemPressed(1),
              disabled: widget.disabled,
              rounded: widget.rounded,
            ),
          _PaginationItem(
            icon: widget.rounded ? ZetaIcons.chevron_left_round : ZetaIcons.chevron_left_sharp,
            onPressed: () => _onItemPressed(max(1, _currentPage - 1)),
            disabled: widget.disabled,
            rounded: widget.rounded,
          ),
          if (!showDropdown) ...numberedPaginationItems else paginationDropdown,
          _PaginationItem(
            icon: widget.rounded ? ZetaIcons.chevron_right_round : ZetaIcons.chevron_right_sharp,
            onPressed: () => _onItemPressed(
              min(widget.pages, _currentPage + 1),
            ),
            disabled: widget.disabled,
            rounded: widget.rounded,
          ),
          if (!showDropdown)
            _PaginationItem(
              icon: widget.rounded ? ZetaIcons.last_page_round : ZetaIcons.last_page_sharp,
              onPressed: () => _onItemPressed(
                widget.pages,
              ),
              disabled: widget.disabled,
              rounded: widget.rounded,
            ),
        ];

        return Row(
          key: _paginationKey,
          mainAxisSize: MainAxisSize.min,
          children: buttons.divide(const SizedBox(width: ZetaSpacing.x2)).toList(),
        );
      },
    );
  }
}

class _PaginationItem extends StatefulWidget {
  const _PaginationItem({
    required this.onPressed,
    required this.rounded,
    required this.disabled,
    this.selected = false,
    this.value,
    this.icon,
  });

  final VoidCallback onPressed;
  final int? value;
  final IconData? icon;
  final bool disabled;
  final bool selected;
  final bool rounded;

  @override
  State<_PaginationItem> createState() => _PaginationItemState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed))
      ..add(IntProperty('value', value))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

class _PaginationItemState extends State<_PaginationItem> {
  final _controller = MaterialStatesController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (context.mounted && mounted) {
        setState(() {});
      }
    });
  }

  Color _getColor(Set<MaterialState> states) {
    final colors = Zeta.of(context).colors;

    if (widget.disabled) {
      return colors.surfaceDisabled;
    }
    if (widget.selected) {
      return colors.cool[100]!;
    }
    if (states.contains(MaterialState.disabled)) {
      return colors.surfaceDisabled;
    }
    if (states.contains(MaterialState.pressed)) {
      return colors.surfaceSelected;
    }
    if (states.contains(MaterialState.hovered)) {
      return colors.surfaceHovered;
    }
    return colors.surfacePrimary;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    late final Widget child;

    if (widget.value != null) {
      child = Text(
        widget.value!.toString(),
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: widget.disabled
                  ? colors.textDisabled
                  : widget.selected
                      ? colors.textInverse
                      : colors.textDefault,
            ),
      );
    } else if (widget.icon != null) {
      child = Icon(
        widget.icon,
        color: widget.disabled ? colors.iconDisabled : colors.iconDefault,
      );
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: _itemHeight,
        maxHeight: _itemHeight,
        minWidth: _itemWidth,
      ),
      child: Material(
        // color: widget.selected ? colors.cool[100] : colors.surfacePrimary,
        borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
        child: InkWell(
          onTap: widget.disabled ? null : widget.onPressed,
          statesController: _controller,
          borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
          highlightColor: Colors.transparent,
          enableFeedback: false,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x1),
            decoration: BoxDecoration(
              color: _getColor(_controller.value),
              borderRadius: widget.rounded ? ZetaRadius.minimal : ZetaRadius.none,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _Elipsis extends StatelessWidget {
  const _Elipsis();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: _itemWidth,
      height: _itemHeight,
      child: Center(child: Text('...')),
    );
  }
}
