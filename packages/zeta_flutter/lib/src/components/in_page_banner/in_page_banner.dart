import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// In page banners display an important, succinct message, and may provide actions for users to address. Banners should be displayed at the top of the screen,below a top app bar. Only one banner should be shown at a time.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21156-20085&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/in-page-banner/zetainpagebanner/in-page-banner
class ZetaInPageBanner extends ZetaStatelessWidget {
  /// Constructs [ZetaInPageBanner].
  const ZetaInPageBanner({
    super.key,
    required this.content,
    super.rounded,
    this.status = ZetaWidgetStatus.info,
    this.onClose,
    this.title,
    this.customIcon,
    this.actions = const [],
  });

  /// The content of the banner. Typically [Text].
  final Widget content;

  /// Determines the color of the banner.
  ///
  /// Defaults to [ZetaWidgetStatus.info].
  final ZetaWidgetStatus status;

  /// Title of the banner.
  final String? title;

  /// Leading icon on top left of banner.
  final IconData? customIcon;

  /// Action buttons to show at the bottom of the banner.
  final List<ZetaButton> actions;

  /// Called when the button 'Close' is tapped.
  ///
  /// If null, close icon will not appear.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Zeta.of(context);
    final hasTitle = title != null;
    final rounded = context.rounded;
    final Color backgroundColor = status.surfaceSubtleInPageBannerColor(context);
    final Color borderColor = status.borderColor(context);
    final Color iconColor = status.mainColor(context);

    return ZetaRoundedScope(
      rounded: rounded,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.all(rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
        ),
        padding: EdgeInsetsDirectional.only(
          bottom: Zeta.of(context).spacing.medium,
          start: Zeta.of(context).spacing.medium,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: Zeta.of(context).spacing.medium,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      customIcon ?? status.icon(context),
                      size: Zeta.of(context).spacing.xl,
                      color: iconColor,
                    ),
                    SizedBox(width: Zeta.of(context).spacing.small),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasTitle)
                            Text(
                              title!,
                              style: Zeta.of(context).textStyles.labelLarge.copyWith(height: 20 / 16),
                            ).paddingBottom(Zeta.of(context).spacing.minimum),
                          DefaultTextStyle(
                            style: Zeta.of(context).textStyles.bodySmall.apply(color: theme.colors.mainDefault),
                            child: content,
                          ),
                          if (actions.isNotEmpty)
                            Row(
                              children: actions
                                  .map(
                                    (e) => e.copyWith(size: ZetaWidgetSize.medium, type: ZetaButtonType.outlineSubtle),
                                  )
                                  .divide(SizedBox.square(dimension: Zeta.of(context).spacing.small))
                                  .toList(),
                            ).paddingTop(Zeta.of(context).spacing.large),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (onClose != null)
              IconButton(
                onPressed: onClose,
                icon: Icon(
                  context.rounded ? ZetaIcons.close_round : ZetaIcons.close_sharp,
                  size: Zeta.of(context).spacing.xl,
                ),
              ),
          ].divide(SizedBox.square(dimension: Zeta.of(context).spacing.small)).toList(),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onClose', onClose))
      ..add(EnumProperty<ZetaWidgetStatus>('status', status))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<IconData?>('customIcon', customIcon));
  }
}

/// Extensions on [ZetaWidgetStatus].
extension on ZetaWidgetStatus {
  IconData icon(BuildContext context) {
    switch (this) {
      case ZetaWidgetStatus.positive:
        return context.rounded ? ZetaIcons.check_circle_round : ZetaIcons.check_circle_sharp;
      case ZetaWidgetStatus.warning:
        return context.rounded ? ZetaIcons.warning_round : ZetaIcons.warning_sharp;
      case ZetaWidgetStatus.negative:
        return context.rounded ? ZetaIcons.error_round : ZetaIcons.error_sharp;
      case ZetaWidgetStatus.neutral:
      case ZetaWidgetStatus.info:
        return context.rounded ? ZetaIcons.info_round : ZetaIcons.info_sharp;
    }
  }
}
