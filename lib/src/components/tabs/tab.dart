import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Defines how the bounds of the selected tab indicator are computed.
/// Intended to be used with [ZetaTabBar].
/// {@category Components}
class ZetaTab extends Tab {
  /// Creates a Zeta Design tab bar.
  ZetaTab({
    Widget? icon,
    String? text,
    super.key,
  }) : super(
          child: Semantics(
            button: true,
            child: SelectionContainer.disabled(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    const SizedBox(width: ZetaSpacing.medium),
                    icon,
                  ],
                  if (text != null)
                    Padding(
                      padding: icon != null ? const EdgeInsets.only(left: ZetaSpacing.small) : EdgeInsets.zero,
                      child: Text(text),
                    ),
                  if (icon != null) const SizedBox(width: ZetaSpacing.medium),
                ],
              ),
            ),
          ),
        );
}
