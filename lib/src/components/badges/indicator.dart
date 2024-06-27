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
class ZetaIndicator extends ZetaStatelessWidget {
  /// Constructor for [ZetaIndicator].
  const ZetaIndicator({
    super.key,
    super.rounded,
    this.type = ZetaIndicatorType.notification,
    this.size = ZetaWidgetSize.large,
    this.icon,
    this.value,
    this.inverse = false,
    this.color,
    this.semanticLabel,
  });

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.icon].
  const ZetaIndicator.icon({
    super.key,
    super.rounded,
    this.size = ZetaWidgetSize.large,
    this.inverse = false,
    this.icon,
    this.color,
    this.semanticLabel,
  })  : type = ZetaIndicatorType.icon,
        value = null;

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.notification].
  const ZetaIndicator.notification({
    super.key,
    super.rounded,
    this.size = ZetaWidgetSize.large,
    this.inverse = false,
    this.value,
    this.color,
    this.semanticLabel,
  })  : type = ZetaIndicatorType.notification,
        icon = null;

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
  final IconData? icon;

  /// Value for the type `notification`.
  final int? value;

  /// Color for zeta indicator
  final Color? color;

  /// Value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [value] is used.
  final String? semanticLabel;

  /// Creates a clone.
  ZetaIndicator copyWith({
    ZetaIndicatorType? type,
    ZetaWidgetSize? size,
    IconData? icon,
    int? value,
    bool? inverse,
    Key? key,
  }) {
    return ZetaIndicator(
      key: key ?? this.key,
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
    final Color backgroundColor = (type == ZetaIndicatorType.icon ? zetaColors.blue : zetaColors.surfaceNegative);
    final Color foregroundColor = backgroundColor.onColor;
    final sizePixels = _getSizePixels(size, type);

    return Semantics(
      value: semanticLabel ?? value?.toString() ?? '',
      child: Container(
        width: sizePixels + ZetaSpacing.minimum,
        height: sizePixels + ZetaSpacing.minimum,
        decoration: BoxDecoration(
          border: Border.all(width: ZetaSpacingBase.x0_5, color: zetaColors.borderSubtle),
          color: (inverse ? foregroundColor : Colors.transparent),
          borderRadius: ZetaRadius.full,
        ),
        child: Center(
          child: Container(
            width: sizePixels,
            height: sizePixels,
            decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(ZetaSpacing.large)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ZetaSpacing.large),
              clipBehavior: Clip.hardEdge,
              child: size == ZetaWidgetSize.small ? null : _buildContent(foregroundColor),
            ),
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
          child: Icon(
            icon ?? ZetaIcons.star_round,
            color: foregroundColor,
            size: iconSize,
          ),
        );
      case ZetaIndicatorType.notification:
        return Center(
          child: Text(
            value.formatMaxChars(),
            style: ZetaTextStyles.labelIndicator.copyWith(
              color: foregroundColor,
              fontSize: size == ZetaWidgetSize.large ? null : 11,
            ), // TODO(thelukwalton): Awaiting updated design.
          ),
        );
    }
  }

  /// Returns the size of [ZetaWidgetSize] in pixels.
  double _getSizePixels(ZetaWidgetSize size, ZetaIndicatorType type) {
    switch (size) {
      case ZetaWidgetSize.large:
        return ZetaSpacing.large;
      case ZetaWidgetSize.medium:
        return type == ZetaIndicatorType.icon ? ZetaSpacing.medium : ZetaSpacingBase.x3_5;
      case ZetaWidgetSize.small:
        return ZetaSpacing.small;
    }
  }

  double _getIconSize(ZetaWidgetSize size) {
    if (size == ZetaWidgetSize.large) return ZetaSpacing.medium;
    return ZetaSpacing.small;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaIndicatorType>('type', type))
      ..add(DiagnosticsProperty<ZetaWidgetSize>('size', size))
      ..add(DiagnosticsProperty<int?>('value', value))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('inverse', inverse))
      ..add(ColorProperty('color', color))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
