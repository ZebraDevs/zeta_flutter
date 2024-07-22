import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ListExample extends StatefulWidget {
  static const name = 'List';

  const ListExample({super.key});

  @override
  State<ListExample> createState() => _ListExampleState();
}

class _ListExampleState extends State<ListExample> {
  List dropdownSelected = [];

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
                onChanged: (_) {
                  setState(() => dropdownSelected.contains(1) ? dropdownSelected.remove(1) : dropdownSelected = [1]);
                },
                value: dropdownSelected.contains(1),
              ),
              ZetaListItem.checkbox(
                primaryText: 'Dropdown Item 2',
                onChanged: (_) {
                  setState(() => dropdownSelected.contains(2) ? dropdownSelected.remove(2) : dropdownSelected = [2]);
                },
                value: dropdownSelected.contains(2),
              ),
              ZetaListItem.checkbox(
                primaryText: 'Dropdown Item 3',
                onChanged: (_) {
                  setState(() => dropdownSelected.contains(3) ? dropdownSelected.remove(3) : dropdownSelected = [3]);
                },
                value: dropdownSelected.contains(3),
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
