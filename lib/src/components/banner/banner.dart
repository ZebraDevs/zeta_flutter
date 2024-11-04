import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../zeta_flutter.dart';

/// [ZetaBanner] type.
@Deprecated('Use ZetaBannerStatus instead. ' 'This widget has been renamed as of 0.11.0')
typedef ZetaSystemBannerStatus = ZetaBannerStatus;

/// Zeta Banner. Extends [MaterialBanner].
@Deprecated('Use ZetaBanner instead. ' 'This widget has been renamed as of 0.11.0')
typedef ZetaSystemBanner = ZetaBanner;

/// [ZetaBanner] type
enum ZetaBannerStatus {
  /// Primary background.
  primary,

  /// Green background.
  positive,

  /// Yellow background.
  warning,

  /// Red background.
  negative,
}

/// A banner displays an important, succinct message, and provides action for users to address.
/// It draws the attention to the message by displaying it at the top in various colors.
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22195-43965
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/banners
class ZetaBanner extends MaterialBanner {
  /// Constructor for [ZetaBanner]. See [MaterialBanner] for more information.
  ZetaBanner({
    super.key,
    required BuildContext context,

    /// The title of the banner.
    required String title,

    /// The leading icon for the banner.
    IconData? leadingIcon,

    /// The type of banner. See [ZetaBannerStatus].
    ZetaBannerStatus type = ZetaBannerStatus.primary,

    /// Whether the title should be centered.
    bool titleCenter = false,

    /// Whether the title should be centered.
    @Deprecated('Use titleCenter instead. ' 'This widget has been renamed as of 0.18.0') bool? titleStart,

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
          content: Builder(
            builder: (context) {
              final backgroundColor = _backgroundColorFromType(context, type);
              final foregroundColor = backgroundColor.onColor;
              if (!kIsWeb && PlatformIs.android && context.mounted) {
                // ignore: invalid_use_of_visible_for_testing_member
                final statusBarColor = SystemChrome.latestStyle?.statusBarColor;
                if (statusBarColor != backgroundColor) {
                  SystemChrome.setSystemUIOverlayStyle(
                    SystemUiOverlayStyle(
                      statusBarColor: backgroundColor,
                      systemNavigationBarIconBrightness: backgroundColor.isDark ? Brightness.light : Brightness.dark,
                    ),
                  );
                }
              }

              // ignore: no_leading_underscores_for_local_identifiers
              final _titleCenter = titleStart ?? titleCenter;
              return ZetaRoundedScope(
                rounded: rounded ?? context.rounded,
                child: Semantics(
                  label: semanticLabel ?? title,
                  child: DefaultTextStyle(
                    style: ZetaTextStyles.labelLarge.copyWith(
                      color: foregroundColor,
                      overflow: TextOverflow.ellipsis,
                    ),
                    child: Stack(
                      alignment: _titleCenter ? Alignment.center : Alignment.centerLeft,
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
                              !_titleCenter && leadingIcon != null ? const EdgeInsets.only(left: 40) : EdgeInsets.zero,
                          child: Flexible(
                            child: Text(
                              title,
                              style: ZetaTextStyles.labelLarge.copyWith(
                                color: Zeta.of(context).colors.textInverse,
                              ),
                            ),
                          ),
                        ),
                        if (trailing != null)
                          Positioned(
                            right: 0,
                            child: IconTheme(
                              data: IconThemeData(color: _backgroundColorFromType(context, type).onColor),
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

  static ZetaColorSwatch _backgroundColorFromType(BuildContext context, ZetaBannerStatus type) {
    final zeta = Zeta.of(context);

    switch (type) {
      case ZetaBannerStatus.primary:
        return zeta.colors.primary;
      case ZetaBannerStatus.positive:
        return zeta.colors.surfacePositive;
      case ZetaBannerStatus.warning:
        return zeta.colors.orange;
      case ZetaBannerStatus.negative:
        return zeta.colors.surfaceNegative;
    }
  }

  // static Widget _getTitle(bool titleStart, String title, BuildContext context) {
  //   if (titleStart) {
  //     return
  //   } else {
  //     return Positioned(
  //       left: 10,
  //       child: Flexible(
  //         child: Text(
  //           title,
  //           style: ZetaTextStyles.labelLarge.copyWith(
  //             color: Zeta.of(context).colors.textInverse,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  // }
}
