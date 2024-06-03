import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget bottomSheetContentUseCase(BuildContext context) {
  final sheet = _bottomSheet(context);

  return WidgetbookTestWidget(
    widget: Padding(
      padding: const EdgeInsets.all(ZetaSpacing.xL),
      child: Column(
        children: [
          sheet,
          const SizedBox(height: ZetaSpacing.xL9),
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
  final bool rounded = roundedKnob(context);
  final leadingIcon = iconKnob(context, rounded: rounded, nullable: true, initial: null);
  final trailingIcon = iconKnob(context, rounded: rounded, nullable: true, initial: ZetaIcons.chevron_right_round);

  return ZetaBottomSheet(
    centerTitle: context.knobs.boolean(label: 'Center title', initialValue: true),
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    body: Wrap(
      spacing: ZetaSpacing.medium,
      runSpacing: ZetaSpacing.medium,
      children: List.generate(
        6,
        (index) => ZetaMenuItem(
          type: context.knobs.boolean(label: 'Grid') ? ZetaMenuItemType.vertical : ZetaMenuItemType.horizontal,
          leading: leadingIcon != null ? Icon(leadingIcon) : null,
          trailing: trailingIcon != null ? Icon(trailingIcon) : null,
          label: Text('Menu Item'),
          onTap: context.knobs.boolean(label: 'Disabled') ? null : () {},
        ),
      ),
    ),
  );
}
