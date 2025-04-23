import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Text badges notify users of line items that need attention.
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=21926-2099
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/badges/zetalabel/label
class ZetaLabel extends ZetaStatelessWidget {
  ///Constructs [ZetaLabel].
  const ZetaLabel({
    super.rounded,
    super.key,
    required this.label,
    this.status = ZetaWidgetStatus.info,
    this.semanticLabel,
  });

  /// {@template zeta-component-badge-status}
  /// Indicates the status of the badge.
  ///
  /// Defaults to "info"
  /// {@endtemplate}
  final ZetaWidgetStatus status;

  /// Label of the badge.
  final String label;

  /// The value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = status.surfaceColor(context);
    final Color foregroundColor = status.labelForegroundColor(context);

    return Semantics(
      label: semanticLabel ?? label,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.minimum),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius:
              BorderRadius.all(context.rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
        ),
        child: Text(
          label,
          style: Zeta.of(context).textStyles.labelSmall.apply(color: foregroundColor),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(EnumProperty<ZetaWidgetStatus>('status', status))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
