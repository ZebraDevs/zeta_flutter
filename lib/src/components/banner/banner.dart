import 'dart:io';

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

/// Zeta Banner. Extends [MaterialBanner].
///
/// A banner displays an important, succinct message, and provides action for users to address.
/// It draws the attention to the message by displaying it at the top in various colors.
class ZetaBanner extends MaterialBanner {
  /// Constructor for [ZetaBanner]. See [MaterialBanner] for more information.
  ZetaBanner({
    required BuildContext context,
    required String title,
    super.key,
    IconData? leadingIcon,
    ZetaBannerStatus type = ZetaBannerStatus.primary,
    bool titleStart = false,
    Widget? trailing,
    bool? rounded,
  }) : super(
          dividerColor: Colors.transparent,
          content: Builder(
            builder: (context) {
              final backgroundColor = _backgroundColorFromType(context, type);
              final foregroundColor = backgroundColor.onColor;
              if (!kIsWeb && Platform.isAndroid && context.mounted) {
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

              return ZetaRoundedScope(
                rounded: rounded ?? context.rounded,
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
                          padding: const EdgeInsets.only(right: ZetaSpacing.small),
                          child: ZetaIcon(
                            leadingIcon,
                            color: foregroundColor,
                            size: ZetaSpacing.xl_2,
                          ),
                        ),
                      Flexible(child: Text(title)),
                    ],
                  ),
                ),
              );
            },
          ),
          backgroundColor: _backgroundColorFromType(context, type),
          actions: [
            IconTheme(
              data: IconThemeData(color: _backgroundColorFromType(context, type).onColor),
              child: trailing ?? const SizedBox(),
            ),
          ],
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
}
