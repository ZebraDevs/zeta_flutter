import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

// TODO(thelukewalton): Add better defaults
@widgetbook.UseCase(
  name: 'Button Group',
  type: ZetaButtonGroup,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23132-166632&t=6jmGZpLRLKTDIfJL-4',
)
Widget buttonGroup(BuildContext context) {
  final onPressed = disabledKnob(context) ? null : () {};
  final label = context.knobs.string(label: 'Label', initialValue: 'Label');
  final icon = iconKnob(context, nullable: true, initial: ZetaIcons.star);
  return ZetaButtonGroup(
    isLarge: context.knobs.boolean(label: 'Large'),
    isInverse: context.knobs.boolean(label: 'Inverse'),
    buttons: [
      ZetaGroupButton(
        label: label,
        onPressed: onPressed,
        icon: icon,
      ),
      ZetaGroupButton.dropdown(
        label: label,
        onChange: disabledKnob(context) ? null : (_) {},
        icon: icon,
        items: [
          ZetaDropdownItem(value: 'Item 1', icon: const ZetaIcon(ZetaIcons.star)),
          ZetaDropdownItem(value: 'Item 2', icon: const ZetaIcon(ZetaIcons.star_half)),
        ],
      ),
      ZetaGroupButton(
        label: label,
        onPressed: onPressed,
        icon: icon,
      ),
    ],
  );
}

// TODO(Luke): test this
@widgetbook.UseCase(
  name: 'Group Button',
  type: ZetaGroupButton,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23116-95619&t=6jmGZpLRLKTDIfJL-4',
)
Widget groupButton(BuildContext context) {
  final onPressed = disabledKnob(context) ? null : () {};
  final label = context.knobs.string(label: 'Label');
  final icon = iconKnob(context, nullable: true);
  final dropdown = context.knobs.boolean(label: 'Dropdown');

  return dropdown
      ? ZetaGroupButton.dropdown(
          label: label,
          icon: icon,
          items: [
            ZetaDropdownItem(value: 'Item 1', icon: const ZetaIcon(ZetaIcons.star)),
            ZetaDropdownItem(value: 'Item 2', icon: const ZetaIcon(ZetaIcons.star_half)),
          ],
        )
      : ZetaGroupButton(
          label: label,
          onPressed: onPressed,
          icon: icon,
        );
}
