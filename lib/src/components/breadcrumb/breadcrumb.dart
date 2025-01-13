import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// The breadcrumb is a secondary navigation pattern that helps a user understand the hierarchy among levels and navigate back through them.
///
/// [children] should consist of [ZetaBreadcrumbItem]s.
///
/// {@category Components}
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-5&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/breadcrumbs
class ZetaBreadcrumb extends ZetaStatefulWidget {
  ///Constructor for [ZetaBreadcrumb]
  const ZetaBreadcrumb({
    super.key,
    super.rounded,
    required this.children,
    this.moreSemanticLabel,
    this.maxItemsShown = 2,
  });

  /// Breadcrumb children
  final List<ZetaBreadcrumbItem> children;

  /// Semantic label passed to [TruncatedItem].
  /// {@macro zeta-widget-semantic-label}
  final String? moreSemanticLabel;

  /// Maximum number of items shown in the breadcrumb that aren't truncated.
  final int maxItemsShown;

  @override
  State<ZetaBreadcrumb> createState() => _ZetaBreadcrumbsState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ZetaBreadcrumbItem>('children', children))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded))
      ..add(StringProperty('moreSemanticLabel', moreSemanticLabel))
      ..add(IntProperty('maxItemsShown', maxItemsShown));
  }
}

class _ZetaBreadcrumbsState extends State<ZetaBreadcrumb> {
  late int _selectedIndex;
  late List<ZetaBreadcrumbItem> _children;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.children.length - 1;
    _children = [...widget.children];
  }

  @override
  void didUpdateWidget(ZetaBreadcrumb oldWidget) {
    super.didUpdateWidget(oldWidget);

    _selectedIndex = widget.children.length - 1;
    _children = [...widget.children];
  }

  @override
  Widget build(BuildContext context) {
    final rounded = context.rounded;
    return ZetaRoundedScope(
      rounded: rounded,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: renderedChildren(_children)
              .divide(
                Row(
                  children: [
                    SizedBox(width: Zeta.of(context).spacing.small),
                    ZetaIcon(
                      ZetaIcons.chevron_right,
                      size: Zeta.of(context).spacing.xl,
                      rounded: rounded,
                      color: Zeta.of(context).colors.mainSubtle,
                    ),
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
  ZetaBreadcrumbItem createBreadCrumb(ZetaBreadcrumbItem input, int index) {
    return ZetaBreadcrumbItem(
      label: input.label,
      isSelected: _selectedIndex == index,
      icon: input.icon,
      onPressed: () {
        setState(() {
          _selectedIndex = index;
          _children = _children.sublist(0, index + 1);
        });
        input.onPressed.call();
      },
    );
  }

  List<Widget> renderedChildren(List<ZetaBreadcrumbItem> children) {
    final List<Widget> returnList = [];
    if (children.length > widget.maxItemsShown) {
      returnList.add(createBreadCrumb(children.first, 0));

      final List<Widget> truncatedChildren = [];

      for (final (index, element) in children.sublist(1, children.length - (widget.maxItemsShown - 1)).indexed) {
        truncatedChildren.add(createBreadCrumb(element, index + 1));
      }
      returnList
          .add(TruncatedItem(semanticLabel: widget.moreSemanticLabel ?? 'View More', children: truncatedChildren));

      for (final (index, element) in children.sublist(children.length - (widget.maxItemsShown - 1)).indexed) {
        returnList.add(createBreadCrumb(element, index + children.length - (widget.maxItemsShown) + 1));
      }
    } else {
      for (final (index, element) in children.indexed) {
        returnList.add(createBreadCrumb(element, index));
      }
    }
    return returnList;
  }
}

/// Class for untruncated [ZetaBreadcrumbItem].
///
/// Should be a child of [ZetaBreadcrumb].
///
/// {@category Components}
class ZetaBreadcrumbItem extends ZetaStatelessWidget {
  ///Constructor for [ZetaBreadcrumbItem]
  ZetaBreadcrumbItem({
    super.key,
    super.rounded,
    required this.label,
    this.icon,
    this.isSelected = false,
    required this.onPressed,
    this.semanticLabel,
  });

  /// [ZetaBreadcrumbItem] label.
  final String label;

  /// Selected icon.
  final IconData? icon;

  /// Is [ZetaBreadcrumbItem] selected.
  final bool isSelected;

  /// Handles press for [ZetaBreadcrumbItem]
  final VoidCallback onPressed;

  /// Label passed to wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

  // /// If true, the [ZetaBreadcrumbItem] icon will be rounded.
  // final bool? rounded;

  /// Controller for [InkWell] states to control hover and pressed states.
  final controller = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final rounded = context.rounded;
    return ZetaRoundedScope(
      rounded: rounded,
      child: Semantics(
        label: semanticLabel ?? label,
        selected: isSelected,
        child: InkWell(
          statesController: controller,
          onTap: onPressed,
          enableFeedback: false,
          splashColor: Colors.transparent,
          overlayColor: WidgetStateProperty.resolveWith((states) {
            return Colors.transparent;
          }),
          child: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, value, child) => Row(
              children: [
                if (icon != null)
                  ZetaIcon(
                    icon,
                    rounded: rounded,
                    color: getColor(value, colors),
                  ),
                SizedBox(
                  width: Zeta.of(context).spacing.small,
                ),
                Text(
                  label,
                  style: ZetaTextStyles.bodySmall.apply(color: getColor(controller.value, colors)),
                ),
                if (child != null) child,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Get color of breadcrumb based on state.
  Color getColor(Set<WidgetState> states, ZetaColors colors) {
    if (states.contains(WidgetState.hovered)) {
      return colors.primitives.blue;
    }
    if (isSelected) return colors.primitives.pure.shade1000;
    return colors.mainSubtle;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<WidgetStatesController>(
          'controller',
          controller,
        ),
      )
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded));
  }
}

/// Class for truncated [ZetaBreadcrumbItem].
@visibleForTesting
class TruncatedItem extends StatefulWidget {
  ///Constructor for [TruncatedItem]
  const TruncatedItem({
    super.key,
    required this.children,
    required this.semanticLabel,
  });

  ///Breadcrumb children
  final List<Widget> children;

  /// Label passed to wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String semanticLabel;

  @override
  State<TruncatedItem> createState() => _TruncatedItemState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _TruncatedItemState extends State<TruncatedItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final rounded = context.rounded;

    return _expanded
        ? expandedBreadcrumb()
        : ZetaRoundedScope(
            rounded: rounded,
            child: Semantics(
              label: widget.semanticLabel,
              button: true,
              excludeSemantics: true,
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
                    if (states.isEmpty) {
                      return BorderSide(color: colors.borderDefault, width: 0.5);
                    }
                    return null;
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
                ZetaIcon(
                  ZetaIcons.chevron_right,
                  size: Zeta.of(context).spacing.xl,
                  color: Zeta.of(context).colors.mainSubtle,
                ),
                SizedBox(width: Zeta.of(context).spacing.small),
              ],
            ),
          )
          .toList(),
    );
  }
}
