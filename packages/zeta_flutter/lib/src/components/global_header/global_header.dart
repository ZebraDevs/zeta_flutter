import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../zeta_flutter.dart';

/// The Header is the topmost, persistent navigation bar across the application. It contains global actions and utilities such as the product logo, primary navigation, search, and user profile access. It anchors the user in the application and remains consistent across all views.
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
/// Due to the lack of concrete designs for responsiveness, the current implementation has multiple known issues:
///  * On most screen sizes, something will overflow.
///  * The search bar will disappear when there are 6 nav and action items, on a screen size of 1440px or less.
///  * Many screen sizes will face issues trying to display up to 6 nav and action items.
///
/// These issues will be addressed in future iterations of this component - we welcome feedback and contributions!
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS-Zeta---Components?node-id=1120-26358&p=f&m=dev
class ZetaGlobalHeader extends ZetaStatelessWidget {
  /// Constructs [ZetaGlobalHeader]
  const ZetaGlobalHeader({
    super.key,
    super.rounded,
    required this.platformName,
    this.logo,
    this.navItems = const [],
    this.searchBar,
    this.actionItems = const [],
    this.userName,
    this.onHamburgerMenuPressed,
    this.onAvatarButtonPressed,
    this.onAppsButtonPressed,
    this.avatar,
    this.leading,
    this.trailing,
    this.trailingSemanticLabel = 'App switcher button',
    this.leadingSemanticLabel = 'Hamburger menu button',
    this.logoSemanticLabel = 'Zebra logo',
    this.avatarSemanticLabel = 'User avatar button',
  });

  /// Avatar widget. Recommended to use [ZetaAvatar] widget.
  ///
  /// If not provided, defaults to a [ZetaAvatar] with the provided name.
  /// If name is also not provided, defaults to a [ZetaAvatar] with NA initials.
  final Widget? avatar;

  /// Leftmost widget. Recommended to use [ZetaIconButton] widget.
  ///
  /// If not provided, defaults to a [ZetaIconButton] with a hamburger menu icon.
  ///
  /// If provided, the [leadingSemanticLabel] will not be used, but should be provided by this widget.
  ///
  /// If you do not want a leading widget, set this to [Nothing].
  final Widget? leading;

  /// (Optional) Logo widget. If null, Zebra logo will be used.
  ///
  /// If provided, it is recommended to use an SVG Picture widget and should be rendered at a height of 32px, in a light color.
  ///
  /// If provided, the [logoSemanticLabel] will not be used, but should be provided by this widget.
  final Widget? logo;

  /// (Optional) Search bar widget. If null, a default [ZetaSearchBar] will be displayed.
  final Widget? searchBar;

  /// Header platformName in top left of header.
  final String platformName;

  /// Menu items to display in the header.
  ///
  /// If more than 6 items are provided, only the first 6 will be displayed.
  ///
  /// Expects [ZetaButton] or [ZetaDropdown] widgets.
  final List<Widget> navItems;

  /// Action buttons to display in the header.
  ///
  /// If more than 6 items are provided, only the first 6 will be displayed.
  /// Expects [ZetaIconButton] widgets.
  final List<Widget> actionItems;

  /// Set the name of the user.
  ///
  /// If not set, defaults to an empty string.
  /// This name will be used to generate initials in the avatar.
  final String? userName;

  /// Trailing widget. If not provided, the app switcher button will be displayed.
  ///
  /// If provided, it will replace the app switcher button.
  final Widget? trailing;

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

  /// Semantic label for the hamburger menu button.
  ///
  /// Defaults to 'Hamburger Menu Button'.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// {@macro zeta-widget-translations}
  final String? leadingSemanticLabel;

  /// Semantic label for the Zebra logo.
  ///
  /// Defaults to 'Zebra Logo'.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// {@macro zeta-widget-translations}
  final String? logoSemanticLabel;

  /// Semantic label for the trailing app switcher button.
  ///
  /// Defaults to 'App Switcher Button'.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// {@macro zeta-widget-translations}
  final String? trailingSemanticLabel;

  /// Semantic label for the avatar button.
  ///
  /// Defaults to 'User avatar button'
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// {@macro zeta-widget-translations}
  final String? avatarSemanticLabel;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('platformName', platformName))
      ..add(StringProperty('name', userName))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onHamburgerMenuPressed', onHamburgerMenuPressed))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAvatarButtonPressed', onAvatarButtonPressed))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAppsButtonPressed', onAppsButtonPressed))
      ..add(StringProperty('hamburgerMenuSemanticLabel', leadingSemanticLabel))
      ..add(StringProperty('logoSemanticLabel', logoSemanticLabel))
      ..add(StringProperty('trailingSemanticLabel', trailingSemanticLabel))
      ..add(StringProperty('avatarSemanticLabel', avatarSemanticLabel));
  }

  @override
  Widget build(BuildContext _) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return ZetaThemeOverride(
          themeMode: ThemeMode.dark,
          builder: (context) {
            final zeta = Zeta.of(context);
            final colors = zeta.colors;

            return ZetaRoundedScope(
              rounded: rounded ?? zeta.rounded,

              // Main container (for padding and background color)
              child: Container(
                height: zeta.spacing.small + zeta.spacing.xl_5 + zeta.spacing.small,
                padding: EdgeInsets.symmetric(horizontal: zeta.spacing.large),
                color: colors.surfaceDefault,

                // Main row (for all header content)
                child: Row(
                  spacing: zeta.spacing.large,
                  children: [
                    // Leading icon widget
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: zeta.spacing.xl_6, maxHeight: zeta.spacing.xl_6),
                      child: leading ??
                          ZetaIconButton(
                            icon: ZetaIcons.hamburger_menu,
                            onPressed: onHamburgerMenuPressed,
                            type: ZetaButtonType.subtle,
                            semanticLabel: leadingSemanticLabel,
                          ),
                    ),

                    // Logo
                    if (logo != null)
                      logo!
                    else
                      SvgPicture.asset(
                        'packages/zeta_flutter/assets/logos/zebra-logo.svg',
                        height: zeta.spacing.xl_4,
                        semanticsLabel: 'Zebra Logo',
                        colorFilter: ColorFilter.mode(const ZetaPrimitivesLight().pure.shade0, BlendMode.srcIn),
                      ),

                    // Platform name
                    Text(platformName, style: zeta.textStyles.titleMedium.apply(color: colors.mainDefault)),

                    Expanded(
                      child: Row(
                        children: [
                          if (navItems.isNotEmpty)
                            // Divider
                            Container(
                              key: const Key('divider-menu-items'),
                              width: ZetaBorders.small,
                              height: zeta.spacing.xl_5,
                              color: colors.borderDefault,
                            ),

                          // Nav items
                          // TODO(UX-1520): Remove IntrinsicWidth and replace with better solution
                          Row(
                            children: [
                              for (final item in navItems.take(6)) IntrinsicWidth(child: item.renderSubtle),
                            ],
                          ),

                          // Spacer dividing left and right side of header
                          const Expanded(child: Nothing()),

                          // Search bar
                          if (searchBar != null &&
                              !((navItems.length == 6 && actionItems.length == 6) && constraints.maxWidth <= 1440))
                            Container(
                              constraints:
                                  BoxConstraints(maxWidth: zeta.spacing.xl_8 * 5, minWidth: zeta.spacing.xl_11),
                              margin: EdgeInsets.only(left: zeta.spacing.small),
                              child: (searchBar! is ZetaSearchBar &&
                                      (searchBar! as ZetaSearchBar).size != ZetaWidgetSize.small
                                  ? (searchBar! as ZetaSearchBar).copyWith(
                                      size: ZetaWidgetSize.small,
                                      shape:
                                          rounded ?? zeta.rounded ? ZetaWidgetBorder.rounded : ZetaWidgetBorder.sharp,
                                    )
                                  : searchBar),
                            ),

                          // Action items
                          // TODO(UX-1520): Remove IntrinsicWidth and replace with better solution
                          Row(
                            children: [
                              for (final item in actionItems.take(6)) IntrinsicWidth(child: item.renderSubtle),
                            ],
                          ),
                          // Divider
                          if (actionItems.isNotEmpty)
                            Container(
                              key: const Key('divider-action-items'),
                              width: ZetaBorders.small,
                              height: zeta.spacing.xl_5,
                              color: colors.borderDefault,
                            ),
                        ],
                      ),
                    ),

                    ColoredBox(
                      color: zeta.colors.surfaceDefault,
                      child: Row(
                        children: [
                          // Avatar button
                          ZetaButton(
                            label: userName ?? '',
                            type: ZetaButtonType.subtle,
                            onPressed: onAvatarButtonPressed,
                            trailingIcon: ZetaIcons.expand_more,
                            semanticLabel: avatarSemanticLabel,
                            child: avatar is ZetaAvatar
                                ? (avatar! as ZetaAvatar).copyWith(size: ZetaAvatarSize.xxxs)
                                : ZetaAvatar.fromName(
                                    name: userName ?? '',
                                    size: ZetaAvatarSize.xxxs,
                                    backgroundColor: colors.avatarPurple,
                                  ),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: zeta.spacing.xl_6, maxHeight: zeta.spacing.xl_6),
                            child: trailing ??
                                ZetaIconButton(
                                  icon: ZetaIcons.apps,
                                  onPressed: onAppsButtonPressed,
                                  type: ZetaButtonType.subtle,
                                  semanticLabel: trailingSemanticLabel,
                                ),
                          ),
                        ],
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
}

extension on Widget {
  Widget get renderSubtle {
    if (this is ZetaButton && (this as ZetaButton).type != ZetaButtonType.subtle) {
      return (this as ZetaButton).copyWith(type: ZetaButtonType.subtle);
    } else if (this is ZetaIconButton && (this as ZetaIconButton).type != ZetaButtonType.subtle) {
      return (this as ZetaIconButton).copyWith(type: ZetaButtonType.subtle);
    } else {
      return this;
    }
  }
}
