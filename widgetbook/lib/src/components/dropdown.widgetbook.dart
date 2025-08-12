import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Dropdown Menu',
  type: ZetaDropdown,
  path: '$componentsPath/Dropdown Menu',
  designLink: 'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22664-33552',
)
Widget dropdown(BuildContext context) => SmallContentWrapper(
      child: ZetaDropdown(
        type: context.knobs.object.dropdown(
          label: 'Dropdown type',
          options: ZetaDropdownMenuType.values,
          labelBuilder: enumLabelBuilder,
        ),
        onChange: disabledKnob(context) ? null : (value) {},
        items: List.generate(
          context.knobs.int.slider(label: 'Items', min: 1, max: 10, initialValue: 3),
          (index) => ZetaDropdownItem(
            value: 'Item $index',
            icon: index.isEven ? const Icon(ZetaIcons.star) : null,
          ),
        ),
        size: context.knobs.object
            .dropdown(label: 'Size', options: ZetaDropdownSize.values, labelBuilder: enumLabelBuilder),
      ),
    );
