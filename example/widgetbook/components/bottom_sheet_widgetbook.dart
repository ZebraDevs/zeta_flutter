import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/bottom_sheet.dart';

WidgetbookComponent bottomSheetWidgetBook() {
  return WidgetbookComponent(
    name: 'Bottom Sheet',
    useCases: [
      WidgetbookUseCase(
        name: 'Centered title',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: BottomSheetExample.bottomSheet(context),
        ),
      ),
      WidgetbookUseCase(
        name: 'Title aligned left',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: BottomSheetExample.bottomSheet(context, Alignment.centerLeft),
        ),
      ),
    ],
  );
}
