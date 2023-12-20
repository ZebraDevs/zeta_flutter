import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/menu_items.dart';

WidgetbookComponent menuItemsWidgetBook() {
  return WidgetbookComponent(
    name: 'Menu Items',
    useCases: [
      WidgetbookUseCase(
        name: 'Horizontal',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: MenuItemsExample.horizontalExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Vertical',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: MenuItemsExample.verticalExample,
        ),
      ),
    ],
  );
}
