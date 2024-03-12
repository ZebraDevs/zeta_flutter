import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Class for [ZetaBreadCrumbs]
class ZetaBreadCrumbs extends StatefulWidget {
  ///Constructor for [ZetaBreadCrumbs]
  const ZetaBreadCrumbs({
    super.key,
    required this.children,
    this.rounded = true,
    this.activeIcon,
  });

  /// Breadcrumb children
  final List<String> children;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Active icon for breadcrumb
  final IconData? activeIcon;

  @override
  State<ZetaBreadCrumbs> createState() => _ZetaBreadCrumbsState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<String>('children', children))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded))
      ..add(DiagnosticsProperty<IconData?>('activeIcon', activeIcon));
  }
}

class _ZetaBreadCrumbsState extends State<ZetaBreadCrumbs> {
  late int _selectedIndex;
  late List<String> _children;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.children.length - 1;
    _children = [...widget.children];
  }

  // TODO: Optimize so we don't call set state each time. OldWidget stays the same as current widget
  @override
  void didUpdateWidget(ZetaBreadCrumbs oldWidget) {
    if (widget.children.length != _children.length) {
      setState(() {
        _selectedIndex = widget.children.length - 1;
        _children = [...widget.children];
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: renderedChildren(widget.children)
            .divide(
              const Row(
                children: [
                  SizedBox(
                    width: ZetaSpacing.xs,
                  ),
                  Icon(
                    ZetaIcons.chevron_right_round,
                    size: ZetaSpacing.x5,
                  ),
                  SizedBox(
                    width: ZetaSpacing.xs,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  ///Creates breadcumb widget
  BreadCrumb createBreadCrumb(String label, int index) {
    return BreadCrumb(
      label: label,
      isSelected: _selectedIndex == index,
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      activeIcon: widget.activeIcon,
    );
  }

  List<Widget> renderedChildren(List<String> children) {
    final List<Widget> returnList = [];
    if (children.length > 3) {
      returnList.add(createBreadCrumb(children.first, 0));

      final List<Widget> truncatedChildren = [];

      for (final (index, element)
          in children.sublist(1, children.length - 1).indexed) {
        truncatedChildren.add(createBreadCrumb(element, index + 1));
      }
      returnList
        ..add(
          BreadCrumbsTruncated(
            rounded: widget.rounded,
            children: truncatedChildren,
          ),
        )
        ..add(createBreadCrumb(children.last, children.length - 1));
    } else {
      for (final (index, element) in children.indexed) {
        returnList.add(createBreadCrumb(element, index));
      }
    }
    return returnList;
  }
}

/// Class for untruncated [BreadCrumb].
class BreadCrumb extends StatelessWidget {
  ///Constructor for [BreadCrumb]
  const BreadCrumb({
    super.key,
    required this.label,
    this.icon,
    required this.isSelected,
    required this.onPressed,
    this.activeIcon,
  });

  /// [BreadCrumb] label.
  final String label;

  /// Selected icon.
  final IconData? icon;

  /// Is [BreadCrumb] selected.
  final bool isSelected;

  /// Handles press for [BreadCrumb]
  final VoidCallback onPressed;

  /// Active icon for [BreadCrumb]
  final IconData? activeIcon;

  @override
  Widget build(BuildContext context) {
    final controller = MaterialStatesController();
    final colors = Zeta.of(context).colors;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        statesController: controller,
        onTap: onPressed,
        enableFeedback: false,
        splashColor: Colors.transparent,
        overlayColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
        child: Row(
          children: [
            if (isSelected)
              Icon(
                activeIcon ?? ZetaIcons.star_round,
                color: getColor(controller.value, colors),
              ),
            const SizedBox(
              width: ZetaSpacing.xs,
            ),
            Text(
              label,
              style: TextStyle(color: getColor(controller.value, colors)),
            ),
          ],
        ),
      ),
    );
  }

  /// Get color of breadcrumb based on state.
  Color getColor(Set<MaterialState> states, ZetaColors colors) {
    if (states.contains(MaterialState.hovered)) {
      return colors.blue.shade100;
    }
    if (isSelected) return colors.black;
    return colors.textSubtle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(DiagnosticsProperty<IconData?>('activeIcon', activeIcon));
  }
}

///Class for [BreadCrumbsTruncated]
class BreadCrumbsTruncated extends StatefulWidget {
  ///Constructor for [BreadCrumbsTruncated]
  const BreadCrumbsTruncated({
    super.key,
    required this.children,
    required this.rounded,
  });

  ///Breadcrumb children
  final List<Widget> children;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  @override
  State<BreadCrumbsTruncated> createState() => _BreadCrumbsTruncatedState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

class _BreadCrumbsTruncatedState extends State<BreadCrumbsTruncated> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return _expanded
        ? expandedBreadcrumb()
        : FilledButton(
            onPressed: () {
              setState(() {
                _expanded = true;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return colors.surfaceHovered;
                }
                if (states.contains(MaterialState.pressed)) {
                  return colors.primary.shade10;
                }
                if (states.contains(MaterialState.disabled)) {
                  return colors.surfaceDisabled;
                }
                return colors.warm.shade10;
              }),
              foregroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.disabled)) {
                  return colors.textDisabled;
                }
                return colors.textDefault;
              }),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius:
                      (widget.rounded ? ZetaRadius.minimal : ZetaRadius.none),
                ),
              ),
              side: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.focused)) {
                  return BorderSide(
                    width: ZetaSpacing.x0_5,
                    color: colors.primary.shade100,
                  );
                }
                if (states.isEmpty) {
                  return BorderSide(color: colors.borderDefault, width: 0.5);
                }
                return null;
              }),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size.zero),
              elevation: const MaterialStatePropertyAll(0),
            ),
            child: const Icon(
              ZetaIcons.more_horizontal_round,
              size: ZetaSpacing.x4,
            )
                .paddingHorizontal(ZetaSpacing.xs)
                .paddingVertical(ZetaSpacing.xxs),
          );
  }

  Widget expandedBreadcrumb() {
    return Row(
      children: widget.children
          .divide(
            const Row(
              children: [
                SizedBox(
                  width: ZetaSpacing.xs,
                ),
                Icon(
                  ZetaIcons.chevron_right_round,
                  size: ZetaSpacing.x5,
                ),
                SizedBox(
                  width: ZetaSpacing.xs,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
