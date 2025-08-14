import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../zeta_flutter.dart';

/// [ZetaSystemBanner] type
enum ZetaSystemBannerStatus {
  /// Primary background.
  primary,

  /// Green background.
  positive,

  /// Yellow background.
  warning,

  /// Red background.
  negative,
}

/// A banner displays an important, succinct message, and provides action for users to address. It draws the attention to the message by displaying it at the top in various colors.
///
/// To display on screen use `ScaffoldMessenger.of(context).showMaterialBanner(ZetaSystemBanner())`. This will display the banner at the top of the page, below the AppBar.
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22195-43965
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/system-banner/zetasystembanner/system-banner
class ZetaSystemBanner extends MaterialBanner {
  /// Constructor for [ZetaSystemBanner]. See [MaterialBanner] for more information.
  ZetaSystemBanner({
    super.key,
    required BuildContext context,

    /// The title of the banner.
    required String title,

    /// The leading icon for the banner.
    IconData? leadingIcon,

    /// The type of banner. See [ZetaSystemBannerStatus].
    ZetaSystemBannerStatus type = ZetaSystemBannerStatus.primary,

    /// Whether the title should be centered.
    bool titleCenter = false,

    /// The trailing widget for the banner.
    Widget? trailing,

    /// {@macro zeta-component-rounded}
    bool? rounded,

    /// The semantic label for the banner.
    ///
    /// If this is null, the title will be used.
    String? semanticLabel,
  }) : super(
          dividerColor: Colors.transparent,
          onVisible: () {
            if (PlatformIs.android) {
              final backgroundColor = _backgroundColorFromType(context, type);

              SystemChrome.setSystemUIOverlayStyle(
                SystemUiOverlayStyle(
                  statusBarColor: backgroundColor,
                  systemNavigationBarIconBrightness: backgroundColor.isDark ? Brightness.light : Brightness.dark,
                ),
              );
            }
          },
          content: Builder(
            builder: (context) {
              final foregroundColor = Zeta.of(context).colors.mainInverse;

              return ZetaRoundedScope(
                rounded: rounded ?? context.rounded,
                child: Semantics(
                  label: semanticLabel ?? title,
                  child: DefaultTextStyle(
                    style: Zeta.of(context).textStyles.labelLarge.copyWith(
                          color: foregroundColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                    child: Stack(
                      alignment: titleCenter ? Alignment.center : Alignment.centerLeft,
                      children: [
                        if (leadingIcon != null)
                          Positioned(
                            left: 0,
                            child: Padding(
                              padding: EdgeInsets.only(right: Zeta.of(context).spacing.small),
                              child: Icon(
                                leadingIcon,
                                color: foregroundColor,
                                size: Zeta.of(context).spacing.xl_2,
                              ),
                            ),
                          ),
                        Padding(
                          padding:
                              !titleCenter && leadingIcon != null ? const EdgeInsets.only(left: 40) : EdgeInsets.zero,
                          child: Text(
                            title,
                            style: Zeta.of(context).textStyles.labelLarge.copyWith(
                                  color: foregroundColor,
                                ),
                          ),
                        ),
                        if (trailing != null)
                          Positioned(
                            right: 0,
                            child: IconTheme(
                              data: IconThemeData(color: foregroundColor),
                              child: trailing,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          backgroundColor: _backgroundColorFromType(context, type),
          actions: [const Nothing()],
        );

  static ZetaColorSwatch _backgroundColorFromType(BuildContext context, ZetaSystemBannerStatus type) {
    final zeta = Zeta.of(context);

    switch (type) {
      case ZetaSystemBannerStatus.primary:
        return zeta.colors.primitives.primary;
      case ZetaSystemBannerStatus.positive:
        return zeta.colors.primitives.green;
      case ZetaSystemBannerStatus.warning:
        return zeta.colors.primitives.orange;
      case ZetaSystemBannerStatus.negative:
        return zeta.colors.primitives.red;
    }
  }
}
