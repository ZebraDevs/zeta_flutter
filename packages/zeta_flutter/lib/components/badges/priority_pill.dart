import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// The type of [ZetaPriorityPill]; determines the default [ZetaPriorityPill.customColor], [ZetaPriorityPill.index] and [ZetaPriorityPill.label].
enum ZetaPriorityPillType {
  /// Sets the default color to `ZetaColors.red` and index to 'U'.
  urgent,

  /// Sets the default color to `ZetaColors.orange` and index to '1'.
  high,

  /// Sets the default color to `ZetaColors.blue` and index to '2'.
  medium,

  /// Sets the default color to `ZetaColors.green` and index to '3'.
  low;

  Color _badgeColor(BuildContext context) => switch (this) {
        ZetaPriorityPillType.urgent => Zeta.of(context).colors.mainNegative,
        ZetaPriorityPillType.high => Zeta.of(context).colors.mainWarning,
        ZetaPriorityPillType.medium => Zeta.of(context).colors.mainPrimary,
        ZetaPriorityPillType.low => Zeta.of(context).colors.mainPositive,
      };

  Color _lozengeColor(BuildContext context) => switch (this) {
        ZetaPriorityPillType.urgent => Zeta.of(context).colors.surfaceNegativeSubtle,
        ZetaPriorityPillType.high => Zeta.of(context).colors.surfaceWarningSubtle,
        ZetaPriorityPillType.medium => Zeta.of(context).colors.surfacePrimarySubtle,
        ZetaPriorityPillType.low => Zeta.of(context).colors.surfacePositiveSubtle,
      };
}

/// The size of [ZetaPriorityPill].
enum ZetaPriorityPillSize {
  /// Large size contains both badge and lozenge.
  large,

  /// Small size contains badge only.
  small,
}

/// This badge is used to indicate the order of importance.
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=22000-15955
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/badge/priority-pill
class ZetaPriorityPill extends ZetaStatelessWidget {
  ///Constructs [ZetaPriorityPill]
  const ZetaPriorityPill({
    super.rounded,
    super.key,
    this.index,
    this.label,
    this.isBadge = false,
    this.type = ZetaPriorityPillType.urgent,
    this.size = ZetaPriorityPillSize.large,
    this.customColor,
    this.semanticLabel,
  });

  /// Leading number / character in component. Will be truncated to single character.
  ///
  /// Defaults to value based on [type].
  ///  * Urgent = U
  ///  * High = 1
  ///  * Medium = 2
  ///  * Low = 3
  final String? index;

  /// Text in main part of component.
  final String? label;

  /// Indicates if it is badge or lozenge.
  ///
  /// Default is `false` (lozenge).
  final bool isBadge;

  /// The type of [ZetaPriorityPill].
  ///
  /// Default is [ZetaPriorityPillType.urgent]
  final ZetaPriorityPillType type;

  /// The size of [ZetaPriorityPill].
  ///
  /// Default is [ZetaWidgetSize.large].
  final ZetaPriorityPillSize size;

  /// Color override
  final ZetaColorSwatch? customColor;

  /// The value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final Color badgeColor = customColor?.shade60 ?? type._badgeColor(context);
    final Color lozengeColor = customColor?.shade10 ?? type._lozengeColor(context);

    final size = this.size == ZetaPriorityPillSize.small ? Zeta.of(context).spacing.xl : Zeta.of(context).spacing.xl_3;
    final label = this.label ?? type.name.capitalize();
    final rounded = context.rounded;

    return Semantics(
      value: semanticLabel ?? label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(rounded ? Zeta.of(context).radius.full : Zeta.of(context).radius.none),
          color: lozengeColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              height: size,
              width: size,
              decoration: BoxDecoration(
                shape: rounded ? BoxShape.circle : BoxShape.rectangle,
                color: badgeColor,
              ),
              child: Text(
                (index?.isEmpty ?? true)
                    ? (type == ZetaPriorityPillType.urgent
                        ? type.name.substring(0, 1).capitalize()
                        : type.index.toString())
                    : index!.substring(0, 1).capitalize(),
                style: this.size == ZetaPriorityPillSize.small
                    ? ZetaTextStyles.labelSmall.copyWith(
                        fontSize: 10,
                        height: 13 / 10,
                        color: Zeta.of(context).colors.mainInverse,
                      )
                    : ZetaTextStyles.labelMedium.apply(color: Zeta.of(context).colors.mainInverse),
              ),
            ),
            if (!isBadge)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Zeta.of(context).spacing.small,
                  vertical: Zeta.of(context).spacing.minimum,
                ),
                child: Text(
                  label,
                  style: this.size == ZetaPriorityPillSize.small
                      ? ZetaTextStyles.bodyXSmall.copyWith(
                          fontSize: 10,
                          height: 13 / 10,
                        )
                      : ZetaTextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
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
      ..add(StringProperty('index', index))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('isBadge', isBadge))
      ..add(EnumProperty<ZetaPriorityPillType?>('type', type))
      ..add(EnumProperty<ZetaPriorityPillSize>('size', size))
      ..add(StringProperty('label', label))
      ..add(ColorProperty('customColor', customColor))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
