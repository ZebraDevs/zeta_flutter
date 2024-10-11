import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Delegate for creating an extended app bar, that grows and shrinks when scrolling.
/// {@category Components}
class ZetaExtendedAppBarDelegate extends SliverPersistentHeaderDelegate {
  /// Constructs a [ZetaExtendedAppBarDelegate].
  ZetaExtendedAppBarDelegate({
    required this.title,
    required this.shrinks,
    this.actions,
    this.leading,
    this.searchController,
  });

  /// Title of the app bar.
  final Widget title;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// Widget displayed first in the app bar row.
  final Widget? leading;

  /// Used to control the search textfield and states.
  final ZetaSearchController? searchController;

  /// If `ZetaTopAppBarType.extend` shrinks. Does not affect other types of app bar.
  final bool shrinks;

  static const double _maxExtent = 104;
  static const double _minExtent = 56;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final spacing = Zeta.of(context).spacing;
    final colors = Zeta.of(context).colors;
    final searchBarOffsetTop = spacing.minimum * 1.5;
    final searchBarOffsetRight = spacing.minimum * 22;
    final maxExtent = spacing.minimum * 26;
    final leftMin = spacing.large;
    final topMin = spacing.xl;
    final topMax = spacing.minimum * 15;

    /// If there is no leading widget, the left margin should not change
    /// If there is a leading widget, the left margin should be the same as the leading widget's width plus padding
    final leftMax = leading == null ? leftMin : _minExtent + spacing.small;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: spacing.xl_9, maxHeight: maxExtent),
      child: ColoredBox(
        color: colors.surfaceDefault,
        child: IconTheme(
          data: IconThemeData(color: colors.mainDefault),
          child: Stack(
            children: [
              Positioned(
                top: shrinks
                    ? (topMax + (-1 * shrinkOffset)).clamp(
                        topMin -
                            (searchController != null && searchController!.isEnabled
                                ? searchBarOffsetTop
                                : Zeta.of(context).spacing.minimum),
                        topMax,
                      )
                    : topMax,
                left: shrinks ? ((shrinkOffset / maxExtent) * _maxExtent).clamp(leftMin, leftMax) : leftMin,
                right: searchController != null && searchController!.isEnabled ? searchBarOffsetRight : spacing.none,
                child: title,
              ),
              if (leading != null) Positioned(top: spacing.small, left: spacing.small, child: leading!),
              if (actions != null)
                Positioned(
                  top: spacing.small,
                  right: spacing.small,
                  child: Row(children: actions!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => shrinks ? _minExtent : _maxExtent;

  @override
  bool shouldRebuild(covariant ZetaExtendedAppBarDelegate oldDelegate) => oldDelegate != this;
}
