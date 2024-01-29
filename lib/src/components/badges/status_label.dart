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

  /// {@zeta-component-rounded}
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
        borderRadius: rounded ? ZetaRadius.full : ZetaRadius.minimal,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.x2, vertical: ZetaSpacing.x1 / 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(customIcon ?? Icons.circle, size: ZetaSpacing.x2, color: colors.icon),
            const SizedBox(width: ZetaSpacing.xs),
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
