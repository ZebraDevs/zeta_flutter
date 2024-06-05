import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget selectInputUseCase(BuildContext context) {
  final zeta = Zeta.of(context);
  final items = [
    ZetaSelectInputItem(value: 'Item 1'),
    ZetaSelectInputItem(value: 'Item 2'),
    ZetaSelectInputItem(value: 'Item 3'),
    ZetaSelectInputItem(value: 'Item 4'),
    ZetaSelectInputItem(value: 'Item 5'),
    ZetaSelectInputItem(value: 'Item 6'),
    ZetaSelectInputItem(value: 'Item 7'),
    ZetaSelectInputItem(value: 'Item 8'),
    ZetaSelectInputItem(value: 'Item 9'),
    ZetaSelectInputItem(value: 'Item 10'),
    ZetaSelectInputItem(value: 'Item 11'),
    ZetaSelectInputItem(value: 'Item 12'),
  ];
  late ZetaSelectInputItem? selectedItem = items.first;
  String? _errorText;
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Label',
  );
  final hint = context.knobs.string(
    label: 'Hint',
    initialValue: 'Default hint text',
  );
  final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  final required = context.knobs.boolean(label: 'Required', initialValue: true);
  final size = context.knobs.list<ZetaWidgetSize>(
    label: 'Size',
    options: ZetaWidgetSize.values,
    labelBuilder: (size) => size.name,
  );
  final iconData = iconKnob(
    context,
    name: "Icon",
    rounded: rounded,
    initial: rounded ? ZetaIcons.star_round : ZetaIcons.star_sharp,
  );

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.xL2),
          child: ZetaSelectInput(
            rounded: rounded,
            enabled: enabled,
            size: size,
            label: Row(
              children: [
                Text(label),
                if (required)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Text(
                      '*',
                      style: TextStyle(color: zeta.colors.red.shade60),
                    ),
                  ),
              ],
            ),
            hint: hint,
            leadingIcon: Icon(iconData),
            hasError: _errorText != null,
            errorText: _errorText,
            onChanged: (item) {
              setState(() {
                selectedItem = item;
                if (item != null) {
                  _errorText = null;
                }
              });
            },
            onTextChanged: (value) {
              setState(() {
                if (required && value.isEmpty) {
                  _errorText = 'Required';
                } else {
                  _errorText = null;
                }
              });
            },
            selectedItem: selectedItem,
            items: items,
          ),
        );
      },
    ),
  );
}
