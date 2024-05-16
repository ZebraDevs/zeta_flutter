import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

const _searchBarOffsetTop = ZetaSpacing.x1 * 1.5;
const _searchBarOffsetRight = ZetaSpacing.x1 * 22;
const _maxExtent = ZetaSpacing.x1 * 26;
const _minExtent = ZetaSpacing.x16;
const _leftMin = ZetaSpacing.x4;
const _leftMax = ZetaSpacing.x14;
const _topMin = ZetaSpacing.x5;
const _topMax = ZetaSpacing.x1 * 15;

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
      constraints: const BoxConstraints(minHeight: ZetaSpacing.x16, maxHeight: _maxExtent),
      child: ColoredBox(
        color: Zeta.of(context).colors.surfacePrimary,
        child: Stack(
          children: [
            Positioned(
              top: shrinks
                  ? (_topMax + (-1 * shrinkOffset)).clamp(
                      _topMin - (searchController != null && searchController!.isEnabled ? _searchBarOffsetTop : 0),
                      _topMax,
                    )
                  : _topMax,
              left: shrinks ? ((shrinkOffset / _maxExtent) * ZetaSpacing.x50).clamp(_leftMin, _leftMax) : _leftMin,
              right: searchController != null && searchController!.isEnabled ? _searchBarOffsetRight : 0,
              child: title,
            ),
            if (leading != null) Positioned(top: ZetaSpacing.x3, left: ZetaSpacing.x2, child: leading!),
            if (actions != null) Positioned(top: ZetaSpacing.x3, right: ZetaSpacing.x2, child: Row(children: actions!)),
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
