import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

import 'list_scope.dart';

/// An expandable list item containing other [ZetaListItem]s within it.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-17&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/list-item/zetadropdownlistitem/dropdown-list-item
class ZetaDropdownListItem extends ZetaStatefulWidget {
  /// Creates a new [ZetaDropdownListItem]
  const ZetaDropdownListItem({
    super.key,
    super.rounded,
    required this.items,
    this.title,
    this.primaryText,
    this.secondaryText,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.expanded = false,
    this.leading,
    this.showDivider,
    this.semanticLabel,
  }) : assert(
          (title != null && primaryText == null && secondaryText == null) ||
              (title == null && (primaryText != null || secondaryText != null)),
          'Provide one of either title or primaryText/secondaryText',
        );

  /// The list of [ZetaListItem]s contained within the dropdown.
  final List<ZetaListItem> items;

  /// {@macro list-item-title}
  final Widget? title;

  /// {@macro list-item-primary-text}
  final String? primaryText;

  /// {@macro list-item-primary-text-style}
  final TextStyle? primaryTextStyle;

  /// {@macro list-item-secondary-text}
  final String? secondaryText;

  /// {@macro list-item-secondary-text-style}
  final TextStyle? secondaryTextStyle;

  /// {@macro list-item-leading}
  final Widget? leading;

  /// Expands the list item if set to true.
  ///
  /// Defaults to false.
  final bool expanded;

  /// {@macro list-item-show-divider}
  final bool? showDivider;

  /// Value passed into semantic label for the button.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  @override
  State<ZetaDropdownListItem> createState() => _ZetaDropdownListItemState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<ZetaListItem>('items', items))
      ..add(StringProperty('primaryText', primaryText))
      ..add(StringProperty('secondaryText', secondaryText))
      ..add(DiagnosticsProperty<bool>('expanded', expanded))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool?>('showDivider', showDivider))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(DiagnosticsProperty<TextStyle?>('primaryTextStyle', primaryTextStyle))
      ..add(DiagnosticsProperty<TextStyle?>('secondaryTextStyle', secondaryTextStyle));
  }
}

class _ZetaDropdownListItemState extends State<ZetaDropdownListItem> with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _animation;

  late bool _expanded;

  @override
  void initState() {
    _expanded = widget.expanded;
    _expandController = AnimationController(
      vsync: this,
      duration: ZetaAnimationLength.fast,
    );
    _animation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
    if (_expanded) {
      _expandController.value = 1;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ZetaDropdownListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.expanded != widget.expanded) {
      _setExpanded(widget.expanded);
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  void _setExpanded(bool value) {
    setState(() {
      _expanded = value;
    });
    if (_expanded) {
      _expandController.forward();
    } else {
      _expandController.reverse();
    }
  }

  void _onTap() => _setExpanded(!_expanded);

  @override
  Widget build(BuildContext context) {
    final divide = widget.showDivider ?? ListScope.of(context)?.showDivider ?? false;
    final colors = Zeta.of(context).colors;
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        button: true,
        selected: _expanded,
        label: widget.semanticLabel ?? ((widget.primaryText ?? '') + (widget.secondaryText ?? '')),
        // DecoratedBox does not correctly animated the border when the widget expands.
        // ignore: use_decorated_box
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: divide ? colors.borderDefault : Colors.transparent,
              ),
            ),
          ),
          child: Column(
            children: [
              ExcludeSemantics(
                child: ZetaListItem(
                  title: widget.title,
                  primaryText: widget.primaryText,
                  primaryTextStyle: widget.primaryTextStyle,
                  secondaryText: widget.secondaryText,
                  secondaryTextStyle: widget.secondaryTextStyle,
                  leading: widget.leading,
                  onTap: _onTap,
                  showDivider: false,
                  trailing: IconButton(
                    icon: AnimatedRotation(
                      turns: _expanded ? 0.5 : 0,
                      duration: ZetaAnimationLength.fast,
                      child: Icon(
                        context.rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp,
                        color: colors.mainSubtle,
                      ),
                    ),
                    onPressed: _onTap,
                  ),
                ),
              ),
              ListScope(
                showDivider: false,
                indentItems: true,
                child: SizeTransition(
                  sizeFactor: _animation,
                  child: Column(
                    children: widget.items,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
