import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Tab item to be used in [ZetaGlobalHeader].
/// {@category Components}
class ZetaGlobalHeaderItem extends ZetaStatefulWidget {
  ///Constructor for tab item
  const ZetaGlobalHeaderItem({
    super.key,
    super.rounded,
    this.dropdown,
    this.active,
    this.handlePress,
    required this.label,
  });

  /// Dropdown widget for tab item
  final Widget? dropdown;

  /// If the tab item is the active tab item
  final bool? active;

  /// Handle press of tab item
  final VoidCallback? handlePress;

  /// Content displayed on tab.
  final String label;

  @override
  State<ZetaGlobalHeaderItem> createState() => _ZetaGlobalHeaderItemState();

  /// Return copy
  ZetaGlobalHeaderItem copyWith({
    Widget? dropdown,
    bool? active,
    VoidCallback? handlePress,
    String? label,
  }) {
    return ZetaGlobalHeaderItem(
      dropdown: dropdown ?? this.dropdown,
      active: active ?? this.active,
      handlePress: handlePress ?? this.handlePress,
      label: label ?? this.label,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('active', active))
      ..add(ObjectFlagProperty<VoidCallback?>.has('handlePress', handlePress))
      ..add(StringProperty('label', label));
  }
}

class _ZetaGlobalHeaderItemState extends State<ZetaGlobalHeaderItem> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final foregroundColor = widget.active! ? colors.main.primary : colors.main.subtle;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.handlePress,
          child: Row(
            children: [
              Text(widget.label, style: TextStyle(color: foregroundColor)),
              SizedBox(width: Zeta.of(context).spacing.small),
              if (widget.dropdown != null) ZetaIcon(ZetaIcons.expand_more, color: foregroundColor),
            ],
          ).paddingHorizontal(Zeta.of(context).spacing.xl_2).paddingVertical(Zeta.of(context).spacing.medium),
        ),
      ),
    );
  }
}
