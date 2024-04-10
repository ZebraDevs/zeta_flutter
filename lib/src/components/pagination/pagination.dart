import 'dart:math';

import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const _itemHeight = ZetaSpacing.x9;
const _itemWidth = ZetaSpacing.x8;

class ZetaPagination extends StatefulWidget {
  final int pages;
  final int currentPage;
  final bool rounded;
  final bool disabled;
  final void Function(int value)? onChange;

  const ZetaPagination({
    required this.pages,
    this.onChange,
    this.currentPage = 0,
    this.rounded = true,
    this.disabled = false,
    super.key,
  }) : assert(
          pages > 0,
          'Pages must be greater than zero',
        );

  @override
  State<ZetaPagination> createState() => _ZetaPaginationState();
}

class _ZetaPaginationState extends State<ZetaPagination> {
  late int _currentPage;

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

  List<Widget> _buildPaginationItems() {
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
    // TODO refactor this, most of it sucks
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> buttons = [
      _PaginationItem(
        icon: widget.rounded ? ZetaIcons.first_page_round : ZetaIcons.first_page_sharp,
        onPressed: () => _onItemPressed(1),
        disabled: widget.disabled || _currentPage == 1,
        rounded: widget.rounded,
      ),
      _PaginationItem(
        icon: widget.rounded ? ZetaIcons.chevron_left_round : ZetaIcons.chevron_left_sharp,
        onPressed: () => _onItemPressed(max(1, _currentPage - 1)),
        disabled: widget.disabled || _currentPage == 1,
        rounded: widget.rounded,
      ),
      ..._buildPaginationItems(),
      _PaginationItem(
        icon: widget.rounded ? ZetaIcons.chevron_right_round : ZetaIcons.cellular_signal_sharp,
        onPressed: () => _onItemPressed(
          min(widget.pages, _currentPage + 1),
        ),
        disabled: widget.disabled || _currentPage == widget.pages,
        rounded: widget.rounded,
      ),
      _PaginationItem(
        icon: widget.rounded ? ZetaIcons.last_page_round : ZetaIcons.last_page_sharp,
        onPressed: () => _onItemPressed(
          widget.pages,
        ),
        disabled: widget.disabled || _currentPage == widget.pages,
        rounded: widget.rounded,
      ),
    ];

    return Row(
      children: buttons.divide(const SizedBox(width: ZetaSpacing.x2)).toList(),
    );
  }
}

class _PaginationItem extends StatelessWidget {
  const _PaginationItem({
    required this.onPressed,
    required this.rounded,
    required this.disabled,
    this.selected = false,
    this.value,
    this.icon,
    super.key,
  });

  final VoidCallback onPressed;
  final int? value;
  final IconData? icon;
  final bool disabled;
  final bool selected;
  final bool rounded;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    late final Widget child;

    if (value != null) {
      child = Text(
        value!.toString(),
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: disabled
                  ? colors.textDisabled
                  : selected
                      ? colors.textInverse
                      : colors.textDefault,
            ),
      );
    } else if (icon != null) {
      child = Icon(icon);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: _itemHeight,
        minWidth: _itemWidth,
        maxWidth: _itemWidth * 1.5,
      ),
      child: FilledButton(
        onPressed: !disabled ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (selected) {
                return colors.cool[100];
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
            },
          ),
          elevation: const MaterialStatePropertyAll(0),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          foregroundColor: MaterialStateColor.resolveWith((_) {
            if (disabled) {
              return colors.iconDisabled;
            }
            return colors.iconDefault;
          }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}

class _Elipsis extends StatelessWidget {
  const _Elipsis({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _itemWidth,
      height: _itemHeight,
      child: Center(child: Text('...')),
    );
  }
}
