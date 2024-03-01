import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

class ZetaNavigationBarItem {
  const ZetaNavigationBarItem({
    required this.icon,
    this.label,
    this.showBadge = false,
    this.badgeValue,
  });

  final IconData icon;
  final String? label;
  final bool showBadge;
  final int? badgeValue;
}

class ZetaNavigationBar extends StatelessWidget {
  const ZetaNavigationBar({
    required this.items,
    this.currentIndex,
    this.onTap,
    super.key,
    this.splitItems = false,
    this.dividerIndex,
    this.action,
  }) : assert(
          items.length >= 2 && items.length <= 6,
          'The number of items should be between 2 and 6',
        );

  final List<ZetaNavigationBarItem> items;
  final int? currentIndex;
  final void Function(int value)? onTap;
  final bool splitItems;
  final int? dividerIndex;
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
        }).toList());
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
}
