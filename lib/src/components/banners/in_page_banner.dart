import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Zeta In Page Banner
class ZetaInPageBanner extends StatelessWidget {
  ///Constructs [ZetaInPageBanner]
  const ZetaInPageBanner({
    super.key,
    required this.content,
    this.rounded = true,
    this.severity = ZetaWidgetStatus.info,
    this.showIconClose = true,
    this.onClose,
    this.title,
    this.customIcon,
    this.actions = const [],
  });

  ///The content of the banner
  final Widget content;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  ///Determines the color of the banner
  ///Defaults to 'neutral'
  final ZetaWidgetStatus severity;

  ///Determines if the banner has icon for closing
  ///Defaults to true
  final bool showIconClose;

  ///Title of the banner
  final String? title;

  ///Custom icon
  final IconData? customIcon;

  /// Action buttons to show at the bottom of the banner.
  final List<ZetaButton> actions;

  ///Called when the button 'Close' is tapped.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final colors = _getColors(theme);
    final hasTitle = title != null;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.backgroundColor,
        border: Border.all(color: colors.foregroundColor),
        borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 12, start: 10),
              child: Icon(
                severity.icon(rounded: rounded),
                size: ZetaSpacing.x5,
                color: severity == ZetaWidgetStatus.neutral ? theme.colors.textDefault : colors.foregroundColor,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  if (hasTitle)
                    Text(
                      title!,
                      style: ZetaTextStyles.titleSmall,
                    ).paddingBottom(ZetaSpacing.xxs),
                  DefaultTextStyle(
                    style: ZetaTextStyles.bodyMedium.apply(color: theme.colors.textDefault),
                    child: content,
                  ),
                  if (actions.isNotEmpty)
                    Row(
                      children: actions
                          .map((e) => e.copyWith(size: ZetaWidgetSize.medium, type: ZetaButtonType.outlineSubtle))
                          .divide(const SizedBox.square(dimension: ZetaSpacing.x2))
                          .toList(),
                    ).paddingTop(ZetaSpacing.x4),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            if (showIconClose)
              IconButton(
                onPressed: onClose,
                icon: Icon(
                  !rounded ? ZetaIcons.close_sharp : ZetaIcons.close_round,
                  size: ZetaSpacing.x5,
                ),
              ),
          ].divide(const SizedBox.square(dimension: ZetaSpacing.x2)).toList(),
        ),
      ),
    );
  }

  ZetaWidgetColor _getColors(Zeta theme) {
    final defaultColorScheme = ZetaWidgetColor(
      backgroundColor: theme.colors.surfacePrimary,
      foregroundColor: theme.colors.borderDefault,
    );
    switch (severity) {
      case ZetaWidgetStatus.neutral:
        return defaultColorScheme;
      case ZetaWidgetStatus.info:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.info.surface,
          foregroundColor: theme.colors.info.border,
        );
      case ZetaWidgetStatus.positive:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.positive.surface,
          foregroundColor: theme.colors.positive.border,
        );
      case ZetaWidgetStatus.warning:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.warning.surface.lighten(6),
          foregroundColor: theme.colors.warning.border,
        );
      case ZetaWidgetStatus.negative:
        return ZetaWidgetColor(
          backgroundColor: theme.colors.negative.surface,
          foregroundColor: theme.colors.negative.border,
        );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        ObjectFlagProperty<VoidCallback>.has(
          'onCloseFunction',
          onClose,
        ),
      )
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaWidgetStatus>('severity', severity))
      ..add(DiagnosticsProperty<bool>('showIconClose', showIconClose))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<IconData?>('customIcon', customIcon));
  }
}

extension on ZetaWidgetStatus {
  IconData icon({required bool rounded}) {
    switch (this) {
      case ZetaWidgetStatus.positive:
        return rounded ? ZetaIcons.check_circle_round : ZetaIcons.check_circle_sharp;
      case ZetaWidgetStatus.warning:
        return rounded ? ZetaIcons.warning_round : ZetaIcons.warning_sharp;
      case ZetaWidgetStatus.negative:
        return rounded ? ZetaIcons.error_round : ZetaIcons.error_sharp;
      case ZetaWidgetStatus.neutral:
      case ZetaWidgetStatus.info:
        return rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp;
    }
  }
}
