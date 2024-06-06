import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget dropdownUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Center(
        child: DropdownExample(),
      ),
    );

class DropdownExample extends StatefulWidget {
  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
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

  @override
  Widget build(BuildContext context) {
    return ZetaDropdown(
      type: context.knobs.list(
        label: "Dropdown type",
        options: ZetaDropdownMenuType.values,
        labelBuilder: enumLabelBuilder,
      ),
      onChange: disabledKnob(context) ? null : (value) {},
      items: items,
      rounded: context.knobs.boolean(label: "Rounded"),
      size: context.knobs.list(
        label: 'Size',
        options: ZetaDropdownSize.values,
        labelBuilder: enumLabelBuilder,
      ),
    );
  }
}
