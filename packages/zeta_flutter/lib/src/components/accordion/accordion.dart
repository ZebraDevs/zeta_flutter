import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'accordion_item_ui.dart';

/// The accordion is a control element comprising a vertically stacked list of items,
/// such as labels or thumbnails. Each item can be "expanded" or "collapsed" to reveal
/// the content associated with that item. There can be zero expanded items, exactly one,
/// or more than one item expanded at a time, depending on the configuration.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=38101-167213&t=t5Mv5RDsz4p7Jcta-4
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/accordion/zetaaccordion/accordion
class ZetaAccordion extends ZetaStatefulWidget {
  /// The constructor of the component [ZetaAccordion].
  const ZetaAccordion({
    super.key,
    super.rounded,
    this.children,
    this.inCard = false,
    this.expandMultiple = false,
    this.selectMultiple = false,
  });

  /// Items to be displayed in the accordion.
  final List<ZetaAccordionItem>? children;

  /// Determines if the [ZetaAccordion] should be in a card container.
  ///
  /// Defaults to `false`.
  final bool inCard;

  /// Determines if multiple items can be open at the same time.
  /// When `false`, only one accordion item can be open at a time.
  final bool expandMultiple;

  /// Determines if multiple accordion items can be selected.
  final bool selectMultiple;

  @override
  State<ZetaAccordion> createState() => _ZetaAccordionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('inCard', inCard))
      ..add(DiagnosticsProperty<bool>('openMultiple', expandMultiple))
      ..add(DiagnosticsProperty<bool>('selectMultiple', selectMultiple));
  }
}

class _ZetaAccordionState extends State<ZetaAccordion> {
  int? _openIndex;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    final children = widget.children;
    if (children != null) {
      if (!widget.expandMultiple) {
        final index = children.indexWhere((item) => item.isExpanded);
        _openIndex = index >= 0 ? index : null;
      }
      if (!widget.selectMultiple) {
        final index = children.indexWhere((item) => item.isSelected);
        _selectedIndex = index >= 0 ? index : null;
      }
    }
  }

  void _handleItemExpansion(int index, bool isExpanded) {
    if (!widget.expandMultiple) {
      setState(() => _openIndex = isExpanded ? index : null);
    }
  }

  void _handleItemSelection(int index, bool isSelected) {
    if (!widget.selectMultiple) {
      setState(() => _selectedIndex = isSelected ? index : null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.children;
    if (children == null || children.isEmpty) {
      return const Nothing();
    }

    final zeta = Zeta.of(context);
    final rounded = widget.rounded ?? zeta.rounded;

    final columnWidget = Column(
      children: children
          .asMap()
          .entries
          .map((entry) {
            final index = entry.key;
            final item = entry.value;

            // Determine if parent controls state or if item manages its own state
            final parentControlsExpansion = !widget.expandMultiple;
            final parentControlsSelection = !widget.selectMultiple;

            final isExpanded = parentControlsExpansion ? (_openIndex == index) : null;
            final isSelected = parentControlsSelection ? (_selectedIndex == index) : null;

            // When both are self-managed, let the item handle its own state completely
            if (!parentControlsExpansion && !parentControlsSelection) {
              return item;
            }

            // Create a simplified wrapper for parent-controlled scenarios
            return _AccordionItemController(
              key: item.key ?? ValueKey(index),
              item: item,
              parentIsExpanded: isExpanded,
              parentIsSelected: isSelected,
              onExpansionChanged:
                  parentControlsExpansion ? () => _handleItemExpansion(index, _openIndex != index) : null,
              onSelectionChanged:
                  parentControlsSelection ? () => _handleItemSelection(index, _selectedIndex != index) : null,
            );
          })
          .divide(Divider(height: 0, color: widget.inCard ? zeta.colors.borderSubtle : Colors.transparent))
          .toList(),
    );

    if (widget.inCard) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: zeta.colors.surfaceDefault,
          borderRadius: BorderRadius.all(rounded ? zeta.radius.rounded : zeta.radius.none),
          border: Border.all(color: zeta.colors.borderSubtle, width: ZetaBorders.small),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(rounded ? zeta.radius.rounded : zeta.radius.none),
          child: columnWidget,
        ),
      );
    }
    return columnWidget;
  }
}

class _AccordionItemController extends StatefulWidget {
  const _AccordionItemController({
    required this.item,
    required this.parentIsExpanded,
    required this.parentIsSelected,
    required this.onExpansionChanged,
    required this.onSelectionChanged,
    super.key,
  });

  final ZetaAccordionItem item;
  final bool? parentIsExpanded;
  final bool? parentIsSelected;
  final VoidCallback? onExpansionChanged;
  final VoidCallback? onSelectionChanged;

  @override
  State<_AccordionItemController> createState() => _AccordionItemControllerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('parentIsExpanded', parentIsExpanded))
      ..add(DiagnosticsProperty<bool?>('parentIsSelected', parentIsSelected))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onExpansionChanged', onExpansionChanged))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSelectionChanged', onSelectionChanged));
  }
}

class _AccordionItemControllerState extends State<_AccordionItemController> {
  late bool _selfManagedExpanded;
  late bool _selfManagedSelected;

  @override
  void initState() {
    super.initState();
    _selfManagedExpanded = widget.item.isExpanded;
    _selfManagedSelected = widget.item.isSelected;
  }

  @override
  void didUpdateWidget(_AccordionItemController oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update self-managed state if the item's initial state changes
    if (widget.item.isExpanded != oldWidget.item.isExpanded) {
      _selfManagedExpanded = widget.item.isExpanded;
    }
    if (widget.item.isSelected != oldWidget.item.isSelected) {
      _selfManagedSelected = widget.item.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use parent state if controlled, otherwise use self-managed state
    final isExpanded = widget.parentIsExpanded ?? _selfManagedExpanded;
    final isSelected = widget.parentIsSelected ?? _selfManagedSelected;

    void handleExpansion() {
      if (widget.parentIsExpanded != null) {
        // Parent controls expansion
        widget.onExpansionChanged?.call();
      } else {
        // Self-managed expansion
        setState(() => _selfManagedExpanded = !_selfManagedExpanded);
      }
    }

    void handleSelection() {
      if (widget.parentIsSelected != null) {
        // Parent controls selection
        widget.onSelectionChanged?.call();
      } else {
        // Self-managed selection
        setState(() => _selfManagedSelected = !_selfManagedSelected);
      }
    }

    void handleTap() {
      widget.item.onTap?.call();
      if (widget.item.isSelectable) {
        handleSelection();
      } else if (!widget.item.isNavigation) {
        handleExpansion();
      }
    }

    void handleLeftTap() {
      widget.item.onTap?.call();
      handleExpansion();
    }

    void handleRightTap() {
      widget.item.onTap?.call();
      handleSelection();
    }

    final wholeTileTap =
        !widget.item.isSelectable || (widget.item.isSelectable && widget.item.child == null) ? handleTap : null;
    final leftTap = widget.item.isSelectable && widget.item.child != null ? handleLeftTap : null;
    final rightTap = widget.item.isSelectable && widget.item.child != null ? handleRightTap : null;

    return AccordionItemUI(
      item: widget.item,
      isExpanded: isExpanded,
      isSelected: isSelected,
      wholeTileTap: wholeTileTap,
      leftTap: leftTap,
      rightTap: rightTap,
      expandSemanticLabel: widget.item.expandSemanticLabel,
      collapseSemanticLabel: widget.item.collapseSemanticLabel,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('_selfManagedExpanded', _selfManagedExpanded))
      ..add(DiagnosticsProperty<bool>('_selfManagedSelected', _selfManagedSelected))
      ..add(DiagnosticsProperty<bool?>('parentIsExpanded', widget.parentIsExpanded))
      ..add(DiagnosticsProperty<bool?>('parentIsSelected', widget.parentIsSelected));
  }
}
