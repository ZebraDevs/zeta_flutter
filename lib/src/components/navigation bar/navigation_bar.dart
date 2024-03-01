import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// An item to be used in a [ZetaNavigationBar]
class ZetaNavigationBarItem {
  /// Creates a new [ZetaNavigationBarItem]
  const ZetaNavigationBarItem({
    required this.icon,
    required this.label,
    this.showBadge = false,
    this.badgeValue,
  });

  /// The icon shown on the item.
  final IconData icon;

  /// The label shown on the item.
  final String? label;

  /// Displays a small [ZetaIndicator] on the item.
  final bool showBadge;

  /// Displays a medium [ZetaIndicator] on the item with the given value.
  final int? badgeValue;
}

/// Navigation Bars (Bottom navigation) allow movement between primary destinations in an app.
class ZetaNavigationBar extends StatelessWidget {
  /// Creates a new [ZetaNavigationBar].
  const ZetaNavigationBar({
    required this.items,
    this.currentIndex,
    this.onTap,
    this.splitItems = false,
    this.dividerIndex,
    this.action,
    super.key,
  }) : assert(
          items.length >= 2 && items.length <= 6,
          'The number of items should be between 2 and 6',
        );

  /// Creates a [ZetaNavigationBar] with a divider after the item at the given index.
  const ZetaNavigationBar.divided({
    required List<ZetaNavigationBarItem> items,
    required int? dividerIndex,
    int? currentIndex,
    void Function(int value)? onTap,
    Key? key,
  }) : this(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          splitItems: true,
          dividerIndex: dividerIndex,
          key: key,
        );

  /// Creates a [ZetaNavigationBar] and splits the items in half.
  const ZetaNavigationBar.split({
    required List<ZetaNavigationBarItem> items,
    int? currentIndex,
    void Function(int value)? onTap,
    Key? key,
  }) : this(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          splitItems: true,
          key: key,
        );

  /// Creates a [ZetaNavigationBar] with an action.
  const ZetaNavigationBar.action({
    required List<ZetaNavigationBarItem> items,
    required Widget action,
    int? currentIndex,
    void Function(int value)? onTap,
    Key? key,
  }) : this(
          items: items,
          currentIndex: currentIndex,
          onTap: onTap,
          action: action,
          key: key,
        );

  /// The items displayed on the navigation bar.
  final List<ZetaNavigationBarItem> items;

  /// The index of the currently active item.
  final int? currentIndex;

  /// Called when an item is tapped with the index of the tapped item.
  final void Function(int value)? onTap;

  /// Divides the navigation items in half.
  final bool splitItems;

  /// The index of the item the divider should be displayed after.
  final int? dividerIndex;

  /// The action shown on the navigation bar.
  final Widget? action;

  Row _generateNavigationItemRow(List<ZetaNavigationBarItem> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((navItem) {
        final index = items.indexOf(navItem);
        return _NavigationItem(
          selected: index == currentIndex,
          item: navItem,
          onTap: () => onTap?.call(index),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    late Widget child;

    if (splitItems || dividerIndex != null) {
      final List<ZetaNavigationBarItem> leftItems = [];
      final List<ZetaNavigationBarItem> rightItems = [];
      final splitPoint = dividerIndex ?? (items.length / 2).floor();
      for (int i = 0; i < items.length; i++) {
        if (i < splitPoint) {
          leftItems.add(items[i]);
        } else {
          rightItems.add(items[i]);
        }
      }
      child = Row(
        mainAxisAlignment: splitItems ? MainAxisAlignment.spaceBetween : MainAxisAlignment.spaceAround,
        children: [
          _generateNavigationItemRow(leftItems),
          if (dividerIndex != null) Container(color: colors.borderSubtle, width: 1, height: 44),
          _generateNavigationItemRow(rightItems),
        ],
      );
    } else if (action != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _generateNavigationItemRow(items),
          action!,
        ],
      );
    } else {
      child = _generateNavigationItemRow(items);
    }

    return Container(
      padding: const EdgeInsets.only(
        left: ZetaSpacing.s,
        right: ZetaSpacing.s,
      ),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        border: Border(
          top: BorderSide(
            color: colors.borderSubtle,
            width: 2,
          ),
        ),
      ),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ZetaNavigationBarItem>('items', items))
      ..add(IntProperty('currentIndex', currentIndex))
      ..add(ObjectFlagProperty<void Function(int value)?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('splitItems', splitItems))
      ..add(IntProperty('dividerIndex', dividerIndex));
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.selected,
    required this.item,
    required this.onTap,
  });

  final bool selected;
  final ZetaNavigationBarItem item;
  final VoidCallback onTap;

  Widget _getBadge(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final size = item.badgeValue == null && item.showBadge ? ZetaWidgetSize.small : ZetaWidgetSize.medium;

    return Positioned(
      right: -2,
      top: -2,
      child: Container(
        padding: const EdgeInsets.all(0.25),
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: ZetaRadius.full,
        ),
        child: ZetaIndicator.notification(
          size: size,
          value: item.badgeValue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final elementColor = selected ? colors.primary : colors.textDisabled;

    return Material(
      color: colors.surfacePrimary,
      borderRadius: ZetaRadius.wide,
      child: InkWell(
        borderRadius: ZetaRadius.wide,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: ZetaSpacing.x4,
            vertical: ZetaSpacing.x2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Icon(
                    item.icon,
                    color: elementColor,
                  ),
                  if (item.showBadge || item.badgeValue != null) _getBadge(context),
                ],
              ),
              const SizedBox(height: ZetaSpacing.x2),
              if (item.label != null)
                Text(
                  item.label!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(color: elementColor),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<ZetaNavigationBarItem>('item', item))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}
