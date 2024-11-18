import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// [ZetaIndicator] type.
enum ZetaIndicatorType {
  /// Shows an icon on [ZetaIndicator]. Defaults to [ZetaIcons.star].
  icon,

  /// Shows a number on [ZetaIndicator] from provided [ZetaIndicator.value].
  notification,
}

/// Indicators are used to show the status of a user or any messages/notifications they might have.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=22000-10045&mode=design&t=6mhOcUUr3tgxxFdd-0
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/badge/indicators
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

  /// Indicator icon, default: `ZetaIcons.star`.
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
    String? semanticLabel,
  }) {
    return ZetaIndicator(
      key: key ?? this.key,
      type: type ?? this.type,
      size: size ?? this.size,
      icon: icon ?? this.icon,
      value: value ?? this.value,
      inverse: inverse ?? this.inverse,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final Color backgroundColor = (type == ZetaIndicatorType.icon ? zetaColors.blue : zetaColors.surfaceNegative);
    final Color foregroundColor = backgroundColor.onColor;
    final sizePixels = _getSizePixels(size, type, context);

    return Semantics(
      label: semanticLabel,
      container: true,
      child: Container(
        width: sizePixels + Zeta.of(context).spacing.minimum,
        height: sizePixels + Zeta.of(context).spacing.minimum,
        decoration: type == ZetaIndicatorType.icon
            ? BoxDecoration(
                border: Border.all(
                  width: ZetaBorders.medium,
                  color: Zeta.of(context).colors.borderSubtle,
                ),
                color: (inverse ? foregroundColor : Colors.transparent),
                borderRadius: Zeta.of(context).radius.full,
              )
            : null,
        child: Center(
          child: Container(
            width: sizePixels,
            height: sizePixels,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(Zeta.of(context).spacing.large),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Zeta.of(context).spacing.large),
              clipBehavior: Clip.hardEdge,
              child: size == ZetaWidgetSize.small ? null : _buildContent(foregroundColor, context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Color foregroundColor, BuildContext context) {
    switch (type) {
      case ZetaIndicatorType.icon:
        final iconSize = _getIconSize(size, context);
        return Center(
          child: ZetaIcon(
            icon ?? ZetaIcons.star,
            color: foregroundColor,
            size: iconSize,
          ),
        );
      case ZetaIndicatorType.notification:
        return Center(
          child: ExcludeSemantics(
            excluding: semanticLabel != null,
            child: Text(
              value.formatMaxChars(),
              style: ZetaTextStyles.labelIndicator.copyWith(
                color: foregroundColor,
                fontSize: size == ZetaWidgetSize.large ? 12 : 11,
                height: size == ZetaWidgetSize.large ? 1 : (0.5 / 16),
              ),
            ),
          ),
        );
    }
  }

  /// Returns the size of [ZetaWidgetSize] in pixels.
  double _getSizePixels(ZetaWidgetSize size, ZetaIndicatorType type, BuildContext context) {
    switch (size) {
      case ZetaWidgetSize.large:
        return Zeta.of(context).spacing.xl;
      case ZetaWidgetSize.medium:
        return Zeta.of(context).spacing.medium;
      case ZetaWidgetSize.small:
        return Zeta.of(context).spacing.small;
    }
  }

  double _getIconSize(ZetaWidgetSize size, BuildContext context) {
    if (size == ZetaWidgetSize.large) return Zeta.of(context).spacing.medium;
    return Zeta.of(context).spacing.small;
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
