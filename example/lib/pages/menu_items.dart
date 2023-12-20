import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class MenuItemsExample extends StatelessWidget {
  static const String name = 'MenuItems';

  const MenuItemsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ExampleScaffold(
          name: MenuItemsExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.s),
            child: Column(
              children: [
                Text('Horizontal'),
                const SizedBox(height: 20),
                horizontalExample,
                const SizedBox(height: 50),
                Text('Vertical'),
                const SizedBox(height: 20),
                verticalExample,
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget get horizontalExample => Column(
        children: [
          ZetaMenuItem.horizontal(
            label: Text('Menu Item'),
            onTap: () {},
          ),
          ZetaMenuItem.horizontal(
            label: Text('Menu Item'),
            leadingIcon: Icon(ZetaIcons.star_round),
            onTap: () {},
          ),
          ZetaMenuItem.horizontal(
            label: Text('Menu Item'),
            showTrailing: true,
            onTap: () {},
          ),
          ZetaMenuItem.horizontal(
            label: Text('Menu Item'),
            trailingIcon: Icon(Icons.fast_forward),
            onTap: () {},
          ),
          ZetaMenuItem.horizontal(
            label: Text('Menu Item'),
            leadingIcon: Icon(ZetaIcons.phone_android_round),
            showTrailing: true,
            onTap: () {},
          ),
          ZetaMenuItem.horizontal(
            label: Text('Disabled Menu Item'),
            leadingIcon: Icon(ZetaIcons.home_round),
            showTrailing: true,
            disabled: true,
            onTap: () {},
          ),
        ],
      );

  static Widget get verticalExample => Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          ZetaMenuItem.vertical(
            label: Text('Menu Item'),
            icon: Icon(ZetaIcons.star_round),
            onTap: () {},
          ),
          ZetaMenuItem.vertical(
            label: Text('Menu Item'),
            icon: Icon(ZetaIcons.star_sharp),
            onTap: () {},
          ),
          ZetaMenuItem.vertical(
            label: Text('Menu Item'),
            icon: Icon(ZetaIcons.home_round),
            onTap: () {},
          ),
          ZetaMenuItem.vertical(
            label: Text('Menu Item'),
            icon: Icon(ZetaIcons.star_round),
            onTap: () {},
            disabled: true,
          ),
          ZetaMenuItem.vertical(
            label: Text('Menu Item'),
            icon: Icon(ZetaIcons.star_sharp),
            onTap: () {},
            disabled: true,
          ),
          ZetaMenuItem.vertical(
            label: Text('Menu Item'),
            icon: Icon(ZetaIcons.home_round),
            onTap: () {},
            disabled: true,
          ),
        ],
      );
}
