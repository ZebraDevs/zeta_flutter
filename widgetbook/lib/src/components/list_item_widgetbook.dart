import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String listItemPath = '$componentsPath/List Item';

@widgetbook.UseCase(
  name: 'List Item',
  type: ZetaListItem,
  path: listItemPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=N8coJ9AFu6DS3mOF-4',
)
Widget listItem(BuildContext context) {
  final showIcon = iconKnob(context, name: 'Leading icon', nullable: true);

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
  path: listItemPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=N8coJ9AFu6DS3mOF-4',
)
Widget checkbox(BuildContext context) {
  var checkedValue = false;

  return StatefulBuilder(
    builder: (context, setState) {
      final showIcon = iconKnob(context, name: 'Leading icon', nullable: true);

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
  path: listItemPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=N8coJ9AFu6DS3mOF-4',
)
Widget toggle(BuildContext context) {
  var checkedValue = false;

  return StatefulBuilder(
    builder: (context, setState) {
      final showIcon = iconKnob(context, name: 'Leading icon', nullable: true);

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
  path: listItemPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&t=N8coJ9AFu6DS3mOF-4',
)
Widget radio(BuildContext context) {
  String checkedValue = 'A';

  return StatefulBuilder(
    builder: (context, setState) {
      final showIcon = iconKnob(context, name: 'Leading icon', nullable: true);

      return ZetaListItem.radio(
        primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
        secondaryText: context.knobs.stringOrNull(label: 'Secondary text', initialValue: 'Descriptor'),
        leading: showIcon != null ? ZetaIcon(showIcon) : null,
        showDivider: context.knobs.boolean(label: 'Show divider'),
        groupValue: 'A',
        onChanged: (value) => setState(() => checkedValue = (value == 'A' ? 'B' : 'A')),
        value: checkedValue,
      );
    },
  );
}

@widgetbook.UseCase(
  name: 'Dropdown List Item',
  type: ZetaDropdownListItem,
  path: listItemPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26522-37745&t=N8coJ9AFu6DS3mOF-4',
)
Widget dropdownListItem(BuildContext context) => SmallContentWrapper(
      child: ZetaDropdownListItem(
        primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
        items: const [
          ZetaListItem(primaryText: 'List Item'),
          ZetaListItem(primaryText: 'List Item'),
          ZetaListItem(primaryText: 'List Item'),
        ],
        secondaryText: context.knobs.string(label: 'Secondary text', initialValue: 'Descriptor'),
        leading: context.knobs.boolean(label: 'Show icon') ? const ZetaIcon(ZetaIcons.star) : null,
        showDivider: context.knobs.boolean(label: 'Show divider'),
      ),
    );
