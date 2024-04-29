import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Tab item to be used in [ZetaGlobalHeader]
class ZetaTabItem extends StatefulWidget {
  ///Constructor for tab item
  const ZetaTabItem({super.key, this.dropdown, this.active, this.handlePress});

  /// Dropdown widget for tab item
  final Widget? dropdown;

  /// If the tab item is the actvie tab item
  final bool? active;

  /// Handle press of tab item
  final VoidCallback? handlePress;

  @override
  State<ZetaTabItem> createState() => _ZetaTabItemState();

  /// Return copy
  ZetaTabItem copyWith({
    Widget? dropdown,
    bool? active,
    VoidCallback? handlePress,
  }) {
    return ZetaTabItem(
      dropdown: dropdown ?? this.dropdown,
      active: active ?? this.active,
      handlePress: handlePress ?? this.handlePress,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool?>('active', active))
      ..add(ObjectFlagProperty<VoidCallback?>.has('handlePress', handlePress));
  }
}

class _ZetaTabItemState extends State<ZetaTabItem> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    final foregroundColor = widget.active! ? colors.primary : colors.textSubtle;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.handlePress,
        child: Row(
          children: [
            Text(
              'Button',
              style: TextStyle(color: foregroundColor),
            ),
            const SizedBox(
              width: ZetaSpacing.x2,
            ),
            if (widget.dropdown != null)
              Icon(
                ZetaIcons.expand_more_round,
                color: foregroundColor,
              ),
          ],
        ).paddingHorizontal(ZetaSpacing.m).paddingVertical(ZetaSpacing.s),
      ),
    );
  }
}
