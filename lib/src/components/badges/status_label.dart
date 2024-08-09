import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// To help some information, labels, or errors stand out, we present them with badges.
/// They can look like buttons, but users can’t select them. They just guide users to things they should pay attention to.
/// {@category Components}
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
    final colors = Zeta.of(context).colors;

    // final Color colors = status.colorSwatch(context);
    final Color backgroundColor = status.backgroundColor(colors);
    final Color borderColor = status.borderColor(colors);
    final Color iconColor = status.foregroundColor(colors);
    final Color textColor = colors.mainDefault;
    return Semantics(
      value: semanticLabel ?? label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: context.rounded ? Zeta.of(context).radii.full : Zeta.of(context).radii.none,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.small, vertical: ZetaSpacingBase.x0_5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                customIcon ?? Icons.circle,
                size: customIcon != null ? Zeta.of(context).spacing.xl : Zeta.of(context).spacing.small,
                color: iconColor,
              ),
              SizedBox(width: Zeta.of(context).spacing.small),
              Text(
                label,
                style: ZetaTextStyles.bodyMedium.apply(color: textColor),
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
