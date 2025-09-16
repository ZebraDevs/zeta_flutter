import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../zeta_flutter.dart';

class ZetaGlobalHeader2 extends ZetaStatelessWidget {
  const ZetaGlobalHeader2({
    super.key,
    super.rounded,
    required this.platformName,
    this.navItems = const [],
    this.searchBar = false,
    this.actionItems = const [],
    this.name,
    this.appSwitcher = false,
    this.onHamburgerMenuPressed,
    this.onAvatarButtonPressed,
    this.onAppsButtonPressed,
    this.avatar,
    this.leading,
  });

  /// Avatar widget. Recommended to use [ZetaAvatar] widget.
  final Widget? avatar;

  /// Leftmost widget. Recommended to use [ZetaIconButton] widget.
  ///
  /// If not provided, defaults to a hamburger menu button.
  final Widget? leading;

  /// Header platformName in top left of header
  final String platformName;

  /// Menu items to display in the header.
  /// If more than 6 items are provided, only the first 6 will be displayed.
  /// Expects ZetaButton or ZetaDropDown widgets.
  final List<Widget> navItems;

  /// Search bar widget
  final bool searchBar;

  /// Action buttons to display in the header
  final List<Widget> actionItems;

  /// Set the name of the user
  final String? name;

  ///Boolean to show app switcher button or not.
  ///Set to false by default. Set to true to show app switcher button.
  final bool appSwitcher;

  /// Callback when hamburger menu is pressed.
  /// Set to null by default, which disables the button.
  final VoidCallback? onHamburgerMenuPressed;

  /// Callback when avatar button is pressed.
  /// Set to null by default, which disables the button.
  final VoidCallback? onAvatarButtonPressed;

  /// Callback when apps button is pressed.
  /// Set to null by default, which disables the button.
  final VoidCallback? onAppsButtonPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ZetaRoundedScope(
          rounded: context.rounded,
          child: Container(
            width: constraints.maxWidth,
            padding: EdgeInsets.symmetric(
              vertical: Zeta.of(context).spacing.large,
              horizontal: Zeta.of(context).spacing.small,
            ),
            decoration: BoxDecoration(color: colors.surfaceDefault),
            child: Row(
              spacing: Zeta.of(context).spacing.large,
              children: [
                leading ??
                    ZetaIconButton(
                      icon: ZetaIcons.hamburger_menu,
                      size: ZetaWidgetSize.small,
                      onPressed: onHamburgerMenuPressed,
                      type: ZetaButtonType.subtle,
                    ),

                SvgPicture.asset(
                  'packages/zeta_flutter/assets/logos/zebra-logo.svg',
                  height: Zeta.of(context).spacing.xl_4,
                ),

                Text(platformName, style: Zeta.of(context).textStyles.titleMedium),

                //Divider
                if (navItems.isNotEmpty)
                  Container(
                    width: 1,
                    height: 36,
                    color: colors.borderDefault,
                  ),

                // Nav items
                // TODO(thelukewalton): Remove IntrinsicWidth and replace with better solution
                for (final item in navItems.take(6))
                  IntrinsicWidth(
                    child: _renderNavItems(item),
                  ),

                const Expanded(child: Nothing()),

                if (searchBar)
                  Container(
                    width: 240,
                    padding: EdgeInsets.only(left: Zeta.of(context).spacing.small),
                    child: ZetaSearchBar(size: ZetaWidgetSize.small, showSpeechToText: false),
                  ),

                //Action Items
                if (actionItems.isNotEmpty)
                  Container(
                    width: 1,
                    height: 36,
                    color: colors.borderDefault,
                  ),

                for (final item in actionItems.take(6)) IntrinsicWidth(child: _renderActionItems(item)),

                ZetaButton(
                  label: name ?? '',
                  type: ZetaButtonType.subtle,
                  size: ZetaWidgetSize.small,
                  onPressed: onAvatarButtonPressed,
                  trailingIcon: ZetaIcons.expand_more,
                  child: avatar is ZetaAvatar
                      ? (avatar! as ZetaAvatar).copyWith(size: ZetaAvatarSize.xxxs)
                      : ZetaAvatar.fromName(name: name ?? '', size: ZetaAvatarSize.xxxs),
                ),
                if (appSwitcher)
                  ZetaIconButton(
                    icon: ZetaIcons.apps,
                    size: ZetaWidgetSize.small,
                    onPressed: onAppsButtonPressed,
                    type: ZetaButtonType.subtle,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderNavItems(Widget item) {
    if (item is ZetaButton) {
      return item.copyWith(type: ZetaButtonType.subtle);
    } else if (item is ZetaIconButton) {
      return item.copyWith(type: ZetaButtonType.subtle);
    } else {
      return item;
    }
  }

  Widget _renderActionItems(Widget item) {
    if (item is ZetaButton) {
      return item.copyWith(type: ZetaButtonType.subtle);
    } else if (item is ZetaIconButton) {
      return item.copyWith(type: ZetaButtonType.subtle);
    } else {
      return item;
    }
  }
}
