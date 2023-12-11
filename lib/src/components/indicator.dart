import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

/// [ZetaIndicator] type
enum ZetaIndicatorType {
  /// [icon] shows an icon
  icon,

  /// [notification] shows a number provided with the `value` parameter
  notification,
}

/// [ZetaIndicator] size
enum ZetaIndicatorSize {
  /// [large] 16 pixels
  large,

  /// [medium] 12 pixels
  medium,

  /// [small] 8 pixels
  small,
}

/// ZetaIndicator component
class ZetaIndicator extends StatelessWidget {
  /// Constructor for [ZetaIndicator]
  ZetaIndicator({
    super.key,
    required this.type,
    this.size = ZetaIndicatorSize.large,
    this.icon,
    this.sharp = false,
    this.value,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
  }) {
    _sizePixels = getSizePixels(size, type);
  }

  /// Constructor for [ZetaIndicator] of type `icon`
  factory ZetaIndicator.icon({
    ZetaIndicatorSize size = ZetaIndicatorSize.large,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    Icon? icon,
    bool sharp = false,
  }) =>
      ZetaIndicator(
        type: ZetaIndicatorType.icon,
        size: size,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderColor: borderColor,
        icon: icon,
        sharp: sharp,
      );

  /// Constructor for [ZetaIndicator] of type `icon`
  factory ZetaIndicator.notification({
    ZetaIndicatorSize size = ZetaIndicatorSize.large,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    int? value,
  }) =>
      ZetaIndicator(
        type: ZetaIndicatorType.notification,
        size: size,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderColor: borderColor,
        value: value,
      );

  /// The type of the [ZetaIndicator] - icon or notification
  final ZetaIndicatorType type;

  /// The size of the [ZetaIndicator]
  final ZetaIndicatorSize size;

  /// Background color
  final Color? backgroundColor;

  /// Foreground color
  final Color? foregroundColor;

  /// Border color
  final Color? borderColor;

  /// Indicator icon, default: `ZetaIcons.star_round`
  final Icon? icon;

  /// Determines if the default icon should be sharp: `ZetaIcons.star_sharp`.
  /// Default is `false`.
  /// Not taken into account, if [icon] is provided.
  final bool sharp;

  /// Value for the type `notification`
  final int? value;

  late final double _sizePixels;

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return Container(
      width: _sizePixels + 4,
      height: _sizePixels + 4,
      decoration: BoxDecoration(
        color: backgroundColor ?? (type == ZetaIndicatorType.icon ? zetaColors.blue : zetaColors.negative),
        border: Border.all(
          color: borderColor ?? zetaColors.surfacePrimary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.hardEdge,
        child: size == ZetaIndicatorSize.small
            ? null
            : _InnerContent(
                type: type,
                size: size,
                sizePixels: _sizePixels,
                icon: icon,
                sharp: sharp,
                value: value,
                foregroundColor: foregroundColor,
              ),
      ),
    );
  }

  /// Returns the size of [ZetaIndicatorSize] in pixels
  static double getSizePixels(ZetaIndicatorSize size, ZetaIndicatorType type) {
    switch (size) {
      case ZetaIndicatorSize.large:
        return 16;
      case ZetaIndicatorSize.medium:
        return type == ZetaIndicatorType.icon ? 12 : 14;
      case ZetaIndicatorSize.small:
        return 8;
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
      ..add(DiagnosticsProperty<bool>('sharp', sharp))
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<Color?>('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty<Color?>('borderColor', borderColor));
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({
    required this.type,
    required this.size,
    required this.sizePixels,
    this.icon,
    this.sharp = false,
    this.value,
    this.foregroundColor,
  });

  final ZetaIndicatorType type;
  final ZetaIndicatorSize size;
  final double sizePixels;
  final Icon? icon;
  final bool sharp;
  final int? value;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final defaultColor = Zeta.of(context).colors.white;
    switch (type) {
      case ZetaIndicatorType.icon:
        final iconSize = _getIconSize(size);
        return Center(
          child: IconTheme(
            data: IconThemeData(
              color: foregroundColor ?? defaultColor,
              size: iconSize,
            ),
            child: icon ?? Icon(sharp ? ZetaIcons.star_sharp : ZetaIcons.star_round),
          ),
        );
      case ZetaIndicatorType.notification:
        final strVal = value == null ? '' : value!.abs().toString();
        final fontSize = _getFontSize(size);
        return Center(
          child: Text(
            strVal.length > 1 ? '9+' : strVal,
            textAlign: strVal.length == 1 ? null : TextAlign.right,
            style: TextStyle(
              fontSize: fontSize,
              height: fontSize * .067,
              letterSpacing: -0.5,
              color: foregroundColor ?? defaultColor,
            ),
          ),
        );
    }
  }

  double _getIconSize(ZetaIndicatorSize size) {
    switch (size) {
      case ZetaIndicatorSize.large:
        return 11;
      case ZetaIndicatorSize.medium:
        return 8;
      case ZetaIndicatorSize.small:
        return 1;
    }
  }

  double _getFontSize(ZetaIndicatorSize size) {
    switch (size) {
      case ZetaIndicatorSize.large:
        return 12;
      case ZetaIndicatorSize.medium:
        return 11;
      case ZetaIndicatorSize.small:
        return 1;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaIndicatorType>('type', type))
      ..add(DiagnosticsProperty<ZetaIndicatorSize>('size', size))
      ..add(DiagnosticsProperty<double>('sizePixels', sizePixels))
      ..add(DiagnosticsProperty<int?>('value', value))
      ..add(DiagnosticsProperty<Icon?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('sharp', sharp))
      ..add(DiagnosticsProperty<Color?>('foregroundColor', foregroundColor));
  }
}
