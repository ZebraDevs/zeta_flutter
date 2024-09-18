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
    bool titleStart = false,

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
          content: () {
            final colors = Zeta.of(context).colors;
            final backgroundColor = type.backgroundColor(context);
            final foregroundColor = colors.mainInverse;

            if (!kIsWeb && PlatformIs.android && context.mounted) {
              // ignore: invalid_use_of_visible_for_testing_member
              final statusBarColor = SystemChrome.latestStyle?.statusBarColor;
              if (statusBarColor != backgroundColor) {
                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    statusBarColor: backgroundColor,
                    systemNavigationBarIconBrightness: Brightness.light,
                  ),
                );
              }
            }

            return ZetaRoundedScope(
              rounded: rounded ?? context.rounded,
              child: Semantics(
                label: semanticLabel ?? title,
                child: DefaultTextStyle(
                  style: ZetaTextStyles.labelLarge.copyWith(
                    color: foregroundColor,
                    overflow: TextOverflow.ellipsis,
                  ),
                  child: Row(
                    mainAxisAlignment: titleStart ? MainAxisAlignment.center : MainAxisAlignment.start,
                    children: [
                      if (leadingIcon != null)
                        Padding(
                          padding: EdgeInsets.only(right: Zeta.of(context).spacing.small),
                          child: Icon(
                            leadingIcon,
                            color: foregroundColor,
                            size: Zeta.of(context).spacing.xl_2,
                          ),
                        ),
                      Flexible(child: Text(title)),
                    ],
                  ),
                ),
              ),
            );
          }(),
          backgroundColor: type.backgroundColor(context),
          actions: [
            IconTheme(
              data: IconThemeData(color: Zeta.of(context).colors.mainInverse),
              child: trailing ?? const Nothing(),
            ),
          ],
        );
}

extension on ZetaBannerStatus {
  Color backgroundColor(BuildContext context) {
    final colors = Zeta.of(context).colors;
    switch (this) {
      case ZetaBannerStatus.primary:
        return colors.surfacePrimary;
      case ZetaBannerStatus.positive:
        return colors.surfacePositive;
      case ZetaBannerStatus.warning:
        return colors.surfaceWarning;
      case ZetaBannerStatus.negative:
        return colors.surfaceNegative;
    }
  }
}
