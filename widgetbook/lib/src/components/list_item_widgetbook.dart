import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'List Item ',
  type: ZetaListItem,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=9UKEEDe1Zek0JZal-4',
)
Widget listItem(BuildContext context) {
  final showIcon = iconKnob(context, name: 'Leading icon', nullable: true, initial: null);

  return ZetaListItem(
    primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
    secondaryText: context.knobs.stringOrNull(label: 'Secondary text', initialValue: 'Descriptor'),
    leading: showIcon != null ? ZetaIcon(showIcon) : null,
    showDivider: context.knobs.boolean(label: 'Show divider'),
  );
}

@widgetbook.UseCase(
  name: 'Checkbox',
  type: ZetaListItem,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=9UKEEDe1Zek0JZal-4',
)
Widget checkbox(BuildContext context) {
  bool checkedValue = false;

  return StatefulBuilder(
    builder: (context, setState) {
      final showIcon = iconKnob(context, name: 'Leading icon', nullable: true, initial: null);

      return ZetaListItem.checkbox(
        primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
        secondaryText: context.knobs.stringOrNull(label: 'Secondary text', initialValue: 'Descriptor'),
        leading: showIcon != null ? ZetaIcon(showIcon) : null,
        showDivider: context.knobs.boolean(label: 'Show divider'),
        onChanged: (bool? value) => setState(() => checkedValue = value!),
        value: checkedValue,
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Toggle',
  type: ZetaListItem,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=9UKEEDe1Zek0JZal-4',
)
Widget toggle(BuildContext context) {
  bool checkedValue = false;

  return StatefulBuilder(
    builder: (context, setState) {
      final showIcon = iconKnob(context, name: 'Leading icon', nullable: true, initial: null);

      return ZetaListItem.toggle(
        primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
        secondaryText: context.knobs.stringOrNull(label: 'Secondary text', initialValue: 'Descriptor'),
        leading: showIcon != null ? ZetaIcon(showIcon) : null,
        showDivider: context.knobs.boolean(label: 'Show divider'),
        onChanged: (bool? value) => setState(() => checkedValue = value!),
        value: checkedValue,
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Radio',
  type: ZetaListItem,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=9UKEEDe1Zek0JZal-4',
)
Widget radio(BuildContext context) {
  bool checkedValue = false;

  return StatefulBuilder(
    builder: (context, setState) {
      final showIcon = iconKnob(context, name: 'Leading icon', nullable: true, initial: null);

      return ZetaListItem.radio(
        primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
        secondaryText: context.knobs.stringOrNull(label: 'Secondary text', initialValue: 'Descriptor'),
        leading: showIcon != null ? ZetaIcon(showIcon) : null,
        showDivider: context.knobs.boolean(label: 'Show divider'),
        onChanged: (_) {},
        value: checkedValue,
      );
    },
  );
}
