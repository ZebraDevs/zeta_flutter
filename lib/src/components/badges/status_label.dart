import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Zeta Status Label.
///
/// To help some information, labels, or errors stand out, we present them with badges.
/// They can look like buttons, but users can’t select them. They just guide users to things they should pay attention to.
class ZetaStatusLabel extends StatelessWidget {
  ///Constructs [ZetaStatusLabel].
  const ZetaStatusLabel({
    super.key,
    required this.label,
    this.rounded = true,
    this.status = ZetaWidgetStatus.info,
    this.customIcon,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// {@macro zeta-component-badge-status}
  final ZetaWidgetStatus status;

  /// Text displayed on label.
  final String label;

  /// Optional custom icon. If null, default circle icon is used.
  final IconData? customIcon;

  @override
  Widget build(BuildContext context) {
    final ZetaColorSwatch colors = status.colorSwatch(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.shade10,
        border: Border.all(color: colors.border),
        borderRadius: rounded ? ZetaRadius.full : ZetaRadius.none,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.small, vertical: ZetaSpacingBase.x0_5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              customIcon ?? Icons.circle,
              size: customIcon != null ? ZetaSpacing.xL : ZetaSpacing.small,
              color: colors.icon,
            ),
            const SizedBox(width: ZetaSpacing.small),
            Text(
              label,
              style: ZetaTextStyles.bodyMedium.apply(color: colors.shade10.onColor),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<IconData?>('customIcon', customIcon))
      ..add(EnumProperty<ZetaWidgetStatus>('severity', status));
  }
}
