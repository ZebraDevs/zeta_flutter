import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../zeta_flutter.dart';

/// Global header component
/// This component should not be used as an appbar in a scaffold.
/// It can be used in custom scroll views and columns.
///
/// ```dart
/// SingleChildScrollView(
///   child: Column(children: [
///     ZetaGlobalHeader(
///       title: "Title",
///       tabItems: childrenOne,
///       searchBar: ZetaSearchBar(shape: ZetaWidgetBorder.full, size: ZetaWidgetSize.large),
///       onAppsButton: () {},
///       actionButtons: [
///         IconButton(
///           onPressed: () {},
///           icon: const ZetaIcon(
///             ZetaIcons.alert,
///           ),
///         ),
///         IconButton(
///           onPressed: () {},
///           icon: const ZetaIcon(
///             ZetaIcons.help,
///           ),
///         ),
///       ],
///       avatar: const ZetaAvatar(initials: 'PS'),
///     ),
///   ]),
/// ),
/// ```
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1120-26358&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/global-header
class ZetaGlobalHeader extends ZetaStatefulWidget {
  /// Constructor for [ZetaGlobalHeader]
  const ZetaGlobalHeader({
    super.key,
    super.rounded,
    required this.title,
    this.tabItems = const [],
    this.actionButtons = const [],
    this.avatar,
    this.searchBar,
    this.onAppsButton,
  });

  /// Header title in top left of header
  final String title;

  /// Tab item buttons
  final List<ZetaGlobalHeaderItem> tabItems;

  /// Action buttons.
  final List<IconButton> actionButtons;

  /// Avatar component.
  final ZetaAvatar? avatar;

  /// Search bar component.
  final ZetaSearchBar? searchBar;

  /// Call back for apps icon button shown before avatar on bar.
  ///
  /// If null, apps button and preceding divider are not rendered.
  final VoidCallback? onAppsButton;

  @override
  State<ZetaGlobalHeader> createState() => _GlobalHeaderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAppsButton', onAppsButton));
  }
}

class _GlobalHeaderState extends State<ZetaGlobalHeader> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final deviceType = constraints.deviceType;

          return Container(
            padding: EdgeInsets.symmetric(
              vertical: Zeta.of(context).spacing.medium,
              horizontal: Zeta.of(context).spacing.large,
            ),
            decoration: BoxDecoration(color: colors.surfaceDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Zeta.of(context).spacing.xl_8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Top Section
                    children: [
                      Row(
                        children: [
                          Text(widget.title, style: ZetaTextStyles.h4),
                          SizedBox.square(dimension: Zeta.of(context).spacing.medium),
                          if (deviceType.isLarge)
                            // If using large screen, render some tabItems in to section
                            ...renderedChildren(widget.tabItems)
                                .sublist(0, widget.tabItems.length > 4 ? 4 : widget.tabItems.length),
                        ],
                      ),
                      // If screen is not small, render search bar on the top
                      if (!deviceType.isSmall && widget.searchBar != null) Expanded(child: widget.searchBar!),
                      Row(
                        children: [
                          ...widget.actionButtons.map(
                            (e) => IconButton(
                              onPressed: e.onPressed,
                              icon: e.icon,
                              iconSize: Zeta.of(context).spacing.xl_2,
                            ),
                          ),
                          if (widget.onAppsButton != null) ...[
                            Container(
                              color: colors.borderDefault,
                              width: 1,
                              height: Zeta.of(context).spacing.xl_2,
                              margin: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.minimum),
                            ),
                            IconButton(icon: const ZetaIcon(ZetaIcons.apps), onPressed: widget.onAppsButton),
                          ],
                          SizedBox(width: Zeta.of(context).spacing.small),
                          if (widget.avatar != null) widget.avatar!.copyWith(size: ZetaAvatarSize.m),
                        ],
                      ),
                    ].gap(Zeta.of(context).spacing.medium),
                  ),
                ),
                SizedBox(height: Zeta.of(context).spacing.small),
                Row(
                  children: [
                    if (deviceType.isSmall && widget.searchBar != null) Expanded(child: widget.searchBar!),
                    if (widget.tabItems.isNotEmpty && !deviceType.isSmall)
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            /// Large screen filters some tab items to render on top
                            children: deviceType.isLarge && widget.tabItems.length >= 5
                                ? renderedChildren(widget.tabItems).sublist(5, widget.tabItems.length)
                                : renderedChildren(widget.tabItems),
                          ),
                        ),
                      ),
                  ].gap(Zeta.of(context).spacing.medium),
                ),
                if (widget.tabItems.isNotEmpty && deviceType.isSmall)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // Large screen filters some tab items to render on top
                      children: deviceType.isLarge && widget.tabItems.length > 5
                          ? renderedChildren(widget.tabItems).sublist(5, widget.tabItems.length - 1)
                          : renderedChildren(widget.tabItems),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Extend tab items to register their active states
  List<ZetaGlobalHeaderItem> renderedChildren(List<ZetaGlobalHeaderItem> children) {
    final List<ZetaGlobalHeaderItem> modifiedChildren = [];
    for (final (index, child) in children.indexed) {
      modifiedChildren.add(
        child.copyWith(
          active: _selectedIndex == index,
          dropdown: child.dropdown,
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
            child.onTap?.call();
          },
        ),
      );
    }
    return modifiedChildren;
  }
}
