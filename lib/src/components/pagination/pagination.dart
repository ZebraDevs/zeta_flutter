import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// The type of a [ZetaPagination]
enum ZetaPaginationType {
  /// A standard pagination with buttons for each page.
  standard,

  /// A dropdown pagination.
  dropdown,
}

/// Pagination is used to switch between pages.
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-24&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/pagination
class ZetaPagination extends ZetaStatefulWidget {
  /// Creates a new [ZetaPagination]
  const ZetaPagination({
    super.rounded,
    super.key,
    required this.pages,
    this.type = ZetaPaginationType.standard,
    this.onChange,
    this.currentPage = 1,
    this.semanticFirst,
    this.semanticPrevious,
    this.semanticNext,
    this.semanticLast,
    this.semanticDropdown,
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

  /// A callback executed every time the page changes.
  ///
  /// {@macro zeta-widget-change-disable}
  final void Function(int value)? onChange;

  /// The type of the pagination.
  /// A pagination dropdown will be enforced if there is not enough space for a standard dropdown.
  ///
  /// Default to [ZetaPaginationType.standard]
  final ZetaPaginationType type;

  /// Semantic value passed to the first button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticFirst;

  /// Semantic value passed to the previous button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticPrevious;

  /// Semantic value passed to the next button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticNext;

  /// Semantic value passed to the last button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLast;

  /// Semantic value passed to the dropdown.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticDropdown;

  @override
  State<ZetaPagination> createState() => _ZetaPaginationState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('pages', pages))
      ..add(IntProperty('currentPage', currentPage))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<void Function(int value)?>.has('onChange', onChange))
      ..add(EnumProperty<ZetaPaginationType>('type', type))
      ..add(StringProperty('semanticLast', semanticLast))
      ..add(StringProperty('semanticFirst', semanticFirst))
      ..add(StringProperty('semanticPrevious', semanticPrevious))
      ..add(StringProperty('semanticNext', semanticNext))
      ..add(StringProperty('semanticDropdown', semanticDropdown));
  }
}

class _ZetaPaginationState extends State<ZetaPagination> {
  late int _currentPage;
  final _paginationKey = GlobalKey();

  bool get _disabled => widget.onChange == null;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
  }

  @override
  void didUpdateWidget(covariant ZetaPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPage != widget.currentPage) {
      _currentPage = widget.currentPage;
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
      disabled: _disabled,
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
    final rounded = context.rounded;

    final List<DropdownMenuItem<int>> items = List.generate(
      widget.pages,
      (i) => DropdownMenuItem(
        value: i + 1,
        child: Text((i + 1).toString()),
      ),
    );
    return Semantics(
      label: widget.semanticDropdown,
      child: Container(
        height: Zeta.of(context).spacing.xl_6,

        decoration: BoxDecoration(
          border: Border.all(color: colors.borderSubtle),
          borderRadius: rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
        ),
        // TODO(UX-1135): Replace with Zeta Dropdown
        child: DropdownButton(
          items: items,
          onChanged: (val) => _onItemPressed(val!),
          value: _currentPage,
          icon: const ZetaIcon(ZetaIcons.expand_more).paddingStart(Zeta.of(context).spacing.small),
          underline: const Nothing(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colors.mainSubtle,
              ),
          padding: EdgeInsets.symmetric(
            horizontal: Zeta.of(context).spacing.medium,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showDropdown =
              widget.type == ZetaPaginationType.dropdown || constraints.deviceType == DeviceType.mobilePortrait;

          final List<Widget> buttons = [
            if (!showDropdown)
              _PaginationItem(
                icon: ZetaIcons.first_page,
                onPressed: () => _onItemPressed(1),
                disabled: _disabled || _currentPage == 1,
                semanticLabel: widget.semanticFirst,
              ),
            _PaginationItem(
              icon: ZetaIcons.chevron_left,
              onPressed: () => _onItemPressed(max(1, _currentPage - 1)),
              disabled: _disabled || _currentPage == 1,
              semanticLabel: widget.semanticPrevious,
            ),
            if (!showDropdown) ...numberedPaginationItems else paginationDropdown,
            _PaginationItem(
              icon: ZetaIcons.chevron_right,
              onPressed: () => _onItemPressed(min(widget.pages, _currentPage + 1)),
              disabled: _disabled || _currentPage == widget.pages,
              semanticLabel: widget.semanticNext,
            ),
            if (!showDropdown)
              _PaginationItem(
                icon: ZetaIcons.last_page,
                onPressed: () => _onItemPressed(widget.pages),
                disabled: _disabled || _currentPage == widget.pages,
                semanticLabel: widget.semanticLast,
              ),
          ];

          return Row(
            key: _paginationKey,
            mainAxisSize: MainAxisSize.min,
            children: buttons.divide(SizedBox(width: Zeta.of(context).spacing.small)).toList(),
          );
        },
      ),
    );
  }
}

class _PaginationItem extends ZetaStatelessWidget {
  const _PaginationItem({
    required this.onPressed,
    required this.disabled,
    this.selected = false,
    this.value,
    this.icon,
    this.semanticLabel,
  });

  final VoidCallback onPressed;
  final int? value;
  final IconData? icon;
  final bool disabled;
  final bool selected;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final rounded = context.rounded;

    late final Widget child;

    if (value != null) {
      child = Text(
        value!.toString(),
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: disabled
                  ? colors.mainDisabled
                  : selected
                      ? colors.mainInverse
                      : colors.mainDefault,
            ),
      );
    } else if (icon != null) {
      child = ZetaIcon(
        icon,
        color: disabled ? colors.mainDisabled : colors.mainDefault,
        semanticLabel: semanticLabel,
      );
    }

    final itemHeight = Zeta.of(context).spacing.xl_5;
    final itemWidth = Zeta.of(context).spacing.xl_4;

    return Semantics(
      button: true,
      enabled: !disabled,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: itemHeight,
          maxHeight: itemHeight,
          minWidth: itemWidth,
        ),
        child: Material(
          borderRadius: rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
          color: disabled
              ? colors.stateDisabledDisabled
              : selected
                  ? colors.stateInverseSelected
                  : colors.stateDefaultEnabled,
          child: InkWell(
            onTap: disabled ? null : onPressed,
            borderRadius: rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
            hoverColor: selected ? colors.stateInverseHover : colors.stateDefaultHover,
            enableFeedback: false,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.minimum),
              decoration: BoxDecoration(
                borderRadius: rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed))
      ..add(IntProperty('value', value))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _Elipsis extends StatelessWidget {
  const _Elipsis();

  @override
  Widget build(BuildContext context) {
    final itemHeight = Zeta.of(context).spacing.xl_5;
    final itemWidth = Zeta.of(context).spacing.xl_4;
    return SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: const Center(child: Text('...')),
    );
  }
}
