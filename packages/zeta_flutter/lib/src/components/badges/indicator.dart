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
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=22000-10045&mode=design&t=6mhOcUUr3tgxxFdd-0
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/badges/zetaindicator/notification-indicator
class ZetaIndicator extends ZetaStatelessWidget {
  /// Constructor for [ZetaIndicator].
  const ZetaIndicator({
    super.key,
    super.rounded,
    this.type = ZetaIndicatorType.notification,
    this.size = ZetaWidgetSize.large,
    this.icon,
    this.value,
    @Deprecated('No longer in use. Will be removed in future versions.') this.inverse = false,
    this.color,
    this.semanticLabel,
  });

  /// Constructor for [ZetaIndicator] of type [ZetaIndicatorType.icon].
  const ZetaIndicator.icon({
    super.key,
    super.rounded,
    this.size = ZetaWidgetSize.large,
    @Deprecated('No longer in use. Will be removed in future versions.') this.inverse = false,
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
    @Deprecated('No longer in use. Will be removed in future versions.') this.inverse = false,
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
  @Deprecated('No longer in use. Will be removed in future versions.')
  // Ignored due to deprecation, but kept for backward compatibility.
  // ignore: diagnostic_describe_all_properties
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
    @Deprecated('No longer in use. Will be removed in future versions.') bool? inverse,
    Key? key,
    String? semanticLabel,
  }) {
    return ZetaIndicator(
      key: key ?? this.key,
      type: type ?? this.type,
      size: size ?? this.size,
      icon: icon ?? this.icon,
      value: value ?? this.value,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final Color backgroundColor = (type == ZetaIndicatorType.icon ? zetaColors.mainPrimary : zetaColors.mainNegative);
    final Color foregroundColor = zetaColors.stateDefaultEnabled;
    final effectiveSize = value != null && value! > 9
        ? ZetaWidgetSize.large
        : value != null
            ? ZetaWidgetSize.medium
            : size;
    final isPill = type == ZetaIndicatorType.notification && (effectiveSize == ZetaWidgetSize.large);
    final sizePixels = _getSizePixels(effectiveSize, type, context);
    final borderWidth = isPill ? ZetaBorders.small : ZetaBorders.medium;
    final width = sizePixels.width + (2 * borderWidth);
    final height = sizePixels.height + (2 * borderWidth);
    final borderColor = type == ZetaIndicatorType.icon ? zetaColors.mainInverse : zetaColors.borderPure;
    return Semantics(
      label: semanticLabel,
      container: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(isPill ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.full),
          border: Border.all(
            width: borderWidth,
            color: borderColor,
          ),
        ),
        child: effectiveSize == ZetaWidgetSize.small ? null : _buildContent(foregroundColor, context, isPill),
      ),
    );
  }

  Widget _buildContent(Color foregroundColor, BuildContext context, bool isPill) {
    switch (type) {
      case ZetaIndicatorType.icon:
        final iconSize = _getIconSize(size, context);
        return Center(
          child: Icon(
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
              value.formatMaxChars(2),
              style: Zeta.of(context).textStyles.labelIndicator.copyWith(
                    color: foregroundColor,
                    height: isPill ? null : 0.5,
                  ),
            ),
          ),
        );
    }
  }

  /// Returns the size of [ZetaWidgetSize] in pixels.
  Size _getSizePixels(ZetaWidgetSize size, ZetaIndicatorType type, BuildContext context) {
    final spacing = Zeta.of(context).spacing;
    if (type == ZetaIndicatorType.notification && size == ZetaWidgetSize.large) {
      return Size(spacing.xl_3 - (2 * ZetaBorders.small), spacing.large - (2 * ZetaBorders.small));
    }
    switch (size) {
      case ZetaWidgetSize.large:
        return Size.square(spacing.xl);
      case ZetaWidgetSize.medium:
        return Size.square(spacing.medium);
      case ZetaWidgetSize.small:
        return Size.square(spacing.small);
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
      ..add(ColorProperty('color', color))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}
