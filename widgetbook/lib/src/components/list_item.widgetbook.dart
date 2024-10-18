import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Dropdown List Item',
  type: ZetaDropdownListItem,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=26325-6829&m=dev',
)
Widget dropdownListItem(BuildContext context) => ZetaDropdownListItem(
      primaryText: context.knobs.string(label: 'Primary text', initialValue: 'Label'),
      items: const [
        ZetaListItem(primaryText: 'List Item'),
        ZetaListItem(primaryText: 'List Item'),
        ZetaListItem(primaryText: 'List Item'),
      ],
      secondaryText: context.knobs.string(label: 'Secondary text', initialValue: 'Descriptor'),
      leading: context.knobs.boolean(label: 'Show icon') ? const ZetaIcon(ZetaIcons.star) : null,
      showDivider: context.knobs.boolean(label: 'Show divider'),
    );
