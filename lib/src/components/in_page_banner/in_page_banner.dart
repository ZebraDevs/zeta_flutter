import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta In Page Banner.
///
/// In page banners display an important, succinct message, and may provide actions for users to address. Banners should be displayed at the top of the screen,below a top app bar. Only one banner should be shown at a time.
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
    final colors = status.colorSwatch(context);
    final hasTitle = title != null;
    final rounded = context.rounded;

    return ZetaRoundedScope(
      rounded: rounded,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(ZetaSpacingBase.x0_5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: ZetaSpacing.medium, start: ZetaSpacingBase.x2_5),
                child: ZetaIcon(
                  customIcon ?? status.icon,
                  size: ZetaSpacing.xl_1,
                  color: status == ZetaWidgetStatus.neutral ? theme.colors.textDefault : colors.icon,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: ZetaSpacing.small),
                    if (hasTitle)
                      Text(
                        title!,
                        style: ZetaTextStyles.labelLarge,
                      ).paddingBottom(ZetaSpacing.minimum),
                    DefaultTextStyle(
                      style: ZetaTextStyles.bodySmall.apply(color: theme.colors.textDefault),
                      child: content,
                    ),
                    if (actions.isNotEmpty)
                      Row(
                        children: actions
                            .map((e) => e.copyWith(size: ZetaWidgetSize.medium, type: ZetaButtonType.outlineSubtle))
                            .divide(const SizedBox.square(dimension: ZetaSpacing.small))
                            .toList(),
                      ).paddingTop(ZetaSpacing.large),
                    const SizedBox(height: ZetaSpacingBase.x2_5),
                  ],
                ),
              ),
              if (onClose != null)
                IconButton(
                  onPressed: onClose,
                  icon: const ZetaIcon(
                    ZetaIcons.close,
                    size: ZetaSpacing.xl_1,
                  ),
                ),
            ].divide(const SizedBox.square(dimension: ZetaSpacing.small)).toList(),
          ),
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
