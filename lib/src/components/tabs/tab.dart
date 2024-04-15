import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Defines how the bounds of the selected tab indicator are computed. Intended to be used with [ZetaTabBar].
class ZetaTab extends Tab {
  /// Creates a Zeta Design tab bar.
  ZetaTab({
    Widget? icon,
    String? text,
    super.key,
  }) : super(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                const SizedBox(width: ZetaSpacing.s),
                icon,
              ],
              if (text != null)
                Padding(
                  padding: icon != null ? const EdgeInsets.only(left: ZetaSpacing.x2) : EdgeInsets.zero,
                  child: Text(text),
                ),
              if (icon != null) const SizedBox(width: ZetaSpacing.s),
            ],
          ),
        );
}
