import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Button Group',
  type: ZetaButtonGroup,
  path: '$componentsPath/Button Group',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23116-95148&t=N8coJ9AFu6DS3mOF-4',
)
Widget buttonGroup(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: ZetaButtonGroup(
      isLarge: context.knobs.boolean(label: 'Large'),
      isInverse: context.knobs.boolean(label: 'Inverse'),
      buttons: List.generate(
        context.knobs.int.slider(label: 'Buttons', min: 1, max: 10, initialValue: 3),
        (index) => ZetaGroupButton(
          onPressed: disabledKnob(context) ? null : () {},
          label: '${context.knobs.string(label: 'Label', initialValue: 'Label')} $index',
          icon: iconKnob(context, nullable: true, initial: ZetaIcons.star),
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Group Button',
  type: ZetaGroupButton,
  path: '$componentsPath/Button Group',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23116-95148&t=N8coJ9AFu6DS3mOF-4',
)
Widget groupButton(BuildContext context) {
  final onPressed = disabledKnob(context) ? null : () {};
  final label = context.knobs.string(label: 'Label', initialValue: 'Label');
  final icon = iconKnob(context, nullable: true, initial: ZetaIcons.star);

  final dropdownItems = List.generate(
      context.knobs.intOrNull.slider(label: 'Dropdown items', min: 1, max: 10, initialValue: 3) ?? 0,
      (index) => ZetaDropdownItem(value: 'Item $index', icon: const ZetaIcon(ZetaIcons.star)));

  return dropdownItems.isNotEmpty
      ? ZetaGroupButton.dropdown(
          label: label,
          icon: icon,
          onChange: onPressed == null ? null : (value) => {},
          items: dropdownItems,
        )
      : ZetaGroupButton(label: label, onPressed: onPressed, icon: icon);
}
