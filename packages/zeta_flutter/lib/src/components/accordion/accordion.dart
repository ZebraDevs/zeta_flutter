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
    required this.children,
    this.inCard = false,
    this.multipleOpen = false,
    this.selectMultiple = false,
  });

  /// Items to be displayed in the accordion.
  final List<ZetaAccordionItem>? children;

  /// Determines if the [ZetaAccordion]s should be in a card container.
  ///
  /// Defaults to `false`.
  final bool inCard;

  /// Determines if multiple items can be open at the same time.
  /// When `false`, only one accordion item can be open at a time.
  final bool multipleOpen;

  /// Determines if multiple accordion items can be selected.
  final bool selectMultiple;

  @override
  State<ZetaAccordion> createState() => _ZetaAccordionState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('inCard', inCard))
      ..add(DiagnosticsProperty<bool>('multipleOpen', multipleOpen))
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
      if (!widget.multipleOpen) {
        final index = children.indexWhere((item) => item.isOpen);
        _openIndex = index >= 0 ? index : null;
      }
      if (!widget.selectMultiple) {
        final index = children.indexWhere((item) => item.isSelected);
        _selectedIndex = index >= 0 ? index : null;
      }
    }
  }

  void _handleItemExpansion(int index, bool isExpanded) {
    if (!widget.multipleOpen) {
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

            return _ZetaAccordionItemWrapper(
              key: entry.value.key ?? ValueKey(index),
              item: entry.value,
              isExpanded: widget.multipleOpen ? null : (_openIndex == index),
              isSelected: widget.selectMultiple ? null : (_selectedIndex == index),
              onExpansionChanged: widget.multipleOpen ? null : () => _handleItemExpansion(index, _openIndex != index),
              onSelectionChanged:
                  widget.selectMultiple ? null : () => _handleItemSelection(index, _selectedIndex != index),
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

/// Simple wrapper that controls accordion item state
class _ZetaAccordionItemWrapper extends StatelessWidget {
  const _ZetaAccordionItemWrapper({
    required this.item,
    required this.isExpanded,
    required this.isSelected,
    required this.onExpansionChanged,
    required this.onSelectionChanged,
    super.key,
  });

  final ZetaAccordionItem item;
  final bool? isExpanded;
  final bool? isSelected;
  final VoidCallback? onExpansionChanged;
  final VoidCallback? onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    // When both expansion and selection are self-managed, let the item handle its own state completely
    if (this.isExpanded == null && this.isSelected == null) {
      return item;
    }

    // Use parent-controlled state if available, otherwise use item's initial state
    final isExpanded = this.isExpanded ?? item.isOpen;
    final isSelected = this.isSelected ?? item.isSelected;

    void handleTap() {
      item.onTap?.call();
      if (item.isSelectable) {
        onSelectionChanged?.call();
      } else if (!item.isNavigation) {
        onExpansionChanged?.call();
      }
    }

    void handleLeftTap() {
      item.onTap?.call();
      onExpansionChanged?.call();
    }

    void handleRightTap() {
      item.onTap?.call();
      onSelectionChanged?.call();
    }

    final wholeTileTap = !item.isSelectable || (item.isSelectable && item.child == null) ? handleTap : null;
    final leftTap = item.isSelectable && item.child != null ? handleLeftTap : null;
    final rightTap = item.isSelectable && item.child != null ? handleRightTap : null;

    return AccordionItemUI(
      item: item,
      isExpanded: isExpanded,
      isSelected: isSelected,
      wholeTileTap: wholeTileTap,
      leftTap: leftTap,
      rightTap: rightTap,
      expandSemanticLabel: item.expandSemanticLabel,
      collapseSemanticLabel: item.collapseSemanticLabel,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('isExpanded', isExpanded))
      ..add(DiagnosticsProperty<bool?>('isSelected', isSelected))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onExpansionChanged', onExpansionChanged))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onSelectionChanged', onSelectionChanged));
  }
}
