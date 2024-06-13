import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta Badge.
@Deprecated('Use ZetaLabel instead. ' 'This widget has been renamed as of 0.11.0')
typedef ZetaBadge = ZetaLabel;

/// Zeta Badge.
///
/// Text badges notify users of line items that need attention.
class ZetaLabel extends ZetaStatelessWidget {
  ///Constructs [ZetaLabel].
  const ZetaLabel({
    required this.label,
    this.status = ZetaWidgetStatus.info,
    super.rounded,
    super.key,
  });

  /// {@macro zeta-component-badge-status}
  final ZetaWidgetStatus status;

  /// Label of the badge.
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = status.labelBackgroundColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.minimum, vertical: ZetaSpacingBase.x0_5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: context.rounded ? ZetaRadius.minimal : ZetaRadius.none,
      ),
      child: Text(
        label,
        style: ZetaTextStyles.labelSmall.apply(color: backgroundColor.onColor),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(EnumProperty<ZetaWidgetStatus>('status', status))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
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
