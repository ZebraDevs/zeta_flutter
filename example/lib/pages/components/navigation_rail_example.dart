import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class NavigationRailExample extends StatefulWidget {
  static const String name = 'NavigationRail';

  const NavigationRailExample({Key? key}) : super(key: key);

  @override
  State<NavigationRailExample> createState() => _NavigationRailExampleState();
}

class _NavigationRailExampleState extends State<NavigationRailExample> {
  List<String> _titles = [
    'Label',
    'User Preferences',
    'Account Settings',
    'Label',
  ];
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return SafeArea(
      child: ExampleScaffold(
        name: 'Navigation Rail',
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ZetaNavigationRail(
              selectedIndex: _selectedIndex,
              onSelect: (index) => setState(() => _selectedIndex = index),
              wordWrap: false,
              items: [
                ZetaNavigationRailItem(
                  label: 'Label',
                  icon: ZetaIcon(ZetaIcons.star),
                ),
                ZetaNavigationRailItem(
                  label: 'User\nPreferences',
                  icon: ZetaIcon(ZetaIcons.star),
                ),
                ZetaNavigationRailItem(
                  label: 'Account Settings',
                  icon: ZetaIcon(ZetaIcons.star),
                ),
                ZetaNavigationRailItem(
                  label: 'Label',
                  icon: ZetaIcon(ZetaIcons.star),
                  disabled: true,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
                child: _selectedIndex == null
                    ? const Nothing()
                    : Text(
                        _titles[_selectedIndex!],
                        textAlign: TextAlign.center,
                        style: ZetaTextStyles.titleMedium.copyWith(
                          color: zeta.colors.mainDefault,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
