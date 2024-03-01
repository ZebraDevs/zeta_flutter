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
      ZetaNavigationBarItem(
        icon: ZetaIcons.star_round,
        label: 'Label',
        showBadge: true,
        badgeValue: 2,
      ),
      ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
      ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
      ZetaNavigationBarItem(icon: ZetaIcons.star_round, label: 'Label'),
    ];

    return ExampleScaffold(
      name: 'Navigation Bar',
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZetaNavigationBar(items: items, dividerIndex: 3),
            const SizedBox(height: 16),
            ZetaNavigationBar(items: items, splitItems: true),
            const SizedBox(height: 16),
            ZetaNavigationBar(
              items: items,
              action: ZetaButton.primary(
                label: 'Button',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ZetaNavigationBar(
        items: items,
        currentIndex: selectedIndex,
        onTap: (val) => setState(() {
          selectedIndex = val;
        }),
      ),
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //     icon: Icon(ZetaIcons.star_round),
      //     label: 'Label',
      //   ),
      //   BottomNavigationBarItem(
      //     icon: Icon(ZetaIcons.star_round),
      //     label: 'Label',
      //   )
      // ]),
    );
  }
}
