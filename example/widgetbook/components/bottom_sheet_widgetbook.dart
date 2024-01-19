import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent bottomSheetWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Bottom Sheet',
    useCases: [
      WidgetbookUseCase(
        name: 'Content',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: _bottomSheet(context),
          ),
        ),
      ),
      WidgetbookUseCase(
        name: 'Live',
        builder: (context) {
          final sheet = _bottomSheet(context);
          return TestWidget(
            widget: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                child: Text('Open'),
                onPressed: () {
                  showModalBottomSheet(context: context, builder: (_) => sheet);
                },
              ),
            ),
          );
        },
      ),
    ],
  );
}

ZetaBottomSheet _bottomSheet(BuildContext context) {
  return ZetaBottomSheet(
    titleAlignment: context.knobs.boolean(label: 'Center align header') ? Alignment.center : Alignment.centerLeft,
    title: context.knobs.string(label: 'Title', initialValue: 'Title'),
    body: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(
        6,
        (index) => ZetaMenuItem(
          type: context.knobs.boolean(label: 'Grid') ? ZetaMenuItemType.vertical : ZetaMenuItemType.horizontal,
          leadingIcon: context.knobs.boolean(label: 'Leading Icon') ? Icon(ZetaIcons.star_round) : null,
          trailingIcon: context.knobs.boolean(label: 'Trailing Icon') ? Icon(ZetaIcons.chevron_right_round) : null,
          label: Text('Menu Item'),
          onTap: () {},
          disabled: context.knobs.boolean(label: 'Disabled'),
        ),
      ),
    ),
  );
}
