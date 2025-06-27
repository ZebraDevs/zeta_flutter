// Ignored whilst type is deprecated
// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// The type of [ZetaPriorityPill]; determines the default [ZetaPriorityPill.customColor], [ZetaPriorityPill.index] and [ZetaPriorityPill.label].
@Deprecated('Use ZetaPriorityPillStatus instead. This will be removed in the next major version.')
typedef ZetaPriorityPillType = ZetaPriorityPillStatus;

/// The type of [ZetaPriorityPill]; determines the default [ZetaPriorityPill.customColor], [ZetaPriorityPill.index] and [ZetaPriorityPill.label].
enum ZetaPriorityPillStatus {
  /// Sets the default color to `ZetaColors.red` and index to 'U'.
  urgent,

  /// Sets the default color to `ZetaColors.orange` and index to '1'.
  high,

  /// Sets the default color to `ZetaColors.blue` and index to '2'.
  medium,

  /// Sets the default color to `ZetaColors.green` and index to '3'.
  low;

  Color _badgeColor(BuildContext context) => switch (this) {
        ZetaPriorityPillStatus.urgent => Zeta.of(context).colors.mainNegative,
        ZetaPriorityPillStatus.high => Zeta.of(context).colors.mainWarning,
        ZetaPriorityPillStatus.medium => Zeta.of(context).colors.mainPrimary,
        ZetaPriorityPillStatus.low => Zeta.of(context).colors.mainPositive,
      };

  Color _lozengeColor(BuildContext context) => switch (this) {
        ZetaPriorityPillStatus.urgent => Zeta.of(context).colors.surfaceNegativeSubtle,
        ZetaPriorityPillStatus.high => Zeta.of(context).colors.surfaceWarningSubtle,
        ZetaPriorityPillStatus.medium => Zeta.of(context).colors.surfacePrimarySubtle,
        ZetaPriorityPillStatus.low => Zeta.of(context).colors.surfacePositiveSubtle,
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
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/badges/zetaprioritypill/priority-pill
class ZetaPriorityPill extends ZetaStatelessWidget {
  ///Constructs [ZetaPriorityPill]
  const ZetaPriorityPill({
    super.rounded,
    super.key,
    this.index,
    this.label,
    this.isBadge = false,
    this.status = ZetaPriorityPillStatus.urgent,
    @Deprecated('Use Status instead. This will be removed in the next major version.')
    this.type = ZetaPriorityPillStatus.urgent,
    this.size = ZetaPriorityPillSize.large,
    this.customColor,
    this.semanticLabel,
  });

  /// Leading number / character in component. Will be truncated to single character.
  ///
  /// Defaults to value based on [status].
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
  /// Default is [ZetaPriorityPillStatus.urgent]
  @Deprecated('Use Status instead. This will be removed in the next major version.')
  final ZetaPriorityPillType type;

  /// The status of [ZetaPriorityPill].
  ///
  /// Default is [ZetaPriorityPillStatus.urgent]
  final ZetaPriorityPillStatus status;

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
    // This is only needed whilst `ZetaPriorityPillType` is deprecated.
    final ZetaPriorityPillStatus statusType;
    if (type != ZetaPriorityPillStatus.urgent) {
      statusType = type;
    } else {
      statusType = status;
    }

    final Color badgeColor = customColor?.shade60 ?? statusType._badgeColor(context);
    final Color lozengeColor = customColor?.shade10 ?? statusType._lozengeColor(context);

    final size = this.size == ZetaPriorityPillSize.small ? Zeta.of(context).spacing.xl : Zeta.of(context).spacing.xl_3;
    final label = this.label ?? type.name.capitalize;
    final rounded = context.rounded;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          value: semanticLabel ?? label,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(rounded ? Zeta.of(context).radius.full : Zeta.of(context).radius.none),
              color: lozengeColor,
            ),
            child: Row(
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
                        ? (type == ZetaPriorityPillStatus.urgent
                            ? type.name.substring(0, 1).capitalize
                            : type.index.toString())
                        : index!.substring(0, 1).capitalize,
                    style: this.size == ZetaPriorityPillSize.small
                        ? Zeta.of(context).textStyles.labelSmall.copyWith(
                              fontSize: 10,
                              height: 13 / 10,
                              color: Zeta.of(context).colors.stateDefaultEnabled,
                            )
                        : Zeta.of(context).textStyles.labelMedium.apply(
                              color: Zeta.of(context).colors.stateDefaultEnabled,
                            ),
                  ),
                ),
                if (!isBadge)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Zeta.of(context).spacing.small,
                      // vertical: Zeta.of(context).spacing.minimum,
                    ),
                    child: Text(
                      label,
                      style: this.size == ZetaPriorityPillSize.small
                          ? Zeta.of(context).textStyles.bodyXSmall.copyWith(
                                fontSize: 10,
                                height: 13 / 10,
                              )
                          : Zeta.of(context).textStyles.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('index', index))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('isBadge', isBadge))
      ..add(EnumProperty<ZetaPriorityPillStatus?>('type', type))
      ..add(EnumProperty<ZetaPriorityPillSize>('size', size))
      ..add(StringProperty('label', label))
      ..add(ColorProperty('customColor', customColor))
      ..add(StringProperty('semanticLabel', semanticLabel))
      ..add(EnumProperty<ZetaPriorityPillStatus>('status', status));
  }
}
