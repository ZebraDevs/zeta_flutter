import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Dropdown Menu',
  type: ZetaDropdown,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22664-32734&m=dev',
)
Widget dropdown(BuildContext context) => ZetaDropdown(
      type: context.knobs.list(
        label: 'Dropdown type',
        options: ZetaDropdownMenuType.values,
        labelBuilder: enumLabelBuilder,
      ),
      onChange: disabledKnob(context) ? null : (value) {},
      items: [
        ZetaDropdownItem(value: 'Item 1', icon: const ZetaIcon(ZetaIcons.star)),
        ZetaDropdownItem(value: 'Item 2', icon: const ZetaIcon(ZetaIcons.star_half)),
        ZetaDropdownItem(value: 'Item 3'),
      ],
      size: context.knobs.list(
        label: 'Size',
        options: ZetaDropdownSize.values,
        labelBuilder: enumLabelBuilder,
      ),
    );
