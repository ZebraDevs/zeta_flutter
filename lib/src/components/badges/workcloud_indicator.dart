import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Indicator Type
enum ZetaWorkcloudIndicatorType {
  ///sets the color to red
  urgent,

  ///sets the color to orange
  high,

  ///sets the color to blue
  medium,

  ///sets the color to green
  low,

  ///sets the color to custom color
  custom
}

///Zeta Workcloud Indicator
class ZetaWorkcloudIndicator extends StatelessWidget {
  ///Constructs [ZetaWorkcloudIndicator]
  const ZetaWorkcloudIndicator({
    this.isStatusBadge = true,
    this.priorityType,
    this.prioritySize = ZetaWidgetSize.small,
    this.label,
    this.index,
    this.customColors,
    super.key,
  });

  ///Constructor for [ZetaWorkcloudIndicator] for type 'status'
  factory ZetaWorkcloudIndicator.status({
    required String label,
  }) =>
      ZetaWorkcloudIndicator(label: label);

  ///Constructor for [ZetaWorkcloudIndicator] for type 'priority pill'
  factory ZetaWorkcloudIndicator.priorityPill({
    required String index,
    ZetaWorkcloudIndicatorType priorityType = ZetaWorkcloudIndicatorType.urgent,
    ZetaWidgetSize prioritySize = ZetaWidgetSize.small,
    ZetaWidgetColor? customColors,
    String? label,
  }) =>
      ZetaWorkcloudIndicator(
        isStatusBadge: false,
        priorityType: priorityType,
        prioritySize: prioritySize,
        label: label,
        index: index,
        customColors: customColors,
      );

  ///Indicates if it is status badge or priority pill
  ///
  /// Defaults to status
  final bool isStatusBadge;

  ///The type of priority for Priority Pill
  ///
  ///[ZetaWorkcloudIndicator.priorityPill] defaults to 'urgent'
  final ZetaWorkcloudIndicatorType? priorityType;

  ///The size of Priority Pill
  ///
  ///defaults to 'small'
  final ZetaWidgetSize prioritySize;

  ///Label
  final String? label;

  ///Index for priority pill
  ///
  ///required for [ZetaWorkcloudIndicator.priorityPill]
  final String? index;

  ///Custom colors for priority pill
  final ZetaWidgetColor? customColors;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final themeMode = Zeta.of(context).themeMode;
    return isStatusBadge ? _buildStatusBadge(theme) : _buildPriorityPill(theme, themeMode);
  }

  ///Status Badge
  Widget _buildStatusBadge(Zeta theme) {
    final labelContent = label ?? '';
    return Container(
      height: Dimensions.x6,
      constraints: const BoxConstraints(minWidth: 51),
      decoration: _statusBadgeDecoration(theme),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimensions.x2,
            Dimensions.x1,
            Dimensions.x2,
            Dimensions.x1,
          ),
          child: Text(labelContent, style: ZetaText.zetaBodyXSmall),
        ),
      ),
    );
  }

  BoxDecoration _statusBadgeDecoration(Zeta theme) {
    return BoxDecoration(
      color: theme.colors.surfaceDisabled,
      borderRadius: BorderRadius.circular(6),
    );
  }

  ///Priority Pill
  Widget _buildPriorityPill(Zeta theme, ThemeMode themeMode) {
    final colors = _ZetaWorkcloudIndicatorStyle.getColor(
      priorityType ?? ZetaWorkcloudIndicatorType.urgent,
      theme.colors,
      themeMode,
      customColors: customColors,
    );
    final size = _ZetaWorkcloudIndicatorStyle.getSize(prioritySize);
    final padding = _ZetaWorkcloudIndicatorStyle.getEdgeInsets(prioritySize);
    final textStyle = _ZetaWorkcloudIndicatorStyle.getTextStyle(prioritySize, theme);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.l),
        color: colors.foregroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPriorityPillIndex(size, colors, textStyle, theme),
          if (prioritySize != ZetaWidgetSize.small) ...[
            _buildPriorityPillLabel(size, textStyle, padding),
          ],
        ],
      ),
    );
  }

  Widget _buildPriorityPillIndex(
    double size,
    ZetaWidgetColor colors,
    TextStyle textStyle,
    Zeta theme,
  ) {
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.backgroundColor,
      ),
      child: Center(
        child: Text(
          index ?? '',
          style: textStyle.apply(color: theme.colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildPriorityPillLabel(
    double size,
    TextStyle textStyle,
    EdgeInsets padding,
  ) {
    return Container(
      height: size,
      constraints: const BoxConstraints(minWidth: 34),
      child: Padding(
        padding: padding,
        child: Text(
          label ?? '',
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isStatusBadge', isStatusBadge))
      ..add(
        EnumProperty<ZetaWorkcloudIndicatorType?>('priorityType', priorityType),
      )
      ..add(
        EnumProperty<ZetaWidgetSize?>('prioritySize', prioritySize),
      )
      ..add(StringProperty('label', label))
      ..add(StringProperty('index', index))
      ..add(
        DiagnosticsProperty<ZetaWidgetColor?>('customColors', customColors),
      );
  }
}

class _ZetaIndicatorConstants {
  static const double mediumSize = 22;
  static const double largeSize = 24;
  static const EdgeInsets largePadding = EdgeInsets.fromLTRB(8, 0, 8, 1);
  static const EdgeInsets mediumPadding = EdgeInsets.fromLTRB(8, 2, 8, 2);
}

class _ZetaWorkcloudIndicatorStyle {
  static ZetaWidgetColor getColor(
    ZetaWorkcloudIndicatorType type,
    ZetaColors zetaColors,
    ThemeMode themeMode, {
    ZetaWidgetColor? customColors,
  }) {
    final isDarkTheme = themeMode == ThemeMode.dark;
    switch (type) {
      case ZetaWorkcloudIndicatorType.urgent:
        return ZetaWidgetColor(
          backgroundColor: isDarkTheme ? ZetaColorBase.red.shade70 : ZetaColorBase.red.shade60,
          foregroundColor: isDarkTheme ? ZetaColorBase.red.shade90 : ZetaColorBase.red.shade20,
        );
      case ZetaWorkcloudIndicatorType.high:
        return ZetaWidgetColor(
          backgroundColor: isDarkTheme ? ZetaColorBase.orange.shade70 : ZetaColorBase.orange.shade40,
          foregroundColor: isDarkTheme ? ZetaColorBase.orange.shade90 : ZetaColorBase.orange.shade10,
        );
      case ZetaWorkcloudIndicatorType.medium:
        return ZetaWidgetColor(
          backgroundColor: isDarkTheme ? ZetaColorBase.blue.shade70 : ZetaColorBase.blue,
          foregroundColor: isDarkTheme ? ZetaColorBase.blue.shade90 : ZetaColorBase.blue.shade20,
        );
      case ZetaWorkcloudIndicatorType.low:
        return ZetaWidgetColor(
          backgroundColor: isDarkTheme ? ZetaColorBase.green.shade70 : ZetaColorBase.green.shade60,
          foregroundColor: isDarkTheme ? ZetaColorBase.green.shade90 : ZetaColorBase.green.shade20,
        );
      case ZetaWorkcloudIndicatorType.custom:
        return customColors ??
            ZetaWidgetColor(
              backgroundColor: zetaColors.surfaceDisabled,
              foregroundColor: zetaColors.surfacePrimary,
            );
    }
  }

  static double getSize(ZetaWidgetSize size) {
    if (size == ZetaWidgetSize.large) {
      return _ZetaIndicatorConstants.largeSize;
    }
    return _ZetaIndicatorConstants.mediumSize;
  }

  static TextStyle getTextStyle(ZetaWidgetSize size, Zeta theme) {
    if (size == ZetaWidgetSize.large) return ZetaText.zetaBodyMedium;
    return ZetaText.zetaBodySmall;
  }

  static EdgeInsets getEdgeInsets(ZetaWidgetSize size) {
    if (size == ZetaWidgetSize.large) {
      return _ZetaIndicatorConstants.largePadding;
    }
    return _ZetaIndicatorConstants.mediumPadding;
  }
}
