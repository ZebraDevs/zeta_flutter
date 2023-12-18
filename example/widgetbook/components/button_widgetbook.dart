import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/button_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent buttonWidgetBook() {
  return WidgetbookComponent(
    name: 'Button',
    useCases: [
      WidgetbookUseCase(
        name: 'Button Rounded',
        builder: (context) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: roundedButtonsExample(BuildExampleButtonColors(theme: Zeta.of(context))),
        ),
      ),
      WidgetbookUseCase(
        name: 'Button Sharp',
        builder: (context) => SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: sharpButtonsExample(BuildExampleButtonColors(theme: Zeta.of(context))),
        ),
      ),
    ],
  );
}
