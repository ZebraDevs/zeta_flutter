import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class GlobalHeaderExample extends StatelessWidget {
  static final name = "GlobalHeader";
  const GlobalHeaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: "Global Header", children: [
      ZetaGlobalHeader(
        platformName: "Platform Name",
        navItems: [
          ZetaDropdown(
            onChange: (value) {},
            value: "Menu 1",
            items: [
              ZetaDropdownItem(value: "item1", label: "Menu 1"),
              ZetaDropdownItem(value: "item2", label: "Menu 2"),
            ],
          ),
          ZetaDropdown(
            onChange: (value) {},
            value: "Menu 2",
            items: [
              ZetaDropdownItem(value: "item1", label: "Menu 1"),
              ZetaDropdownItem(value: "item2", label: "Menu 2"),
            ],
          ),
        ],
        searchBar: true,
        actionItems: [
          ZetaIconButton(
            icon: ZetaIcons.star,
            type: ZetaButtonType.text,
            size: ZetaWidgetSize.small,
            onPressed: () {},
          ),
          ZetaIconButton(
            icon: ZetaIcons.star,
            type: ZetaButtonType.text,
            size: ZetaWidgetSize.small,
            onPressed: () {},
          ),
        ],
        name: "Name",
        initials: "RK",
        appSwitcher: true,
        onHamburgerMenuPressed: () {},
        onAppsButtonPressed: () {},
        onAvatarButtonPressed: () {},
      ),
    ]);
  }
}
