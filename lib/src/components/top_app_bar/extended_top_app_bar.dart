import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Delegate for creating an extended app bar, that grows and shrinks when scrolling.
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-37&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/top-app-bar/extended
class ZetaExtendedAppBarDelegate extends SliverPersistentHeaderDelegate {
  /// Constructs a [ZetaExtendedAppBarDelegate].
  ZetaExtendedAppBarDelegate({
    required this.title,
    required this.shrinks,
    this.actions,
    this.leading,
  });

  /// Title of the app bar.
  final Widget title;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// Widget displayed first in the app bar row.
  final Widget? leading;

  /// If `ZetaTopAppBarType.extend` shrinks. Does not affect other types of app bar.
  final bool shrinks;

  static const double _maxExtent = 104;
  static const double _minExtent = 56;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final spacing = Zeta.of(context).spacing;

    final maxExtent = spacing.minimum * 26;
    final leftMin = spacing.large;
    final topMin = spacing.xl;
    final topMax = spacing.minimum * 15;

    /// If there is no leading widget, the left margin should not change
    /// If there is a leading widget, the left margin should be the same as the leading widget's width plus padding
    final leftMax = leading == null ? leftMin : _minExtent + spacing.small;

    final top = shrinks
        ? (topMax + (-1 * shrinkOffset)).clamp(
            topMin - (spacing.minimum),
            topMax - (spacing.minimum),
          )
        : topMax;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: spacing.xl_9, maxHeight: maxExtent),
      child: ColoredBox(
        color: Zeta.of(context).colors.surfaceDefault,
        child: Stack(
          children: [
            Positioned(
              top: top,
              left: shrinks ? ((shrinkOffset / maxExtent) * _maxExtent).clamp(leftMin, leftMax) : leftMin,
              right: spacing.none,
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
    );
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => shrinks ? _minExtent : _maxExtent;

  @override
  bool shouldRebuild(covariant ZetaExtendedAppBarDelegate oldDelegate) => oldDelegate != this;
}
