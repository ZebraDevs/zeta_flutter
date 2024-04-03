import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Indicator Type
enum ZetaWorkcloudIndicatorType {
  /// Red.
  one,

  /// Orange
  two,

  /// Blue.
  three,

  /// Green.
  four,

  /// Purple.
  five,

  /// Pink.
  six,

  /// Yellow.
  seven,

  /// Teal
  eight,

  /// Cool grey.
  nine,

  /// Warn grey.
  ten,
}

extension on ZetaWorkcloudIndicatorType {
  ZetaColorSwatch color(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (this) {
      case ZetaWorkcloudIndicatorType.one:
        return colors.red;
      case ZetaWorkcloudIndicatorType.two:
        return colors.orange;
      case ZetaWorkcloudIndicatorType.three:
        return colors.blue;
      case ZetaWorkcloudIndicatorType.four:
        return colors.green;
      case ZetaWorkcloudIndicatorType.five:
        return colors.purple;
      case ZetaWorkcloudIndicatorType.six:
        return colors.pink;
      case ZetaWorkcloudIndicatorType.seven:
        return colors.yellow;
      case ZetaWorkcloudIndicatorType.eight:
        return colors.teal;
      case ZetaWorkcloudIndicatorType.nine:
        return colors.cool;
      case ZetaWorkcloudIndicatorType.ten:
        return colors.warm;
    }
  }
}

/// Zeta Workcloud Indicator.
///
/// There are 10 available levels in which ether the values 1 through 10 can be used,
/// or icons can be passed.
class ZetaWorkcloudIndicator extends StatelessWidget {
  ///Constructs [ZetaWorkcloudIndicator]
  const ZetaWorkcloudIndicator({
    super.key,
    this.priorityType = ZetaWorkcloudIndicatorType.one,
    this.prioritySize = ZetaWidgetSize.small,
    this.label,
    this.index,
    this.icon,
  });

  /// The type of priority.
  final ZetaWorkcloudIndicatorType priorityType;

  /// The size of Priority Pill.
  ///
  /// Defaults to 'small'.
  final ZetaWidgetSize prioritySize;

  /// Text label. Not shown when [prioritySize] is [ZetaWidgetSize.small]
  final String? label;

  /// Index value. Typically a number.
  ///
  /// If null, and no icon is provided, the index will match the [priorityType].
  ///
  /// It is recommended to not exceed 2 characters here.
  final String? index;

  /// Custom icon. If not null, this will replace the index text.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final ZetaColorSwatch color = priorityType.color(context);
    final textStyle = prioritySize == ZetaWidgetSize.large ? ZetaTextStyles.bodySmall : ZetaTextStyles.bodyXSmall;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ZetaSpacing.l),
        color: color.shade20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: prioritySize == ZetaWidgetSize.large ? ZetaSpacing.x6 : ZetaSpacing.x5,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: priorityType == ZetaWorkcloudIndicatorType.nine ? color.shade80 : color,
              ),
              child: Center(
                child: icon != null
                    ? Icon(
                        icon,
                        size: prioritySize == ZetaWidgetSize.large ? ZetaSpacing.x4 : ZetaSpacing.x3_5,
                        color: color.onColor,
                      )
                    : Text(
                        index ?? (priorityType.index + 1).toString(),
                        style: textStyle.apply(color: color.onColor),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
          if (prioritySize != ZetaWidgetSize.small)
            Container(
              constraints: const BoxConstraints(minWidth: ZetaSpacing.x9),
              padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.xs),
              child: Text(label ?? '', style: textStyle, overflow: TextOverflow.ellipsis),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        EnumProperty<ZetaWorkcloudIndicatorType?>('priorityType', priorityType),
      )
      ..add(
        EnumProperty<ZetaWidgetSize?>('prioritySize', prioritySize),
      )
      ..add(StringProperty('label', label))
      ..add(StringProperty('index', index))
      ..add(DiagnosticsProperty<IconData?>('icon', icon));
  }
}
