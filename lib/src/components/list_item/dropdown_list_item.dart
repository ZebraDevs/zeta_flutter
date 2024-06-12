import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../assets/icons.dart';
import '../../theme/tokens.dart';
import '../../zeta.dart';
import 'list_item.dart';
import 'list_scope.dart';

/// An expandable list item containing other [ZetaListItem]s within it.
class ZetaDropdownListItem extends StatefulWidget {
  /// Creates a new [ZetaDropdownListItem]
  const ZetaDropdownListItem({
    required this.primaryText,
    required this.items,
    this.secondaryText,
    this.expanded = false,
    this.leading,
    this.rounded = true,
    this.showDivider,
    super.key,
  });

  /// The list of [ZetaListItem]s contained within the dropdown.
  final List<ZetaListItem> items;

  /// {@macro list-item-primary-text}
  final String primaryText;

  /// {@macro list-item-secondary-text}
  final String? secondaryText;

  /// {@macro list-item-leading}
  final Widget? leading;

  /// Expands the list item if set to true.
  /// Defaults to false.
  final bool expanded;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// {@macro list-item-show-divider}
  final bool? showDivider;

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
      ..add(DiagnosticsProperty<bool?>('showDivider', showDivider));
  }
}

class _ZetaDropdownListItemState extends State<ZetaDropdownListItem> with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _animation;

  late bool _expanded;

  IconData get _icon {
    return widget.rounded ? ZetaIcons.expand_more_round : ZetaIcons.expand_more_sharp;
  }

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
    if (oldWidget.expanded != widget.expanded) {
      _setExpanded(widget.expanded);
    }
    super.didUpdateWidget(oldWidget);
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

    // DecoratedBox does not correctly animated the border when the widget expands.
    // ignore: use_decorated_box
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: divide ? colors.borderDefault : Colors.transparent,
          ),
        ),
      ),
      child: Column(
        children: [
          ZetaListItem(
            primaryText: widget.primaryText,
            secondaryText: widget.secondaryText,
            leading: widget.leading,
            onTap: _onTap,
            showDivider: false,
            trailing: IconButton(
              icon: AnimatedRotation(
                turns: _expanded ? 0.5 : 0,
                duration: ZetaAnimationLength.fast,
                child: Icon(
                  _icon,
                  color: colors.iconSubtle,
                ),
              ),
              onPressed: _onTap,
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
    );
  }
}
