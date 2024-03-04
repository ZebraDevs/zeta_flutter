import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaIndicator] type.
enum ZetaIndicatorType {
  /// Shows an icon on [ZetaIndicator]. Defaults to [ZetaIcons.star_round].
  icon,

  /// Shows a number on [ZetaIndicator] from provided [ZetaIndicator.value].
  notification,
}

/// ZetaIndicator.
///
/// Indicators are used to show the status of a user or any messages/notifications they might have.
class ZetaIndicator extends StatelessWidget {
  /// Constructor for [ZetaIndicator].
  const ZetaIndicator({
    super.key,
    this.type = ZetaIndicatorType.notification,
    this.size = ZetaWidgetSize.large,
    this.icon,
    this.value,
    this.inverse = false,
  });

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.icon].
  const ZetaIndicator.icon({
    super.key,
    this.size = ZetaWidgetSize.large,
    this.inverse = false,
    this.icon,
  })  : type = ZetaIndicatorType.icon,
        value = null;

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.notification].
  const ZetaIndicator.notification({
    super.key,
    this.size = ZetaWidgetSize.large,
    this.inverse = false,
    this.icon,
    this.value,
  }) : type = ZetaIndicatorType.notification;

  /// The type of the [ZetaIndicator] - icon or notification.
  ///
  /// Defaults to [ZetaIndicatorType.notification].
  final ZetaIndicatorType type;

  /// The size of the [ZetaIndicator]. Default is [ZetaWidgetSize.large]
  final ZetaWidgetSize size;

  /// Inverse the border color.
  ///
  /// Defaults to false.
  final bool inverse;

  /// Indicator icon, default: `ZetaIcons.star_round`.
  final Icon? icon;

  /// Value for the type `notification`.
  final int? value;

  /// Creates a clone.
  ZetaIndicator copyWith({
    ZetaIndicatorType? type,
    ZetaWidgetSize? size,
    Icon? icon,
    int? value,
    bool? inverse,
  }) {
    return ZetaIndicator(
      type: type ?? this.type,
      size: size ?? this.size,
      icon: icon ?? this.icon,
      value: value ?? this.value,
      inverse: inverse ?? this.inverse,
    );
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final Color backgroundColor = (type == ZetaIndicatorType.icon ? zetaColors.blue : zetaColors.negative);
    final Color foregroundColor = backgroundColor.onColor;
    final sizePixels = _getSizePixels(size, type);

    return Container(
      width: sizePixels + ZetaSpacing.x1,
      height: sizePixels + ZetaSpacing.x1,
      decoration: BoxDecoration(
        color: (inverse ? foregroundColor : Colors.transparent),
        borderRadius: ZetaRadius.full,
      ),
      child: Center(
        child: Container(
          width: sizePixels,
          height: sizePixels,
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(ZetaSpacing.x4)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ZetaSpacing.x4),
            clipBehavior: Clip.hardEdge,
            child: size == ZetaWidgetSize.small ? null : _buildContent(foregroundColor),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color foregroundColor) {
    switch (type) {
      case ZetaIndicatorType.icon:
        final iconSize = _getIconSize(size);
        return Center(
          child: IconTheme(
            data: IconThemeData(color: foregroundColor, size: iconSize),
            child: icon ?? const Icon(ZetaIcons.star_round),
          ),
        );
      case ZetaIndicatorType.notification:
        return Center(
          child: Text(
            value.formatMaxChars(),
            style: (size == ZetaWidgetSize.large ? ZetaTextStyles.labelIndicator : ZetaTextStyles.labelTiny)
                .apply(color: foregroundColor),
          ),
        );
    }
  }

  /// Returns the size of [ZetaWidgetSize] in pixels.
  double _getSizePixels(ZetaWidgetSize size, ZetaIndicatorType type) {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.x4;
      case ZetaWidgetSize.medium:
        return type == ZetaIndicatorType.icon ? ZetaSpacing.x3 : ZetaSpacing.x3_5;
      case ZetaWidgetSize.small:
        return ZetaSpacing.x2;
    }
  }

  double _getIconSize(ZetaWidgetSize size) {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.x3;
      case ZetaWidgetSize.medium:
        return ZetaSpacing.x2;
      case ZetaWidgetSize.small:
        return 0;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaIndicatorType>('type', type))
      ..add(DiagnosticsProperty<ZetaWidgetSize>('size', size))
      ..add(DiagnosticsProperty<int?>('value', value))
      ..add(DiagnosticsProperty<Icon?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('inverseBorder', inverse));
  }
}
