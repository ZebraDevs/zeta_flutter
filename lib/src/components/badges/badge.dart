import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Badge.
///
/// Text badges notify users of line items that need attention.
class ZetaBadge extends StatelessWidget {
  ///Constructs [ZetaBadge].
  const ZetaBadge({
    required this.label,
    this.status = ZetaWidgetStatus.info,
    this.rounded = true,
    super.key,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// {@template zeta-component-badge-status}
  /// Indicates the status of the badge.
  ///
  /// Defaults to "info"
  /// {@endtemplate}
  final ZetaWidgetStatus status;

  /// Label of the badge.
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = status.colorSwatch(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.minimum, vertical: ZetaSpacingBase.x0_5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
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
