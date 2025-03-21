import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class NavigationBarExample extends StatefulWidget {
  static const String name = 'NavigationBar';

  const NavigationBarExample({super.key});

  @override
  State<NavigationBarExample> createState() => _NavigationBarExampleState();
}

class _NavigationBarExampleState extends State<NavigationBarExample> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final items = [
      ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label', badge: ZetaIndicator(value: 2)),
      ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label'),
      ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label'),
      ZetaNavigationBarItem(icon: ZetaIcons.star, label: 'Label'),
    ];

    return ExampleScaffold(
      name: NavigationBarExample.name,
      paddingAll: 0,
      children: [
        ZetaNavigationBar.divided(items: items, dividerIndex: 3, key: Key('docs-navigation-bar-divider')),
        ZetaNavigationBar.split(items: items, key: Key('docs-navigation-bar-split')),
        ZetaNavigationBar.action(
          items: items,
          action: ZetaButton.primary(label: 'Button', onPressed: () {}),
          key: Key('docs-navigation-bar-action'),
        ),
      ],
      bottomNavigationBar: ZetaNavigationBar(
        items: items,
        currentIndex: selectedIndex,
        onTap: (val) => setState(() {
          selectedIndex = val;
        }),
      ),
    );
  }
}
