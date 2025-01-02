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
    final colors = Zeta.of(context).colors;

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
  Color backgroundColor(ZetaSemanticColors colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.surfaceInfoSubtle;
      case ZetaWidgetStatus.positive:
        return colors.surfacePositiveSubtle;
      case ZetaWidgetStatus.warning:
        return colors.surfaceWarningSubtle;
      case ZetaWidgetStatus.negative:
        return colors.surfaceNegativeSubtle;
      case ZetaWidgetStatus.neutral:
        return colors.mainLight;
    }
  }

  /// Gets foreground color from [ZetaWidgetStatus].
  Color foregroundColor(ZetaSemanticColors colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.mainInfo;
      case ZetaWidgetStatus.positive:
        return colors.mainPositive;
      case ZetaWidgetStatus.warning:
        return colors.mainWarning;
      case ZetaWidgetStatus.negative:
        return colors.mainNegative;
      case ZetaWidgetStatus.neutral:
        return colors.mainSubtle;
    }
  }

  /// Gets border color from [ZetaWidgetStatus].
  Color borderColor(ZetaSemanticColors colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.borderInfo;
      case ZetaWidgetStatus.positive:
        return colors.borderPositive;
      case ZetaWidgetStatus.warning:
        return colors.borderWarning;
      case ZetaWidgetStatus.negative:
        return colors.borderNegative;
      case ZetaWidgetStatus.neutral:
        return colors.borderDefault;
    }
  }
}
