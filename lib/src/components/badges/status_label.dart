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
    final Color textColor = colors.main.defaultColor;
    return Semantics(
      value: semanticLabel ?? label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: context.rounded ? Zeta.of(context).radii.full : Zeta.of(context).radii.none,
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

/// Extensions on [ZetaWidgetStatus].
extension on ZetaWidgetStatus {
  /// Gets background color from [ZetaWidgetStatus].
  Color backgroundColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.surface.infoSubtle;
      case ZetaWidgetStatus.positive:
        return colors.surface.positiveSubtle;
      case ZetaWidgetStatus.warning:
        return colors.surface.warningSubtle;
      case ZetaWidgetStatus.negative:
        return colors.surface.negativeSubtle;
      case ZetaWidgetStatus.neutral:
        return colors.main.light;
    }
  }

  /// Gets foreground color from [ZetaWidgetStatus].
  Color foregroundColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.main.info;
      case ZetaWidgetStatus.positive:
        return colors.main.positive;
      case ZetaWidgetStatus.warning:
        return colors.main.warning;
      case ZetaWidgetStatus.negative:
        return colors.main.negative;
      case ZetaWidgetStatus.neutral:
        return colors.main.subtle;
    }
  }

  /// Gets border color from [ZetaWidgetStatus].
  Color borderColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.border.info;
      case ZetaWidgetStatus.positive:
        return colors.border.positive;
      case ZetaWidgetStatus.warning:
        return colors.border.warning;
      case ZetaWidgetStatus.negative:
        return colors.border.negative;
      case ZetaWidgetStatus.neutral:
        return colors.border.defaultColor;
    }
  }
}
