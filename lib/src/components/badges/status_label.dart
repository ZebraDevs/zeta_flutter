import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// To help some information, labels, or errors stand out, we present them with badges.
/// They can look like buttons, but users can’t select them. They just guide users to things they should pay attention to.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=21836-37274
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/badge/status-label
class ZetaStatusLabel extends ZetaStatelessWidget {
  ///Constructs [ZetaStatusLabel].
  const ZetaStatusLabel({
    super.key,
    super.rounded,
    required this.label,
    this.status = ZetaWidgetStatus.info,
    this.customIcon,
    this.semanticLabel,
  });

  /// {@macro zeta-component-badge-status}
  final ZetaWidgetStatus status;

  /// Text displayed on label.
  final String label;

  /// Optional custom icon. If null, default circle icon is used.
  final IconData? customIcon;

  /// The value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final ZetaColorSwatch colors = status.colorSwatch(context);

    return Semantics(
      value: semanticLabel ?? label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.shade10,
          border: Border.all(color: colors.border),
          borderRadius: context.rounded ? Zeta.of(context).radius.full : Zeta.of(context).radius.none,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Zeta.of(context).spacing.small,
            vertical: Zeta.of(context).spacing.minimum / 2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                customIcon ?? Icons.circle,
                size: customIcon != null ? Zeta.of(context).spacing.xl : Zeta.of(context).spacing.small,
                color: colors.icon,
              ),
              SizedBox(width: Zeta.of(context).spacing.small),
              Text(
                label,
                style: ZetaTextStyles.bodyMedium.apply(color: colors.shade10.onColor),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
      ..add(EnumProperty<ZetaWidgetStatus>('status', status))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
