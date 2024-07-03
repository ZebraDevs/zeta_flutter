import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ListExample extends StatelessWidget {
  static const name = 'List';

  const ListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'List',
      child: ZetaList(
        showDivider: true,
        items: [
          ZetaListItem(primaryText: 'Item 1'),
          ZetaListItem(primaryText: 'Item 2'),
          ZetaDropdownListItem(
            primaryText: 'Item 3',
            leading: ZetaIcon(ZetaIcons.star),
            expanded: true,
            items: [
              ZetaListItem.checkbox(
                primaryText: 'Dropdown Item 1',
                onChanged: (_) {},
              ),
              ZetaListItem.checkbox(
                primaryText: 'Dropdown Item 2',
                onChanged: (_) {},
              ),
              ZetaListItem.checkbox(
                primaryText: 'Dropdown Item 3',
                onChanged: (_) {},
              ),
            ],
          ),
          ZetaListItem(primaryText: 'Item 4', showDivider: true),
          ZetaListItem(primaryText: 'Item 5'),
          ZetaListItem(primaryText: 'Item 6'),
        ],
      ),
    );
  }
}
