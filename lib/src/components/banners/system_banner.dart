import 'dart:io';

import 'package:flutter/foundation.dart';
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

/// ZetaSystemBanner. Extends [MaterialBanner].
///
/// A banner displays an important, succinct message, and provides action for users to address.
/// It draws the attention to the message by displaying it at the top in various colors.
class ZetaSystemBanner extends MaterialBanner {
  /// Constructor for [ZetaSystemBanner]. See [MaterialBanner] for more information.
  ZetaSystemBanner({
    required BuildContext context,
    required String title,
    super.key,
    IconData? leadingIcon,
    ZetaSystemBannerStatus type = ZetaSystemBannerStatus.primary,
    bool titleStart = false,
    Widget? trailing,
  }) : super(
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

              return DefaultTextStyle(
                style: ZetaTextStyles.titleSmall.copyWith(
                  color: foregroundColor,
                  overflow: TextOverflow.ellipsis,
                  height: 1,
                ),
                child: Row(
                  mainAxisAlignment: titleStart ? MainAxisAlignment.center : MainAxisAlignment.start,
                  children: [
                    if (leadingIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: ZetaSpacing.x2),
                        child: Icon(
                          leadingIcon,
                          color: foregroundColor,
                          size: ZetaSpacing.x6,
                        ),
                      ),
                    Flexible(child: Text(title)),
                  ],
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

  static ZetaColorSwatch _backgroundColorFromType(BuildContext context, ZetaSystemBannerStatus type) {
    final zeta = Zeta.of(context);

    switch (type) {
      case ZetaSystemBannerStatus.primary:
        return zeta.colors.primary;
      case ZetaSystemBannerStatus.positive:
        return zeta.colors.positive;
      case ZetaSystemBannerStatus.warning:
        return zeta.colors.orange;
      case ZetaSystemBannerStatus.negative:
        return zeta.colors.negative;
    }
  }
}
