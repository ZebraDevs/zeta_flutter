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
          child: Builder(
            builder: (context) {
              return Semantics(
                button: true,
                child: SelectionContainer.disabled(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        SizedBox(width: Zeta.of(context).spacing.medium),
                        icon,
                      ],
                      if (text != null)
                        Padding(
                          padding:
                              icon != null ? EdgeInsets.only(left: Zeta.of(context).spacing.small) : EdgeInsets.zero,
                          child: Text(text),
                        ),
                      if (icon != null) SizedBox(width: Zeta.of(context).spacing.medium),
                    ],
                  ),
                ),
              );
            },
          ),
        );
}
