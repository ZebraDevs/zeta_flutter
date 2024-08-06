import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget bottomSheetContentUseCase(BuildContext context) {
  final sheet = _bottomSheet(context);

  return WidgetbookScaffold(
    builder: (context, _) => Padding(
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
    ),
  );
}

ZetaBottomSheet _bottomSheet(BuildContext context) {
  final leadingIcon = iconKnob(context, nullable: true, initial: null);
  final trailingIcon = iconKnob(context, nullable: true, initial: ZetaIcons.chevron_right);

  return ZetaBottomSheet(
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
          label: Text('Menu Item'),
          onTap: context.knobs.boolean(label: 'Disabled') ? null : () {},
        ),
      ),
    ),
  );
}
