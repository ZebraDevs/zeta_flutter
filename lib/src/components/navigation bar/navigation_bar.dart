import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const double _navigationItemBorderWidth = 1;

/// An item to be used in a [ZetaNavigationBar].
class ZetaNavigationBarItem {
  /// Creates a new [ZetaNavigationBarItem]
  const ZetaNavigationBarItem({
    required this.icon,
    required this.label,
    this.badge,
  });

  /// The icon shown on the item.
  final IconData icon;

  /// The label shown on the item.
  final String? label;

  /// [ZetaIndicator] badge to show on navigation item.
  final ZetaIndicator? badge;
}

/// Navigation Bars (Bottom navigation) allow movement between primary destinations in an app.
/// {@category Components}
class ZetaNavigationBar extends ZetaStatelessWidget {
  /// Creates a new [ZetaNavigationBar].
  const ZetaNavigationBar({
    super.key,
    super.rounded,
    required this.items,
    this.currentIndex,
    this.onTap,
    this.splitItems = false,
    this.dividerIndex,
    this.action,
    this.semanticLabel,
  }) : assert(
          items.length >= 2 && items.length <= 6,
          'The number of items should be between 2 and 6',
        );

  /// Creates a [ZetaNavigationBar] with a divider after the item at the given index.
  const ZetaNavigationBar.divided({
    super.rounded,
    super.key,
    required this.items,
    this.currentIndex,
    this.onTap,
    this.dividerIndex,
    this.semanticLabel,
  })  : splitItems = false,
        action = null;

  /// Creates a [ZetaNavigationBar] and splits the items in half.

  const ZetaNavigationBar.split({
    super.rounded,
    super.key,
    required this.items,
    this.currentIndex,
    this.onTap,
    this.dividerIndex,
    this.semanticLabel,
  })  : splitItems = true,
        action = null;

  /// Creates a [ZetaNavigationBar] with an action.
  const ZetaNavigationBar.action({
    super.key,
    super.rounded,
    required this.items,
    required this.action,
    this.currentIndex,
    this.onTap,
    this.semanticLabel,
  })  : dividerIndex = null,
        splitItems = false;

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

  /// Value passed to the [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

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

    final Widget child;

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
          if (dividerIndex != null)
            Container(
              color: colors.borderSubtle,
              width: _navigationItemBorderWidth,
              height: ZetaSpacing.xl_7,
            ),
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
      padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.medium),
      decoration: BoxDecoration(
        color: colors.surfacePrimary,
        border: Border(top: BorderSide(color: colors.borderSubtle)),
      ),
      child: Semantics(
        child: child,
      ),
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
      ..add(IntProperty('dividerIndex', dividerIndex))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _NavigationItem extends ZetaStatelessWidget {
  const _NavigationItem({
    required this.selected,
    required this.item,
    required this.onTap,
  });

  final bool selected;
  final ZetaNavigationBarItem item;
  final VoidCallback onTap;

  Widget _getBadge(ZetaColors colors) {
    return Positioned(
      right: ZetaSpacing.minimum,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfacePrimary,
          borderRadius: ZetaRadius.full,
        ),
        child: item.badge?.copyWith(
          size: item.badge?.value == null
              ? ZetaWidgetSize.small
              : item.badge?.size == ZetaWidgetSize.large
                  ? ZetaWidgetSize.medium
                  : null,
          type: ZetaIndicatorType.notification,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final elementColor = selected ? colors.primary : colors.textSubtle;

    return Material(
      color: colors.surfacePrimary,
      child: InkWell(
        borderRadius: context.rounded ? ZetaRadius.rounded : ZetaRadius.none,
        onTap: onTap,
        child: Semantics(
          button: true,
          explicitChildNodes: true,
          label: item.label,
          child: Container(
            padding:
                const EdgeInsets.only(left: ZetaSpacing.small, right: ZetaSpacing.small, bottom: ZetaSpacing.small),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: ZetaSpacing.xl_7,
                  height: ZetaSpacing.xl_4 - _navigationItemBorderWidth,
                  child: Stack(
                    children: [
                      Positioned(
                        left: ZetaSpacingBase.x2_5,
                        top: ZetaSpacing.small - _navigationItemBorderWidth,
                        right: ZetaSpacingBase.x2_5,
                        child: ZetaIcon(item.icon, color: elementColor, size: ZetaSpacing.xl_2),
                      ),
                      if (item.badge != null) _getBadge(colors),
                    ],
                  ),
                ),
                const SizedBox(height: ZetaSpacing.small),
                if (item.label != null)
                  ExcludeSemantics(
                    child: Text(
                      item.label!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: elementColor),
                    ),
                  ),
              ],
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
      ..add(DiagnosticsProperty<bool>('selected', selected))
      ..add(DiagnosticsProperty<ZetaNavigationBarItem>('item', item))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}
