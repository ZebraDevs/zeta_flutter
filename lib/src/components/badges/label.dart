import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta Badge.
@Deprecated('Use ZetaLabel instead. ' 'This widget has been renamed as of 0.11.0')
typedef ZetaBadge = ZetaLabel;

/// Text badges notify users of line items that need attention.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=21926-2099
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/badge/label
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
    final Color backgroundColor = status.labelBackgroundColor(context);

    return Semantics(
      label: semanticLabel ?? label,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.minimum),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: context.rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
        ),
        child: Text(
          label,
          style: ZetaTextStyles.labelSmall.apply(color: backgroundColor.onColor),
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

extension on ZetaWidgetStatus {
  Color labelBackgroundColor(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.surfaceInfo;
      case ZetaWidgetStatus.positive:
        return colors.surfacePositive;
      case ZetaWidgetStatus.warning:
        return colors.surfaceWarning.shade40;
      case ZetaWidgetStatus.negative:
        return colors.surfaceNegative;
      case ZetaWidgetStatus.neutral:
        return colors.cool.shade30;
    }
  }
}
