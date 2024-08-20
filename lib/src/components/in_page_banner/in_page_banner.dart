import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// In page banners display an important, succinct message, and may provide actions for users to address. Banners should be displayed at the top of the screen,below a top app bar. Only one banner should be shown at a time.
/// {@category Components}
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
    final Color backgroundColor = status.backgroundColor(theme.colors);
    final Color borderColor = status.borderColor(theme.colors);
    final Color iconColor = status.foregroundColor(theme.colors);

    return ZetaRoundedScope(
      rounded: rounded,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: rounded ? Zeta.of(context).radii.minimal : Zeta.of(context).radii.none,
        ),
        padding: EdgeInsetsDirectional.only(
          bottom: Zeta.of(context).spacing.medium,
          start: Zeta.of(context).spacing.medium,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  top: Zeta.of(context).spacing.medium,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZetaIcon(
                      customIcon ?? status.icon,
                      size: Zeta.of(context).spacing.xl,
                      color: iconColor,
                    ),
                    SizedBox(width: Zeta.of(context).spacing.small),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (hasTitle)
                            Text(
                              title!,
                              style: ZetaTextStyles.labelLarge.copyWith(height: 20 / 16),
                            ).paddingBottom(Zeta.of(context).spacing.minimum),
                          DefaultTextStyle(
                            style: ZetaTextStyles.bodySmall.apply(color: theme.colors.main.defaultColor),
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
                icon: ZetaIcon(
                  ZetaIcons.close,
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

extension on ZetaWidgetStatus {
  IconData get icon {
    switch (this) {
      case ZetaWidgetStatus.positive:
        return ZetaIcons.check_circle;
      case ZetaWidgetStatus.warning:
        return ZetaIcons.warning;
      case ZetaWidgetStatus.negative:
        return ZetaIcons.error;
      case ZetaWidgetStatus.neutral:
      case ZetaWidgetStatus.info:
        return ZetaIcons.info;
    }
  }
}

/// Extensions on [ZetaWidgetStatus].
extension on ZetaWidgetStatus {
  /// Gets background color from [ZetaWidgetStatus].
  Color backgroundColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.surface.infoSubtle;
      case ZetaWidgetStatus.positive:
        return colors.surface.positiveSubtle;
      case ZetaWidgetStatus.warning:
        return colors.surface.warningSubtle;
      case ZetaWidgetStatus.negative:
        return colors.surface.negativeSubtle;
      case ZetaWidgetStatus.neutral:
        return colors.surface.defaultColor;
    }
  }

  /// Gets foreground color from [ZetaWidgetStatus].
  Color foregroundColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.main.info;
      case ZetaWidgetStatus.positive:
        return colors.main.positive;
      case ZetaWidgetStatus.warning:
        return colors.main.warning;
      case ZetaWidgetStatus.negative:
        return colors.main.negative;
      case ZetaWidgetStatus.neutral:
        return colors.main.defaultColor;
    }
  }

  /// Gets border color from [ZetaWidgetStatus].
  Color borderColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaWidgetStatus.info:
        return colors.border.info;
      case ZetaWidgetStatus.positive:
        return colors.border.positive;
      case ZetaWidgetStatus.warning:
        return colors.border.warning;
      case ZetaWidgetStatus.negative:
        return colors.border.negative;
      case ZetaWidgetStatus.neutral:
        return colors.border.defaultColor;
    }
  }
}
