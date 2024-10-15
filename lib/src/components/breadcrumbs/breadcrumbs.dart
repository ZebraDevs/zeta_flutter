import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

// TODO(UX-1131): Refactor this to make BreadCrumbItem a class, not a widget.

/// The breadcrumb is a secondary navigation pattern that helps a user understand the hierarchy among levels and navigate back through them.
///
/// [children] should consist of [ZetaBreadCrumb]s.
///
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-5&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/breadcrumbs
class ZetaBreadCrumbs extends ZetaStatefulWidget {
  ///Constructor for [ZetaBreadCrumbs]
  const ZetaBreadCrumbs({
    super.key,
    super.rounded,
    required this.children,
    this.activeIcon,
    this.moreSemanticLabel,
  });

  /// Breadcrumb children
  final List<ZetaBreadCrumb> children;

  /// Active icon for breadcrumb
  final IconData? activeIcon;

  /// Label passed to wrapping [Semantics] widget.
  /// {@macro zeta-widget-semantic-label}
  final String? moreSemanticLabel;

  @override
  State<ZetaBreadCrumbs> createState() => _ZetaBreadCrumbsState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ZetaBreadCrumb>('children', children))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded))
      ..add(DiagnosticsProperty<IconData?>('activeIcon', activeIcon))
      ..add(StringProperty('moreSemanticLabel', moreSemanticLabel));
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
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != _children.length) {
      _selectedIndex = widget.children.length - 1;
      _children = [...widget.children];
    }
  }

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;
    return ZetaRoundedScope(
      rounded: rounded,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: renderedChildren(widget.children)
              .divide(
                Row(
                  children: [
                    SizedBox(width: Zeta.of(context).spacing.small),
                    ZetaIcon(ZetaIcons.chevron_right, size: Zeta.of(context).spacing.xl),
                    SizedBox(width: Zeta.of(context).spacing.small),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  ///Creates breadcrumb widget
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
        ..add(_BreadCrumbsTruncated(semanticLabel: widget.moreSemanticLabel, children: truncatedChildren))
        ..add(createBreadCrumb(children.last, children.length - 1));
    } else {
      for (final (index, element) in children.indexed) {
        returnList.add(createBreadCrumb(element, index));
      }
    }
    return returnList;
  }
}

// TODO(UX-1131): Rename to breadcrumbitem

/// Class for untruncated [ZetaBreadCrumb].
///
/// Should be a child of [ZetaBreadCrumbs].
class ZetaBreadCrumb extends StatefulWidget {
  ///Constructor for [ZetaBreadCrumb]
  const ZetaBreadCrumb({
    super.key,
    required this.label,
    this.icon,
    this.isSelected = false,
    required this.onPressed,
    this.activeIcon,
    this.semanticLabel,
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

  /// Label passed to wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

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
      ..add(DiagnosticsProperty<IconData?>('activeIcon', activeIcon))
      ..add(StringProperty('semanticLabel', semanticLabel));
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

    final foregroundColor = getColor(controller.value, colors);
    return Semantics(
      label: widget.semanticLabel ?? widget.label,
      selected: widget.isSelected,
      child: InkWell(
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
                color: foregroundColor,
              ),
            SizedBox(width: Zeta.of(context).spacing.small),
            Text(
              widget.label,
              style: ZetaTextStyles.bodySmall.apply(color: foregroundColor),
            ),
          ],
        ),
      ),
    );
  }

  /// Get color of breadcrumb based on state.
  Color getColor(Set<WidgetState> states, ZetaSemanticColors colors) {
    if (states.contains(WidgetState.hovered)) {
      return colors.mainPrimary;
    }
    if (widget.isSelected) return colors.mainDefault;
    return colors.mainSubtle;
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

/// Class for [_BreadCrumbsTruncated]
@Deprecated('This functionality is not needed anymore. Use [ZetaBreadCrumb] instead. ' 'Deprecated since 0.14.1')
typedef BreadCrumbsTruncated = _BreadCrumbsTruncated;

class _BreadCrumbsTruncated extends StatefulWidget {
  ///Constructor for [_BreadCrumbsTruncated]
  const _BreadCrumbsTruncated({
    required this.children,
    this.semanticLabel,
  });

  ///Breadcrumb children
  final List<Widget> children;

  /// Label passed to wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  @override
  State<_BreadCrumbsTruncated> createState() => _BreadCrumbsTruncatedState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _BreadCrumbsTruncatedState extends State<_BreadCrumbsTruncated> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final rounded = context.rounded;

    return _expanded
        ? expandedBreadcrumb()
        : Semantics(
            label: widget.semanticLabel,
            button: true,
            child: FilledButton(
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
                    return colors.surfaceSelected;
                  }
                  if (states.contains(WidgetState.disabled)) {
                    return colors.surfaceDisabled;
                  }
                  return colors.surfaceWarm;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.disabled)) {
                    return colors.mainDisabled;
                  }
                  return colors.mainDefault;
                }),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: (rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
                  ),
                ),
                side: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.focused)) {
                    return BorderSide(
                      width: ZetaBorders.medium,
                      color: colors.borderPrimary,
                    );
                  }
                  if (states.contains(WidgetState.hovered)) {
                    return BorderSide(color: colors.borderHover, width: ZetaBorders.small);
                  }
                  if (states.contains(WidgetState.pressed)) {
                    return BorderSide(color: colors.borderSelected, width: ZetaBorders.small);
                  }

                  return BorderSide(color: colors.borderDefault, width: ZetaBorders.small);
                }),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                minimumSize: WidgetStateProperty.all(Size.zero),
                elevation: WidgetStatePropertyAll(Zeta.of(context).spacing.none),
              ),
              child: Icon(
                rounded ? ZetaIcons.more_horizontal_round : ZetaIcons.more_horizontal_sharp,
                size: Zeta.of(context).spacing.large,
              ).paddingHorizontal(Zeta.of(context).spacing.small).paddingVertical(Zeta.of(context).spacing.minimum),
            ),
          );
  }

  Widget expandedBreadcrumb() {
    return Row(
      children: widget.children
          .divide(
            Row(
              children: [
                SizedBox(width: Zeta.of(context).spacing.small),
                ZetaIcon(ZetaIcons.chevron_right, size: Zeta.of(context).spacing.xl),
                SizedBox(width: Zeta.of(context).spacing.small),
              ],
            ),
          )
          .toList(),
    );
  }
}
