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
  static const double _minExtent = 52;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    const searchBarOffsetTop = ZetaSpacing.minimum * 1.5;
    const searchBarOffsetRight = ZetaSpacing.minimum * 22;
    const maxExtent = ZetaSpacing.minimum * 26;
    const leftMin = ZetaSpacing.large;

    const topMin = ZetaSpacing.xl_1;
    const topMax = ZetaSpacing.minimum * 15;

    /// If there is no leading widget, the left margin should not change
    /// If there is a leading widget, the left margin should be the same as the leading widget's width plus padding
    final leftMax = leading == null ? leftMin : _minExtent + ZetaSpacing.small;

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: ZetaSpacing.xl_9, maxHeight: maxExtent),
      child: ColoredBox(
        color: Zeta.of(context).colors.surfacePrimary,
        child: Stack(
          children: [
            Positioned(
              top: shrinks
                  ? (topMax + (-1 * shrinkOffset)).clamp(
                      topMin -
                          (searchController != null && searchController!.isEnabled
                              ? searchBarOffsetTop
                              : ZetaSpacing.none),
                      topMax,
                    )
                  : topMax,
              left: shrinks ? ((shrinkOffset / maxExtent) * ZetaSpacingBase.x50).clamp(leftMin, leftMax) : leftMin,
              right: searchController != null && searchController!.isEnabled ? searchBarOffsetRight : ZetaSpacing.none,
              child: title,
            ),
            if (leading != null) Positioned(top: ZetaSpacing.medium, left: ZetaSpacing.small, child: leading!),
            if (actions != null)
              Positioned(top: ZetaSpacing.medium, right: ZetaSpacing.small, child: Row(children: actions!)),
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
