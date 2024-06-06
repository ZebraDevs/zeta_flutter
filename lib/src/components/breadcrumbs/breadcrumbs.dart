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
  final List<ZetaBreadCrumb> children;

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
      ..add(IterableProperty<ZetaBreadCrumb>('children', children))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded))
      ..add(DiagnosticsProperty<IconData?>('activeIcon', activeIcon));
  }
}

class _ZetaBreadCrumbsState extends State<ZetaBreadCrumbs> {
  late int _selectedIndex;
  late List<ZetaBreadCrumb> _children;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.children.length - 1;
    _children = [...widget.children];
  }

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
              Row(
                children: [
                  const SizedBox(
                    width: ZetaSpacing.small,
                  ),
                  Icon(
                    widget.rounded ? ZetaIcons.chevron_right_round : ZetaIcons.chevron_right_sharp,
                    size: ZetaSpacing.xL,
                  ),
                  const SizedBox(
                    width: ZetaSpacing.small,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  ///Creates breadcumb widget
  ZetaBreadCrumb createBreadCrumb(ZetaBreadCrumb input, int index) {
    return ZetaBreadCrumb(
      label: input.label,
      isSelected: _selectedIndex == index,
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        input.onPressed.call();
      },
      activeIcon: widget.activeIcon,
    );
  }

  List<Widget> renderedChildren(List<ZetaBreadCrumb> children) {
    final List<Widget> returnList = [];
    if (children.length > 3) {
      returnList.add(createBreadCrumb(children.first, 0));

      final List<Widget> truncatedChildren = [];

      for (final (index, element) in children.sublist(1, children.length - 1).indexed) {
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

/// Class for untruncated [ZetaBreadCrumb].
class ZetaBreadCrumb extends StatefulWidget {
  ///Constructor for [ZetaBreadCrumb]
  const ZetaBreadCrumb({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
    required this.onPressed,
    this.activeIcon,
  });

  /// [ZetaBreadCrumb] label.
  final String label;

  /// Selected icon.
  final IconData? icon;

  /// Is [ZetaBreadCrumb] selected.
  final bool isSelected;

  /// Handles press for [ZetaBreadCrumb]
  final VoidCallback onPressed;

  /// Active icon for [ZetaBreadCrumb]
  final IconData? activeIcon;

  @override
  State<ZetaBreadCrumb> createState() => _ZetaBreadCrumbState();

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

class _ZetaBreadCrumbState extends State<ZetaBreadCrumb> {
  final controller = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (context.mounted && mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return InkWell(
      statesController: controller,
      onTap: widget.onPressed,
      enableFeedback: false,
      splashColor: Colors.transparent,
      overlayColor: WidgetStateProperty.resolveWith((states) {
        return Colors.transparent;
      }),
      child: Row(
        children: [
          if (widget.isSelected)
            Icon(
              widget.activeIcon ?? ZetaIcons.star_round,
              color: getColor(controller.value, colors),
            ),
          const SizedBox(
            width: ZetaSpacing.small,
          ),
          Text(
            widget.label,
            style: ZetaTextStyles.bodySmall.apply(color: getColor(controller.value, colors)),
          ),
        ],
      ),
    );
  }

  /// Get color of breadcrumb based on state.
  Color getColor(Set<WidgetState> states, ZetaColors colors) {
    if (states.contains(WidgetState.hovered)) {
      return colors.blue;
    }
    if (widget.isSelected) return colors.black;
    return colors.textSubtle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<WidgetStatesController>(
        'controller',
        controller,
      ),
    );
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
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return colors.surfaceHover;
                }
                if (states.contains(WidgetState.pressed)) {
                  return colors.primary.shade10;
                }
                if (states.contains(WidgetState.disabled)) {
                  return colors.surfaceDisabled;
                }
                return colors.warm.shade10;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.disabled)) {
                  return colors.textDisabled;
                }
                return colors.textDefault;
              }),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: (widget.rounded ? ZetaRadius.minimal : ZetaRadius.none),
                ),
              ),
              side: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.focused)) {
                  return BorderSide(
                    width: ZetaSpacingBase.x0_5,
                    color: colors.primary.shade100,
                  );
                }
                if (states.isEmpty) {
                  return BorderSide(color: colors.borderDefault, width: 0.5);
                }
                return null;
              }),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              minimumSize: WidgetStateProperty.all(Size.zero),
              elevation: const WidgetStatePropertyAll(ZetaSpacing.none),
            ),
            child: Icon(
              widget.rounded ? ZetaIcons.more_horizontal_round : ZetaIcons.more_horizontal_sharp,
              size: ZetaSpacing.large,
            ).paddingHorizontal(ZetaSpacing.small).paddingVertical(ZetaSpacing.minimum),
          );
  }

  Widget expandedBreadcrumb() {
    return Row(
      children: widget.children
          .divide(
            const Row(
              children: [
                SizedBox(
                  width: ZetaSpacing.small,
                ),
                Icon(
                  ZetaIcons.chevron_right_round,
                  size: ZetaSpacing.xL,
                ),
                SizedBox(
                  width: ZetaSpacing.small,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
