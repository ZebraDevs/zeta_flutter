import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Bottom sheet',
  type: ZetaBottomSheet,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21541-2267&t=6jmGZpLRLKTDIfJL-4',
)
Widget bottomSheet(BuildContext context) {
  final leadingIcon = iconKnob(context, nullable: true, initial: null);
  final trailingIcon = iconKnob(context, nullable: true, initial: ZetaIcons.chevron_right);

  final sheet = ZetaBottomSheet(
    centerTitle: context.knobs.boolean(label: 'Center title', initialValue: true),
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    body: Wrap(
      spacing: Zeta.of(context).spacing.medium,
      runSpacing: Zeta.of(context).spacing.medium,
      children: List.generate(
        6,
        (index) => ZetaMenuItem(
          type: context.knobs.boolean(label: 'Grid') ? ZetaMenuItemType.vertical : ZetaMenuItemType.horizontal,
          leading: leadingIcon != null ? ZetaIcon(leadingIcon) : null,
          trailing: trailingIcon != null ? ZetaIcon(trailingIcon) : null,
          label: const Text('Menu Item'),
          onTap: context.knobs.boolean(label: 'Disabled') ? null : () {},
        ),
      ),
    ),
  );
  return Padding(
    padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
    child: Column(
      children: [
        sheet,
        SizedBox(height: Zeta.of(context).spacing.xl_9),
        ZetaButton.text(
          label: 'Open',
          onPressed: () => showModalBottomSheet(context: context, builder: (_) => sheet),
        )
      ],
    ),
  );
}
