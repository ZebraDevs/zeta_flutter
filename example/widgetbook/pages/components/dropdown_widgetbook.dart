import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget dropdownUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Center(
        child: DropdownExample(context),
      ),
    );

class DropdownExample extends StatefulWidget {
  const DropdownExample(this.c);
  final BuildContext c;

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  List<ZetaDropdownItem> _children = [
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
  ];

  late ZetaDropdownItem selectedItem = ZetaDropdownItem(
    value: "Item 1",
    leadingIcon: Icon(ZetaIcons.star_round),
  );

  @override
  Widget build(BuildContext _) {
    return SingleChildScrollView(
      child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            ZetaDropdown(
              leadingType: widget.c.knobs.list(
                label: "Checkbox type",
                options: [
                  LeadingStyle.none,
                  LeadingStyle.checkbox,
                  LeadingStyle.radio,
                ],
              ),
              onChange: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              selectedItem: selectedItem,
              items: _children,
              rounded: widget.c.knobs.boolean(label: "Rounded"),
              isMinimized: widget.c.knobs.boolean(label: "Minimized"),
            ),
            Text('Selected item : ${selectedItem.value}')
          ])),
    );
  }
}
