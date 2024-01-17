import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

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
    this.rounded = true,
    this.value,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.inverseBorder = false,
  }) {
    _sizePixels = getSizePixels(size, type);
  }

  /// Constructor for [ZetaIndicator] of type `icon`
  factory ZetaIndicator.icon({
    ZetaIndicatorSize size = ZetaIndicatorSize.large,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    bool inverseBorder = false,
    Icon? icon,
    bool rounded = true,
  }) =>
      ZetaIndicator(
        type: ZetaIndicatorType.icon,
        size: size,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderColor: borderColor,
        inverseBorder: inverseBorder,
        icon: icon,
        rounded: rounded,
      );

  /// Constructor for [ZetaIndicator] of type `icon`
  factory ZetaIndicator.notification({
    ZetaIndicatorSize size = ZetaIndicatorSize.large,
    Color? backgroundColor,
    Color? foregroundColor,
    Color? borderColor,
    bool inverseBorder = false,
    int? value,
  }) =>
      ZetaIndicator(
        type: ZetaIndicatorType.notification,
        size: size,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        borderColor: borderColor,
        inverseBorder: inverseBorder,
        value: value,
      );

  /// The type of the [ZetaIndicator] - icon or notification
  final ZetaIndicatorType type;

  /// The size of the [ZetaIndicator]. Default is [ZetaIndicatorSize.large]
  final ZetaIndicatorSize size;

  /// Background color.
  /// Default is blue for [ZetaIndicatorType.icon]
  /// and negative for [ZetaIndicatorType.notification].
  final Color? backgroundColor;

  /// Foreground color. Default is white.
  final Color? foregroundColor;

  /// Border color.
  /// Default is surfacePrimary or textDefault
  /// depending on theme mode (light or dark) and [inverseBorder].
  final Color? borderColor;

  /// Inverse the border color. Not considered, if [borderColor] is provided.
  final bool inverseBorder;

  /// Indicator icon, default: `ZetaIcons.star_round`
  final Icon? icon;

  /// Determines if the default icon should be rounded or sharp:
  /// `ZetaIcons.star_round` or `ZetaIcons.star_sharp`.
  /// Default is `true`.
  /// Not taken into account, if [icon] is provided.
  final bool rounded;

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
        color: borderColor ?? (inverseBorder ? zetaColors.textDefault : zetaColors.surfacePrimary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Container(
          width: _sizePixels,
          height: _sizePixels,
          decoration: BoxDecoration(
            color: backgroundColor ?? (type == ZetaIndicatorType.icon ? zetaColors.blue : zetaColors.negative),
            borderRadius: BorderRadius.circular(16),
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
                    rounded: rounded,
                    value: value,
                    foregroundColor: foregroundColor,
                  ),
          ),
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
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<Color?>('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty<Color?>('foregroundColor', foregroundColor))
      ..add(DiagnosticsProperty<Color?>('borderColor', borderColor))
      ..add(DiagnosticsProperty<bool>('inverseBorder', inverseBorder));
  }
}

class _InnerContent extends StatelessWidget {
  const _InnerContent({
    required this.type,
    required this.size,
    required this.sizePixels,
    this.icon,
    this.rounded = true,
    this.value,
    this.foregroundColor,
  });

  final ZetaIndicatorType type;
  final ZetaIndicatorSize size;
  final double sizePixels;
  final Icon? icon;
  final bool rounded;
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
            child: icon ?? Icon(rounded ? ZetaIcons.star_round : ZetaIcons.star_sharp),
          ),
        );
      case ZetaIndicatorType.notification:
        final strVal = value == null ? '' : value!.abs().toString();

        return Center(
          child: Text(
            strVal.length > 1 ? '9+' : strVal,
            textAlign: strVal.length == 1 ? TextAlign.center : TextAlign.right,
            style: size == ZetaIndicatorSize.large ? ZetaTextStyles.labelIndicator : ZetaTextStyles.labelTiny,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaIndicatorType>('type', type))
      ..add(DiagnosticsProperty<ZetaIndicatorSize>('size', size))
      ..add(DiagnosticsProperty<double>('sizePixels', sizePixels))
      ..add(DiagnosticsProperty<int?>('value', value))
      ..add(DiagnosticsProperty<Icon?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<Color?>('foregroundColor', foregroundColor));
  }
}
