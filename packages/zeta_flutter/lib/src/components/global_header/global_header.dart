import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

import '../../../zeta_flutter.dart';

class ZetaGlobalHeader extends ZetaStatelessWidget {
  /// Constructor for [ZetaGlobalHeader]
  const ZetaGlobalHeader({
    super.key,
    super.rounded,
    required this.platformName,
    this.navItems = const [],
    this.searchBar = false,
    this.actionItems = const [],
    this.name = 'Name',
    this.initials = 'RK',
    this.appSwitcher = false,
  });

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
  final String name;

  /// Set the initials of the user
  final String initials;

  ///Boolean to show app switcher button or not.
  ///Set to false by default. Set to true to show app switcher button.
  final bool appSwitcher;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('platformName', platformName))
      ..add(ObjectFlagProperty<bool?>('searchBar', searchBar))
      ..add(ObjectFlagProperty<bool?>.has('appSwitcher', appSwitcher))
      ..add(StringProperty('name', name))
      ..add(StringProperty('initials', initials));
  }

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Left side of header
          Row(
            children: [
              ZetaIconButton(
                icon: ZetaIcons.hamburger_menu,
                size: ZetaWidgetSize.small,
                onPressed: () {}, //Create callback
                type: ZetaButtonType.text,
              ),
              SvgPicture.asset(
                'packages/zeta_flutter/assets/logos/zebra-logo.svg',
                height: Zeta.of(context).spacing.xl_4,
              ),
              Text(
                platformName,
                style: Zeta.of(context).textStyles.titleMedium,
              ),
              //Generate nav items
              ...navItems.take(6),
            ],
          ),
          //Right side of header
          Row(
            children: [
              if(searchBar)
                SizedBox(
                  width: 240,
                  child: ZetaSearchBar(size: ZetaWidgetSize.small, showSpeechToText: false),
                ),
              //Action Items
              ...actionItems.take(6),
              ZetaButton(
                label: name,
                type: ZetaButtonType.text,
                size: ZetaWidgetSize.small,
                onPressed: () {}, //Create callback
                trailingIcon: ZetaIcons.expand_more,
                child: ZetaAvatar(
                  initials: initials,
                  size: ZetaAvatarSize.xxxs,
                ),
              ),
              if (appSwitcher)
                ZetaIconButton(
                  icon: ZetaIcons.apps,
                  size: ZetaWidgetSize.small,
                  onPressed: () {}, //Create callback
                  type: ZetaButtonType.text,
                ),
            ],
          ),
        ],
      ),
    );
  }
}


  //      child: Container(
      //   padding: EdgeInsets.symmetric(
      //     vertical: Zeta.of(context).spacing.small,
      //     horizontal: Zeta.of(context).spacing.large,
      //   ),
      //   decoration: BoxDecoration(
      //     color: const ZetaPrimitivesLight().cool.shade100,
      //   ),
      //   child: Row(
      //     children: [
      //       Row(
      //         children: [
      //           ZetaIconButton(
      //             icon: ZetaIcons.hamburger_menu,
      //             onPressed: () {
      //               // Handle menu button press
      //             },
      //           ),
      //           SvgPicture.asset(
      //             'logos/zebra-logo.svg',
      //             height: Zeta.of(context).spacing.xl_4,
      //             colorFilter: const ColorFilter.mode(
      //               Colors.black,
      //               BlendMode.srcIn,
      //             ),
      //           ),
      //           Text(widget.platformName, style: Zeta.of(context).textStyles.titleMedium),
      //           Row(
      //             children:
      //               widget.navItems.isNotEmpty
      //                 ? widget.navItems.take(6).toList()
      //                 : [const SizedBox(width: 1, height: 1)],
      //           ),
      //         ],
      //       ),
      //       Row(
      //       children: [
      //         if(widget.searchBar != null)
      //           ZetaSearchBar(),
      //         if (widget.onAppsButton != null)
      //           ZetaIconButton(
      //             icon: ZetaIcons.star,
      //             onPressed: widget.onAppsButton,
      //           ),
      //         if (widget.avatar != null) widget.avatar!,
      //         if (widget.onAppsButton != null)
      //           ZetaIconButton(
      //             icon: ZetaIcons.apps,
      //             onPressed: widget.onAppsButton,
      //           ),
      //       ],
      //     ),
      //     ],
      //   ),
      // ),

  // Widget _buildTitle() {
  //   return Text(
  //     widget.platformName,
  //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //   );
  // }

  // Widget _buildTabs() {
  //   return Row(
  //     children: widget.navItems.map((item) {
  //       return GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             _selectedIndex = widget.navItems.indexOf(item);
  //           });
  //         },
  //         child: Container(
  //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //           decoration: BoxDecoration(
  //             color: _selectedIndex == widget.navItems.indexOf(item)
  //                 ? Zeta.of(context).colors.primary
  //                 : Colors.transparent,
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: item,
  //         ),
  //       );
  //     }).toList(),
  //   );
  // }

  // Widget _buildAppsButton() {
  //   return IconButton(
  //     icon: const Icon(ZetaIcons.apps),
  //     onPressed: widget.onAppsButton,
  //   );
  // }