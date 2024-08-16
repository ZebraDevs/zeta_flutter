import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const double _maxExtent = 104;
const double _minExtent = 52;

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

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final searchBarOffsetTop = Zeta.of(context).spacing.minimum * 1.5;
    final searchBarOffsetRight = Zeta.of(context).spacing.minimum * 22;
    final leftMin = Zeta.of(context).spacing.large;

    /// If there is no leading widget, the left margin should not change
    /// If there is a leading widget, the left margin should be the same as the leading widget's width plus padding
    final leftMax = leading == null ? leftMin : (Zeta.of(context).spacing.large * (2)) + Zeta.of(context).spacing.xl;
    final topMin = Zeta.of(context).spacing.xl;
    final topMax = Zeta.of(context).spacing.minimum * 15;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: Zeta.of(context).spacing.xl_9, maxHeight: _maxExtent),
      child: ColoredBox(
        color: Zeta.of(context).colors.surface.defaultColor,
        child: Stack(
          children: [
            Positioned(
              top: shrinks
                  ? (topMax + (-1 * shrinkOffset)).clamp(
                      topMin -
                          (searchController != null && searchController!.isEnabled
                              ? searchBarOffsetTop
                              : Zeta.of(context).spacing.none),
                      topMax,
                    )
                  : topMax,
              left: shrinks ? ((shrinkOffset / _maxExtent) * leftMax).clamp(leftMin, leftMax) : leftMin,
              right: searchController != null && searchController!.isEnabled
                  ? searchBarOffsetRight
                  : Zeta.of(context).spacing.none,
              child: title,
            ),
            if (leading != null)
              Positioned(top: Zeta.of(context).spacing.medium, left: Zeta.of(context).spacing.small, child: leading!),
            if (actions != null)
              Positioned(
                top: Zeta.of(context).spacing.medium,
                right: Zeta.of(context).spacing.small,
                child: Row(children: actions!),
              ),
          ],
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
