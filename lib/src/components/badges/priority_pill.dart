import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// The type of [ZetaPriorityPill].
enum ZetaPriorityPillType {
  /// sets the color to a shade of red
  urgent,

  /// sets the color to a shade of orange
  high,

  /// sets the color to a shade of blue
  medium,

  /// sets the color to a shade of green
  low,
}

/// The size of [ZetaPriorityPill].
enum ZetaPriorityPillSize {
  /// large
  large,

  /// small
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

/// Zeta Priority Pill.
///
/// This badge is used to indicate the order of importance.
class ZetaPriorityPill extends StatelessWidget {
  ///Constructs [ZetaPriorityPill]
  const ZetaPriorityPill({
    this.index,
    this.priority,
    this.rounded = true,
    this.isBadge = false,
    this.type = ZetaPriorityPillType.urgent,
    this.size = ZetaPriorityPillSize.large,
    super.key,
  });

  /// {@macro zeta-component-rounded}
  final bool rounded;

  /// Leading number in component.
  final String? index;

  /// Text in main part of component.
  final String? priority;

  /// Indicates if it is badge or lozenge.
  ///
  /// Default is `false` (lozenge).
  final bool isBadge;

  /// The type of [ZetaPriorityPill].
  ///
  /// Default is 'ZetaPriorityPillType.urgent'
  final ZetaPriorityPillType type;

  /// The size of [ZetaPriorityPill].
  ///
  /// Default is `ZetaWidgetSize.large`.
  final ZetaPriorityPillSize size;

  @override
  Widget build(BuildContext context) {
    final color = type.color(context);
    final size = this.size == ZetaPriorityPillSize.small ? ZetaSpacing.xL : ZetaSpacing.xL3;

    return DecoratedBox(
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
                      fontSize: 11,
                      height: 1.1,
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
                (priority?.isEmpty ?? true) ? type.name.capitalize() : priority!,
                style: this.size == ZetaPriorityPillSize.small
                    ? ZetaTextStyles.bodyXSmall.copyWith(
                        fontSize: 11,
                        height: 1.1,
                      )
                    : ZetaTextStyles.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('index', index))
      ..add(StringProperty('priority', priority))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('isBadge', isBadge))
      ..add(EnumProperty<ZetaPriorityPillType?>('type', type))
      ..add(EnumProperty<ZetaPriorityPillSize>('size', size));
  }
}
