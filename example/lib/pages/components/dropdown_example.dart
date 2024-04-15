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
  ZetaDropdownItem selectedItem = ZetaDropdownItem(
    value: "Item 1",
    leadingIcon: Icon(ZetaIcons.star_round),
  );

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: "Dropdown",
      child: Center(
        child: SingleChildScrollView(
          child: SizedBox(
              width: 320,
              child: Column(children: [
                ZetaDropdown(
                  leadingType: LeadingStyle.checkbox,
                  onChange: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                  selectedItem: selectedItem,
                  items: [
                    ZetaDropdownItem(
                      value: "Item 1",
                      leadingIcon: Icon(ZetaIcons.star_round),
                    ),
                    ZetaDropdownItem(
                      value: "Item 2",
                      leadingIcon: Icon(ZetaIcons.star_half_round),
                    ),
                    ZetaDropdownItem(
                      value: "Item 3",
                    )
                  ],
                ),
                Text('Selected item : ${selectedItem.value}')
              ])),
        ),
      ),
    );
  }
}
