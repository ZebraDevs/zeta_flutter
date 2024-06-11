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
                  icon: Icon(ZetaIcons.star_round),
                ),
                ZetaNavigationRailItem(
                  label: 'User\nPreferences',
                  icon: Icon(ZetaIcons.star_round),
                ),
                ZetaNavigationRailItem(
                  label: 'Account Settings',
                  icon: Icon(ZetaIcons.star_round),
                ),
                ZetaNavigationRailItem(
                  label: 'Label',
                  icon: Icon(ZetaIcons.star_round),
                  disabled: true,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(ZetaSpacing.xl_1),
                child: _selectedIndex == null
                    ? const SizedBox()
                    : Text(
                        _titles[_selectedIndex!],
                        textAlign: TextAlign.center,
                        style: ZetaTextStyles.titleMedium.copyWith(
                          color: zeta.colors.textDefault,
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
