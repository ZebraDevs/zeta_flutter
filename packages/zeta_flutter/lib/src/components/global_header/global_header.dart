import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../zeta_flutter.dart';

/// Zeta Global Header:
///
/// Can have a **maximum** of 6 nav items and 6 action items.
///
/// This component is permanently set to **dark mode**.
///
/// Search bar (when set to true) will be hidden when there are 6 nav and action items, on a screen size of 1440px or less.
///
/// * Users can input their own avatar widget, otherwise it will default to a [ZetaAvatar].
/// * Users can input their own leading widget, otherwise it will default to a [ZetaIconButton] with a hamburger menu icon.
/// * Users can input their own nav items and action items, otherwise they will be empty.
///
/// It is recommended to use [ZetaButton] or [ZetaDropdown] widgets for **nav items**, and [ZetaIconButton] for **action items**.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS-Zeta---Components?node-id=1120-26358&p=f&m=dev
class ZetaGlobalHeader extends ZetaStatelessWidget {
  /// Constructs [ZetaGlobalHeader]
  const ZetaGlobalHeader({
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
  ///
  /// If not provided, defaults to a [ZetaAvatar] with the provided name.
  /// If name is also not provided, defaults to a [ZetaAvatar] with NA initials.
  final Widget? avatar;

  /// Leftmost widget. Recommended to use [ZetaIconButton] widget.
  ///
  /// If not provided, defaults to a [ZetaIconButton] with a hamburger menu icon.
  final Widget? leading;

  /// Header platformName in top left of header.
  final String platformName;

  /// Menu items to display in the header.
  ///
  /// If more than 6 items are provided, only the first 6 will be displayed.
  /// Expects [ZetaButton] or [ZetaDropdown] widgets.
  final List<Widget> navItems;

  /// Search bar widget.
  ///
  /// Set to false by default. Set to true to show search bar.
  final bool searchBar;

  /// Action buttons to display in the header.
  ///
  /// If more than 6 items are provided, only the first 6 will be displayed.
  /// Expects [ZetaIconButton] widgets.
  final List<Widget> actionItems;

  /// Set the name of the user.
  ///
  /// If not set, defaults to an empty string.
  /// This name will be used to generate initials in the avatar.
  final String? name;

  /// Boolean to show app switcher button or not.
  ///
  ///Set to false by default. Set to true to show app switcher button.
  final bool appSwitcher;

  /// Callback when hamburger menu is pressed.
  ///
  /// Set to null by default, which disables the button.
  final VoidCallback? onHamburgerMenuPressed;

  /// Callback when avatar button is pressed.
  ///
  /// Set to null by default, which disables the button.
  final VoidCallback? onAvatarButtonPressed;

  /// Callback when apps button is pressed.
  ///
  /// Set to null by default, which disables the button.
  final VoidCallback? onAppsButtonPressed;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('platformName', platformName))
      ..add(ObjectFlagProperty<bool?>.has('searchBar', searchBar))
      ..add(ObjectFlagProperty<bool?>.has('appSwitcher', appSwitcher))
      ..add(StringProperty('name', name))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onHamburgerMenuPressed', onHamburgerMenuPressed))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAvatarButtonPressed', onAvatarButtonPressed))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAppsButtonPressed', onAppsButtonPressed));
  }

  @override
  Widget build(BuildContext _) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return ZetaThemeOverride(
          themeMode: ThemeMode.dark,
          builder: (context) {
            final colors = Zeta.of(context).colors;
            return ZetaRoundedScope(
              rounded: rounded ?? false,
              // Main container (for padding and background color)
              child: Container(
                height: 52,
                padding: EdgeInsets.symmetric(
                  horizontal: Zeta.of(context).spacing.large,
                ),
                color: colors.surfaceDefault,

                // Main row (for all header content)
                child: Row(
                  spacing: Zeta.of(context).spacing.large,
                  children: [
                    // Leading icon widget
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
                      child: leading ??
                          ZetaIconButton(
                            icon: ZetaIcons.hamburger_menu,
                            onPressed: onHamburgerMenuPressed,
                            type: ZetaButtonType.subtle,
                            semanticLabel: 'Hamburger Menu Button',
                          ),
                    ),
                    // Logo
                    SvgPicture.asset(
                      'packages/zeta_flutter/assets/logos/zebra-logo.svg',
                      height: Zeta.of(context).spacing.xl_4,
                      semanticsLabel: 'Zebra Logo',
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    // Platform name
                    Text(platformName, style: Zeta.of(context).textStyles.titleMedium.apply(color: colors.mainDefault)),

                    if (navItems.isNotEmpty)
                      // Divider
                      Container(
                        key: const Key('divider-menu-items'),
                        width: 1,
                        height: Zeta.of(context).spacing.xl_5,
                        color: colors.borderDefault,
                      ),
                    // Nav items
                    // TODO(UX-1520): Remove IntrinsicWidth and replace with better solution
                    for (final item in navItems.take(6))
                      IntrinsicWidth(
                        child: _renderNavItems(item),
                      ),

                    // Spacer dividing left and right side of header
                    const Expanded(child: Nothing()),

                    // Search bar
                    if (searchBar)
                      if ((navItems.length == 6 && actionItems.length == 6) && constraints.maxWidth <= 1440)
                        const Nothing()
                      else
                        Container(
                          constraints: const BoxConstraints(maxWidth: 240, minWidth: 100),
                          margin: EdgeInsets.only(left: Zeta.of(context).spacing.small),
                          child: ZetaSearchBar(size: ZetaWidgetSize.small, showSpeechToText: false),
                        ),

                    // Divider
                    if (actionItems.isNotEmpty)
                      Container(
                        key: const Key('divider-action-items'),
                        width: 1,
                        height: Zeta.of(context).spacing.xl_5,
                        color: colors.borderDefault,
                      ),
                    // Action items
                    // TODO(UX-1520): Remove IntrinsicWidth and replace with better solution
                    for (final item in actionItems.take(6)) IntrinsicWidth(child: _renderActionItems(item)),

                    // Avatar button
                    ZetaButton(
                      label: name ?? '',
                      type: ZetaButtonType.subtle,
                      onPressed: onAvatarButtonPressed,
                      trailingIcon: ZetaIcons.expand_more,
                      semanticLabel: 'User Avatar Button',
                      child: avatar is ZetaAvatar
                          ? (avatar! as ZetaAvatar).copyWith(
                              size: ZetaAvatarSize.xxxs,
                              backgroundColor: Zeta.of(context).colors.avatarPurple,
                            )
                          : ZetaAvatar.fromName(
                              name: name ?? '',
                              size: ZetaAvatarSize.xxxs,
                              backgroundColor: Zeta.of(context).colors.avatarPurple,
                            ),
                    ),

                    // App switcher button
                    if (appSwitcher)
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 40, maxHeight: 40),
                        child: ZetaIconButton(
                          icon: ZetaIcons.apps,
                          onPressed: onAppsButtonPressed,
                          type: ZetaButtonType.subtle,
                          semanticLabel: 'App Switcher Button',
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Renders nav items, ensuring they are of the correct type and style.
  Widget _renderNavItems(Widget item) {
    if (item is ZetaButton) {
      return item.copyWith(type: ZetaButtonType.subtle);
    } else if (item is ZetaIconButton) {
      return item.copyWith(type: ZetaButtonType.subtle);
    } else {
      return item;
    }
  }

  /// Renders action items, ensuring they are of the correct type and style.
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
