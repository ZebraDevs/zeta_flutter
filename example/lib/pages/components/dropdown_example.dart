import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class DropdownExample extends StatefulWidget {
  static const String name = "Dropdown";
  const DropdownExample({super.key});

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  String selectedItem = "Item 1";

  @override
  Widget build(BuildContext context) {
    final items = [
      ZetaDropdownItem(
        value: "Item 1",
        icon: ZetaIcon(ZetaIcons.star),
      ),
      ZetaDropdownItem(
        value: "Item 2",
        icon: ZetaIcon(ZetaIcons.star_half),
      ),
      ZetaDropdownItem(
        value: "Item 3",
      )
    ];

    return ExampleScaffold(
      name: "Dropdown",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ZetaDropdown(
            items: items,
            value: selectedItem,
            type: ZetaDropdownMenuType.checkbox,
          ),
          ZetaDropdown(
            items: items,
            value: selectedItem,
            size: ZetaDropdownSize.mini,
            onChange: (_) {},
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ZetaDropdown(
                  type: ZetaDropdownMenuType.standard,
                  onChange: (_) {},
                  value: selectedItem,
                  items: items,
                ),
                Text('Selected item : ${selectedItem}')
              ],
            ),
          ),
          ZetaDropdown(
            items: items,
            value: selectedItem,
            onChange: (_) {},
            type: ZetaDropdownMenuType.checkbox,
          ),
          ZetaDropdown(
            items: items,
            value: selectedItem,
            onChange: (_) {},
            size: ZetaDropdownSize.mini,
            type: ZetaDropdownMenuType.radio,
          ),
        ],
      ),
    );
  }
}
