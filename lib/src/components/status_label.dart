import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../zeta_flutter.dart';

///Zeta Status Label
class ZetaStatusLabel extends StatelessWidget {
  ///Constructs [ZetaStatusLabel].
  const ZetaStatusLabel({
    required this.label,
    this.severity = WidgetSeverity.neutral,
    this.isDefaultIcon = true,
    this.customIcon,
    this.borderType = BorderType.sharp,
    this.labelSize = const Size(67, 24),
    this.borderWidth = 1,
    this.customColors,
    this.customIconSize = 20.0,
    super.key,
  });

  ///The type of border to display
  ///
  /// Defaults to sharp
  final BorderType borderType;

  ///Width of the label border
  ///
  /// Defaults to 1
  final double borderWidth;

  ///Size of the label
  final Size labelSize;

  ///Widget Severity
  ///
  /// Defaults to "neutral"
  final WidgetSeverity severity;

  ///Label
  final String label;

  ///Colors for the label
  final ZetaWidgetColor? customColors;

  ///Whether the icon is the default icon
  ///
  ///Defaults to true
  final bool isDefaultIcon;

  ///Custom icon
  final IconData? customIcon;

  ///The size of the custom icon
  ///
  ///Defaults to 20
  final double customIconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = _getColors(theme);
    return Container(
      height: labelSize.height,
      decoration: _buildDecoration(colors),
      constraints: BoxConstraints(minWidth: labelSize.width),
      child: _buildContent(colors, theme),
    );
  }

  BoxDecoration _buildDecoration(ZetaWidgetColor colors) {
    return BoxDecoration(
      color: colors.backgroundColor,
      border: Border.all(color: colors.foregroundColor, width: borderWidth),
      borderRadius: BorderRadius.circular(borderType == BorderType.rounded ? 10.0 : 0.0),
    );
  }

  Widget _buildContent(ZetaWidgetColor colors, Zeta theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIcon(colors),
          const SizedBox(width: Dimensions.xs),
          Flexible(
            child: Text(
              label,
              style: ZetaText.zetaTitleSmall,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Icon _buildIcon(ZetaWidgetColor colors) {
    final size = isDefaultIcon ? Dimensions.x2 : customIconSize;
    return Icon(
      size: size,
      isDefaultIcon ? Icons.circle : (customIcon ?? Icons.star),
      color: colors.foregroundColor,
    );
  }

  ZetaWidgetColor _getColors(Zeta theme) {
    final defaultColorScheme = ZetaWidgetColor(
      backgroundColor: theme.colors.surfaceDisabled,
      foregroundColor: theme.colors.borderDefault,
    );
    switch (severity) {
      case WidgetSeverity.neutral:
        return defaultColorScheme;
      case WidgetSeverity.info:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.purple.shade10,
          foregroundColor: theme.colors.purple.shade50,
        );
      case WidgetSeverity.positive:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.green.shade10,
          foregroundColor: theme.colors.green.shade50,
        );
      case WidgetSeverity.warning:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.orange.shade10,
          foregroundColor: theme.colors.orange.shade50,
        );
      case WidgetSeverity.negative:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.red.shade10,
          foregroundColor: theme.colors.red.shade50,
        );
      case WidgetSeverity.custom:
        return customColors ?? defaultColorScheme;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(DoubleProperty('borderWidth', borderWidth))
      ..add(DiagnosticsProperty<Size>('labelSize', labelSize))
      ..add(EnumProperty<WidgetSeverity>('severity', severity))
      ..add(StringProperty('label', label))
      ..add(
        DiagnosticsProperty<ZetaWidgetColor?>(
          'customColors',
          customColors,
        ),
      )
      ..add(DiagnosticsProperty<bool>('isDefaultIcon', isDefaultIcon))
      ..add(DiagnosticsProperty<IconData?>('customIcon', customIcon))
      ..add(DoubleProperty('customIconSize', customIconSize));
  }
}
