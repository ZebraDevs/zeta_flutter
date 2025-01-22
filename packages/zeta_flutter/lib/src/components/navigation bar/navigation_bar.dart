import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const double _navigationItemBorderWidth = 1;

/// An item to be used in a [ZetaNavigationBar].
///
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
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1052-24751&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/navigation-bar
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
    this.shrinkItems = false,
    this.useSafeArea = true,
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
    this.shrinkItems = false,
    this.useSafeArea = true,
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
    this.useSafeArea = true,
  })  : splitItems = true,
        action = null,
        shrinkItems = true;

  /// Creates a [ZetaNavigationBar] with an action.
  const ZetaNavigationBar.action({
    super.key,
    super.rounded,
    required this.items,
    required this.action,
    this.currentIndex,
    this.onTap,
    this.semanticLabel,
    this.shrinkItems = false,
    this.useSafeArea = true,
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

  /// When set to true the items will shrink to take up less space.
  /// This is useful when there are many items in the navigation bar.
  /// Defaults to false.
  /// When set to false the items will take up equal space and will expand to fill the bar.
  final bool shrinkItems;

  /// Whether the child should be wrapped in a [SafeArea].
  final bool useSafeArea;

  Row _generateNavigationItemRow(List<ZetaNavigationBarItem> items, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((navItem) {
        final index = items.indexOf(navItem);
        return Expanded(
          flex: !shrinkItems ? 1 : 0,
          child: NavigationItem(
            selected: index == currentIndex,
            item: navItem,
            onTap: () => onTap?.call(index),
            context: context,
          ),
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
          Expanded(flex: !shrinkItems ? 1 : 0, child: _generateNavigationItemRow(leftItems, context)),
          if (dividerIndex != null)
            Container(
              color: colors.borderSubtle,
              width: _navigationItemBorderWidth,
              height: Zeta.of(context).spacing.xl_7,
            ),
          Expanded(flex: !shrinkItems ? 1 : 0, child: _generateNavigationItemRow(rightItems, context)),
        ],
      );
    } else if (action != null) {
      child = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: !shrinkItems ? 1 : 0, child: _generateNavigationItemRow(items, context)),
          action!,
        ],
      );
    } else {
      child = _generateNavigationItemRow(items, context);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.large),
      decoration: BoxDecoration(
        color: colors.surfaceDefault,
        border: Border(top: BorderSide(color: colors.borderSubtle)),
      ),
      child: Semantics(child: useSafeArea ? SafeArea(child: child) : child),
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
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty<bool>('shrinkItems', shrinkItems))
      ..add(DiagnosticsProperty<bool>('useSafeArea', useSafeArea));
  }
}

/// A single item in a [ZetaNavigationBar].
@visibleForTesting
@protected
class NavigationItem extends ZetaStatelessWidget {
  /// Creates a new [NavigationItem].
  const NavigationItem({
    super.key,
    required this.selected,
    required this.item,
    required this.onTap,
    required this.context,
  });

  /// Whether the item is selected.
  final bool selected;

  /// The item to display.
  final ZetaNavigationBarItem item;

  /// Called when the item is tapped.
  final VoidCallback onTap;

  /// The build context of the [ZetaNavigationBar].
  final BuildContext context;

  /// The badge to show on the navigation item.
  Widget get badge {
    final ZetaColors colors = Zeta.of(context).colors;
    return Positioned(
      top: Zeta.of(context).spacing.minimum,
      right: Zeta.of(context).spacing.minimum,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceDefault,
          borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
        ),
        child: item.badge?.copyWith(
          size: item.badge?.value == null
              ? ZetaWidgetSize.small
              : item.badge?.size == ZetaWidgetSize.large
                  ? ZetaWidgetSize.medium
                  : null,
          type: ZetaIndicatorType.notification,
          semanticLabel: item.badge?.semanticLabel,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final elementColor = selected ? colors.surfacePrimary : colors.mainSubtle;

    return Material(
      color: colors.surfaceDefault,
      child: InkResponse(
        borderRadius:
            BorderRadius.all(context.rounded ? Zeta.of(context).radius.rounded : Zeta.of(context).radius.none),
        onTap: onTap,
        hoverColor: colors.surfaceHover,
        highlightShape: BoxShape.rectangle,
        child: Semantics(
          button: true,
          label: item.label,
          child: Container(
            padding: EdgeInsets.only(
              left: Zeta.of(context).spacing.small,
              right: Zeta.of(context).spacing.small,
              bottom: Zeta.of(context).spacing.small,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Zeta.of(context).spacing.xl_7,
                  height: Zeta.of(context).spacing.xl_4 - _navigationItemBorderWidth,
                  child: Stack(
                    children: [
                      Center(
                        child: ZetaIcon(item.icon, color: elementColor, size: Zeta.of(context).spacing.xl_2),
                      ).paddingTop(Zeta.of(context).spacing.small),
                      if (item.badge != null) badge,
                    ],
                  ),
                ),
                SizedBox(height: Zeta.of(context).spacing.small),
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
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DiagnosticsProperty<BuildContext>('context', context));
  }
}
