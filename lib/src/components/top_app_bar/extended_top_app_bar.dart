import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const _searchBarOffsetTop = ZetaSpacing.minimum * 1.5;
const _searchBarOffsetRight = ZetaSpacing.minimum * 22;
const _maxExtent = ZetaSpacing.minimum * 26;
const _minExtent = ZetaSpacing.xL9;
const _leftMin = ZetaSpacing.large;
const _leftMax = ZetaSpacingBase.x12_5;
const _topMin = ZetaSpacing.xL;
const _topMax = ZetaSpacing.minimum * 15;

/// Delegate for creating an extended app bar, that grows and shrinks when scrolling.
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
  final AppBarSearchController? searchController;

  /// If `ZetaTopAppBarType.extend` shrinks. Does not affect other types of app bar.
  final bool shrinks;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: ZetaSpacing.xL9, maxHeight: _maxExtent),
      child: ColoredBox(
        color: Zeta.of(context).colors.surfacePrimary,
        child: Stack(
          children: [
            Positioned(
              top: shrinks
                  ? (_topMax + (-1 * shrinkOffset)).clamp(
                      _topMin -
                          (searchController != null && searchController!.isEnabled
                              ? _searchBarOffsetTop
                              : ZetaSpacing.none),
                      _topMax,
                    )
                  : _topMax,
              left: shrinks ? ((shrinkOffset / _maxExtent) * ZetaSpacingBase.x50).clamp(_leftMin, _leftMax) : _leftMin,
              right: searchController != null && searchController!.isEnabled ? _searchBarOffsetRight : ZetaSpacing.none,
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
