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
        icon: Icon(ZetaIcons.star_round),
      ),
      ZetaDropdownItem(
        value: "Item 2",
        icon: Icon(ZetaIcons.star_half_round),
      ),
      ZetaDropdownItem(
        value: "Item 3",
      )
    ];

    return ExampleScaffold(
      name: "Dropdown",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ZetaDropdown(
                  disabled: true,
                  type: ZetaDropdownMenuType.standard,
                  onChange: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                  selectedItem: selectedItem,
                  items: items,
                ),
                Text('Selected item : ${selectedItem}')
              ],
            ),
          ),
          ZetaDropdown(
            items: items,
            selectedItem: selectedItem,
            type: ZetaDropdownMenuType.checkbox,
          ),
          ZetaDropdown(
            items: items,
            selectedItem: selectedItem,
            size: ZetaDropdownSize.mini,
            type: ZetaDropdownMenuType.radio,
          ),
        ],
      ),
    );
  }
}
