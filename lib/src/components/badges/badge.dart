import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta Badge
class ZetaBadge extends StatelessWidget {
  ///Constructs [ZetaBadge]
  const ZetaBadge({
    required this.label,
    this.severity = WidgetSeverity.info,
    this.borderType = BorderType.rounded,
    this.badgeSize = const Size(Dimensions.x9, Dimensions.x5),
    this.customColor,
    super.key,
  });

  ///The shape of the badge
  ///
  /// Defaults to rounded
  final BorderType borderType;

  ///Indicates the severity of the badge
  ///If set to "custom", [customColor] should be picked
  ///Defaults to "info"
  final WidgetSeverity severity;

  ///Label of the badge
  final String label;

  ///The size of the badge
  final Size badgeSize;

  ///Custom color of the badge
  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    return Container(
      height: badgeSize.height,
      constraints: BoxConstraints(minWidth: badgeSize.width),
      decoration: _buildBadgeDecoration(theme),
      child: Center(
        child: _buildBadgeContent(theme),
      ),
    );
  }

  BoxDecoration _buildBadgeDecoration(Zeta theme) {
    return BoxDecoration(
      color: _badgeBackgroundColor(theme),
      borderRadius: BorderRadius.circular(
        borderType == BorderType.rounded ? Dimensions.x1 : 0.0,
      ),
    );
  }

  Widget _buildBadgeContent(Zeta theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
            child: Text(
              label,
              style: ZetaText.zetaLabelSmall.apply(color: _badgeForegroundColor(theme)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  Color _badgeBackgroundColor(Zeta theme) {
    switch (severity) {
      case WidgetSeverity.info:
        return theme.colors.purple;
      case WidgetSeverity.positive:
        return theme.colors.green;
      case WidgetSeverity.warning:
        return theme.colors.orange;
      case WidgetSeverity.negative:
        return theme.colors.red;
      case WidgetSeverity.neutral:
        return theme.colors.borderDisabled;
      case WidgetSeverity.custom:
        return customColor ?? theme.colors.surfaceDisabled;
    }
  }

  Color _badgeForegroundColor(Zeta theme) {
    switch (severity) {
      case WidgetSeverity.info:
        return theme.colors.textDefault;
      case WidgetSeverity.positive:
        return theme.colors.black;
      case WidgetSeverity.warning:
        return theme.colors.textInverse;
      case WidgetSeverity.negative:
        return theme.colors.textDefault;
      case WidgetSeverity.neutral:
        return theme.colors.white;
      case WidgetSeverity.custom:
        return theme.colors.white;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(EnumProperty<WidgetSeverity>('severity', severity))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<Size>('badgeSize', badgeSize))
      ..add(ColorProperty('customColor', customColor));
  }
}
