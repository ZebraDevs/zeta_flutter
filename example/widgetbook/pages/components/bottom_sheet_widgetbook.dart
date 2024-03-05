import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget bottomSheetContentUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: const EdgeInsets.all(20),
        child: _bottomSheet(context),
      ),
    );

Widget bottomSheetLiveUseCase(BuildContext context) {
  final sheet = _bottomSheet(context);
  return WidgetbookTestWidget(
    widget: ElevatedButton(
      child: Text('Open'),
      onPressed: () {
        showModalBottomSheet(context: context, builder: (_) => sheet);
      },
    ),
  );
}

ZetaBottomSheet _bottomSheet(BuildContext context) {
  return ZetaBottomSheet(
    centerTitle: context.knobs.boolean(label: 'Center title', initialValue: true),
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(
        6,
        (index) => ZetaMenuItem(
          type: context.knobs.boolean(label: 'Grid') ? ZetaMenuItemType.vertical : ZetaMenuItemType.horizontal,
          leading: context.knobs.boolean(label: 'Leading Icon') ? Icon(ZetaIcons.star_round) : null,
          trailing: context.knobs.boolean(label: 'Trailing Icon') ? Icon(ZetaIcons.chevron_right_round) : null,
          label: Text('Menu Item'),
          onTap: context.knobs.boolean(label: 'Disabled') ? null : () {},
        ),
      ),
    ),
  );
}
