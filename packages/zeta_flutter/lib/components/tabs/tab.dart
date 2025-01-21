import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

/// Defines how the bounds of the selected tab indicator are computed.
/// Intended to be used with [ZetaTabBar].
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-18&node-type=canvas&m=dev
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/tabs
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
