// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// The type of [ZetaPriorityPill]; determines the default [ZetaPriorityPill.customColor], [ZetaPriorityPill.index] and [ZetaPriorityPill.label].
enum ZetaPriorityPillType {
  /// Sets the default color to `ZetaColors.red` and index to 'U'.
  urgent,

  /// Sets the default color to `ZetaColors.orange` and index to '1'.
  high,

  /// Sets the default color to `ZetaColors.blue` and index to '2'.
  medium,

  /// Sets the default color to `ZetaColors.green` and index to '3'.
  low,
}

/// The size of [ZetaPriorityPill].
enum ZetaPriorityPillSize {
  /// Large size contains both badge and lozenge.
  large,

  /// Small size contains badge only.
  small,
}

extension on ZetaPriorityPillType {
  ZetaColorSwatch color(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (this) {
      case ZetaPriorityPillType.urgent:
        return colors.red;
      case ZetaPriorityPillType.high:
        return colors.orange;
      case ZetaPriorityPillType.medium:
        return colors.blue;
      case ZetaPriorityPillType.low:
        return colors.green;
    }
  }
}

/// This badge is used to indicate the order of importance.
class ZetaPriorityPill extends ZetaStatelessWidget {
  ///Constructs [ZetaPriorityPill]
  const ZetaPriorityPill({
    super.rounded,
    super.key,
    this.index,
    @Deprecated('Use label instead. ' 'This variable has been renamed as of 0.11.0') this.priority,
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
  @Deprecated('Use label instead. ' 'This variable has been renamed as of 0.11.0')
  final String? priority;

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
    final ZetaColorSwatch color = customColor ?? type.color(context);
    final size = this.size == ZetaPriorityPillSize.small ? ZetaSpacing.xl_1 : ZetaSpacing.xl_3;
    final label = (this.label ?? priority) ?? type.name.capitalize();
    final rounded = context.rounded;

    return Semantics(
      value: semanticLabel ?? label,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: rounded ? ZetaRadius.full : ZetaRadius.none,
          color: color.shade10,
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
                color: color,
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
                        color: color.onColor,
                      )
                    : ZetaTextStyles.labelMedium.apply(color: color.onColor),
              ),
            ),
            if (!isBadge)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ZetaSpacing.small,
                  vertical: ZetaSpacing.minimum,
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
      ..add(StringProperty('priority', priority))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
