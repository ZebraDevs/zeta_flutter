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

/// [ZetaIndicator] size.
enum ZetaIndicatorSize {
  /// Largest size - [ZetaSpacing.x4] 16x16 pixels.
  large,

  /// Medium size - [ZetaSpacing.x3] - 12x12 pixels for [ZetaIndicatorType.icon] or [ZetaSpacing.x3_5] - 14x14 pixels for [ZetaIndicatorType.notification].
  medium,

  /// Smallest size - [ZetaSpacing.x2] - 8x8 pixels.
  small,
}

/// ZetaIndicator.
///
/// Indicators are used to show the status of a user or any messages/notifications they might have.
class ZetaIndicator extends StatelessWidget {
  /// Constructor for [ZetaIndicator].
  ZetaIndicator({
    super.key,
    required this.type,
    this.size = ZetaIndicatorSize.large,
    this.icon,
    this.value,
    this.inverse = false,
  }) {
    _sizePixels = _getSizePixels(size, type);
  }

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.icon].
  factory ZetaIndicator.icon({
    ZetaIndicatorSize size = ZetaIndicatorSize.large,
    bool inverseBorder = false,
    Icon? icon,
  }) =>
      ZetaIndicator(
        type: ZetaIndicatorType.icon,
        size: size,
        inverse: inverseBorder,
        icon: icon,
      );

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.notification].
  factory ZetaIndicator.notification({
    ZetaIndicatorSize size = ZetaIndicatorSize.large,
    bool inverseBorder = false,
    int? value,
  }) =>
      ZetaIndicator(
        type: ZetaIndicatorType.notification,
        size: size,
        inverse: inverseBorder,
        value: value,
      );

  /// The type of the [ZetaIndicator] - icon or notification.
  final ZetaIndicatorType type;

  /// The size of the [ZetaIndicator]. Default is [ZetaIndicatorSize.large]
  final ZetaIndicatorSize size;

  /// Inverse the border color.
  final bool inverse;

  /// Indicator icon, default: `ZetaIcons.star_round`.
  final Icon? icon;

  /// Value for the type `notification`.
  final int? value;

  late final double _sizePixels;

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final Color backgroundColor = (type == ZetaIndicatorType.icon ? zetaColors.blue : zetaColors.negative);
    final Color foregroundColor = backgroundColor.onColor;

    return Container(
      width: _sizePixels + ZetaSpacing.x1,
      height: _sizePixels + ZetaSpacing.x1,
      decoration: BoxDecoration(
        color: (inverse ? foregroundColor : Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Container(
          width: _sizePixels,
          height: _sizePixels,
          decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(ZetaSpacing.x4)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ZetaSpacing.x4),
            clipBehavior: Clip.hardEdge,
            child: size == ZetaIndicatorSize.small ? null : _buildContent(foregroundColor),
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
            style: (size == ZetaIndicatorSize.large ? ZetaTextStyles.labelIndicator : ZetaTextStyles.labelTiny)
                .apply(color: foregroundColor),
          ),
        );
    }
  }

  /// Returns the size of [ZetaIndicatorSize] in pixels
  double _getSizePixels(ZetaIndicatorSize size, ZetaIndicatorType type) {
    switch (size) {
      case ZetaIndicatorSize.large:
        return ZetaSpacing.x4;
      case ZetaIndicatorSize.medium:
        return type == ZetaIndicatorType.icon ? ZetaSpacing.x3 : ZetaSpacing.x3_5;
      case ZetaIndicatorSize.small:
        return ZetaSpacing.x2;
    }
  }

  double _getIconSize(ZetaIndicatorSize size) {
    switch (size) {
      case ZetaIndicatorSize.large:
        return ZetaSpacing.x3;
      case ZetaIndicatorSize.medium:
        return ZetaSpacing.x2;
      case ZetaIndicatorSize.small:
        return ZetaSpacing.x0;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaIndicatorType>('type', type))
      ..add(DiagnosticsProperty<ZetaIndicatorSize>('size', size))
      ..add(DiagnosticsProperty<int?>('value', value))
      ..add(DiagnosticsProperty<Icon?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('inverseBorder', inverse));
  }
}
