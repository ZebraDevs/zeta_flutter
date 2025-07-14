import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'accordion_item_ui.dart';

/// A single item within a [ZetaAccordion].
class ZetaAccordionItem extends ZetaStatefulWidget {
  /// Constructs a [ZetaAccordionItem].
  const ZetaAccordionItem({
    required this.title,
    this.child,
    this.isOpen = false,
    this.isSelected = false,
    this.isSelectable = false,
    this.isNavigation = false,
    this.header,
    this.onTap,
    super.key,
    super.rounded,
    this.expandSemanticLabel = 'Expand accordion',
    this.collapseSemanticLabel = 'Collapse accordion',
  })  : assert(
          !(isSelectable && isNavigation),
          'Selectable items cannot be navigation items. Please use either selectable or navigation.',
        ),
        assert((isNavigation && child == null) || !isNavigation, 'Navigation items must not have a child widget');

  /// Constructs a selectable [ZetaAccordionItem].
  const ZetaAccordionItem.selectable({
    required this.title,
    this.child,
    this.isOpen = false,
    this.isSelected = false,
    this.onTap,
    this.header,
    super.key,
    super.rounded,
    this.expandSemanticLabel = 'Expand accordion',
    this.collapseSemanticLabel = 'Collapse accordion',
  })  : isNavigation = false,
        isSelectable = true;

  /// Constructs a navigation [ZetaAccordionItem].
  const ZetaAccordionItem.navigation({
    required this.title,
    this.child,
    this.onTap,
    this.header,
    super.key,
    super.rounded,
  })  : isNavigation = true,
        isSelected = false,
        isOpen = false,
        expandSemanticLabel = '',
        collapseSemanticLabel = '',
        isSelectable = false;

  /// Title of the accordion item.
  final String title;

  /// Content displayed when the accordion item is expanded.
  final Widget? child;

  /// Whether the accordion item is initially open.
  final bool isOpen;

  /// Callback triggered when the accordion item is tapped.
  final VoidCallback? onTap;

  /// Whether the accordion item is initially selected.
  final bool isSelected;

  /// Whether the accordion item is selectable.
  final bool isSelectable;

  /// Whether the accordion item is a navigation item.
  final bool isNavigation;

  /// Header content for the accordion item.
  final Widget? header;

  /// Semantic label for the expansion action.
  ///
  /// Defaults to 'Expand accordion'.
  final String expandSemanticLabel;

  /// Semantic label for the collapse action.
  ///
  /// Defaults to 'Collapse accordion'.
  final String collapseSemanticLabel;

  @override
  State<ZetaAccordionItem> createState() => _ZetaAccordionItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('isOpen', isOpen))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(DiagnosticsProperty<bool>('isSelectable', isSelectable))
      ..add(DiagnosticsProperty<bool>('isNavigation', isNavigation))
      ..add(StringProperty('expandSemanticLabel', expandSemanticLabel))
      ..add(StringProperty('collapseSemanticLabel', collapseSemanticLabel));
  }
}

class _ZetaAccordionItemState extends State<ZetaAccordionItem> {
  late bool _isExpanded;
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isOpen;
    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(ZetaAccordionItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      _isExpanded = widget.isOpen;
    }
    if (widget.isSelected != oldWidget.isSelected) {
      _isSelected = widget.isSelected;
    }
  }

  @override
  Widget build(BuildContext context) {
    void toggleExpansion() {
      widget.onTap?.call();
      setState(() => _isExpanded = !_isExpanded);
    }

    void toggleSelection() {
      widget.onTap?.call();
      setState(() => _isSelected = !_isSelected);
    }

    void handleNavigation() {
      widget.onTap?.call();
    }

    // Determine tap handlers based on item configuration
    final VoidCallback? wholeTileTap;
    final VoidCallback? leftTap;
    final VoidCallback? rightTap;

    if (widget.isSelectable && widget.child != null) {
      // Split behavior: left for expansion, right for selection
      wholeTileTap = null;
      leftTap = toggleExpansion;
      rightTap = toggleSelection;
    } else if (widget.isSelectable) {
      // Selectable without child: whole tile toggles selection
      wholeTileTap = toggleSelection;
      leftTap = null;
      rightTap = null;
    } else if (widget.isNavigation) {
      // Navigation: whole tile triggers navigation
      wholeTileTap = handleNavigation;
      leftTap = null;
      rightTap = null;
    } else {
      // Default expandable: whole tile toggles expansion
      wholeTileTap = toggleExpansion;
      leftTap = null;
      rightTap = null;
    }

    return AccordionItemUI(
      item: widget,
      key: widget.key,
      isExpanded: _isExpanded,
      isSelected: _isSelected,
      wholeTileTap: wholeTileTap,
      leftTap: leftTap,
      rightTap: rightTap,
      expandSemanticLabel: widget.expandSemanticLabel,
      collapseSemanticLabel: widget.collapseSemanticLabel,
    );
  }
}
