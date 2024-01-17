import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../zeta_flutter.dart';

/// [ZetaSystemBanner] type
enum ZetaSystemBannerType {
  /// blue background
  defaultAppBar,

  /// green background
  positiveAppBar,

  /// brown/yellow background
  warningAppBar,

  /// red background
  negativeAppBar,
}

/// ZetaSystemBanner component
class ZetaSystemBanner extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor for [ZetaSystemBanner]
  const ZetaSystemBanner({
    super.key,
    this.type = ZetaSystemBannerType.defaultAppBar,
    this.leading,
    this.centerTitle = false,
    this.actions,
    this.title,
    this.titleIcon,
    this.titleSpacing,
    this.systemOverlayStyle,
    this.automaticallyImplyLeading = false,
  });

  /// The type of the [ZetaSystemBanner]
  final ZetaSystemBannerType type;

  /// AppBar leading
  final Widget? leading;

  /// AppBar title
  final Widget? title;

  /// Icon to place next to the AppBar title, on the left side.
  final Icon? titleIcon;

  /// AppBar centerTitle
  final bool centerTitle;

  /// AppBar titleSpacing
  final double? titleSpacing;

  /// AppBar automaticallyImplyLeading. Default is `true`
  final bool automaticallyImplyLeading;

  /// AppBar actions
  final List<Widget>? actions;

  /// AppBar systemOverlayStyle
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = _foregroundColorFromType(context, type);
    return AppBar(
      titleSpacing: titleSpacing,
      centerTitle: centerTitle,
      backgroundColor: _backgroundColorFromType(context, type),
      foregroundColor: foregroundColor,
      systemOverlayStyle: systemOverlayStyle ??
          SystemUiOverlayStyle.dark.copyWith(
            statusBarIconBrightness: _statusBarIconBrightness(context, type),
          ),
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: DefaultTextStyle(
        style: TextStyle(
          fontSize: 16,
          height: 1.5,
          fontWeight: FontWeight.w500,
          color: foregroundColor,
          overflow: TextOverflow.ellipsis,
        ),
        child: titleIcon == null
            ? title ?? const SizedBox()
            : Row(
                mainAxisAlignment: centerTitle ? MainAxisAlignment.center : MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: title == null ? 0 : 8),
                    child: titleIcon,
                  ),
                  Flexible(
                    child: title ?? const SizedBox(),
                  ),
                ],
              ),
      ),
      actions: actions ?? (leading != null && titleIcon != null ? [const SizedBox(width: 40)] : null),
    );
  }

  Color _backgroundColorFromType(BuildContext context, ZetaSystemBannerType type) {
    final themeMode = Zeta.of(context).themeMode;
    switch (type) {
      case ZetaSystemBannerType.defaultAppBar:
        return ZetaColorBase.blue.shade60;
      case ZetaSystemBannerType.positiveAppBar:
        return themeMode == ThemeMode.dark ? ZetaColorBase.green.shade70 : ZetaColorBase.green;
      case ZetaSystemBannerType.warningAppBar:
        return themeMode == ThemeMode.dark ? ZetaColorBase.orange.shade30 : ZetaColorBase.orange.shade60;
      case ZetaSystemBannerType.negativeAppBar:
        return ZetaColorBase.red.shade60;
    }
  }

  Color _foregroundColorFromType(BuildContext context, ZetaSystemBannerType type) {
    switch (type) {
      case ZetaSystemBannerType.defaultAppBar:
        return ZetaColorBase.white;
      case ZetaSystemBannerType.positiveAppBar:
        return ZetaColorBase.white;
      case ZetaSystemBannerType.warningAppBar:
        return ZetaColorBase.black;
      case ZetaSystemBannerType.negativeAppBar:
        return ZetaColorBase.white;
    }
  }

  Brightness _statusBarIconBrightness(BuildContext context, ZetaSystemBannerType type) {
    switch (type) {
      case ZetaSystemBannerType.defaultAppBar:
        return Brightness.light;
      case ZetaSystemBannerType.positiveAppBar:
        return Brightness.light;
      case ZetaSystemBannerType.warningAppBar:
        return Brightness.dark;
      case ZetaSystemBannerType.negativeAppBar:
        return Brightness.light;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaSystemBannerType?>('type', type))
      ..add(DiagnosticsProperty<Widget?>('leading', leading))
      ..add(DiagnosticsProperty<Widget?>('title', title))
      ..add(DiagnosticsProperty<Widget?>('titleIcon', titleIcon))
      ..add(DiagnosticsProperty<bool?>('centerTitle', centerTitle))
      ..add(DiagnosticsProperty<double?>('titleSpacing', titleSpacing))
      ..add(DiagnosticsProperty<bool?>('automaticallyImplyLeading', automaticallyImplyLeading))
      ..add(DiagnosticsProperty<List<Widget>?>('actions', actions))
      ..add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemOverlayStyle', systemOverlayStyle));
  }
}
