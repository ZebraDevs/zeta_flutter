import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/accordion_example.dart';

WidgetbookComponent accordionWidgetBook() {
  return WidgetbookComponent(
    name: 'Accordion',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AccordionExample.accordionDefaultExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Contained',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AccordionExample.accordionContainedExample,
        ),
      ),
      WidgetbookUseCase(
        name: 'Sharp',
        builder: (context) => Padding(
          padding: const EdgeInsets.all(20),
          child: AccordionExample.accordionSharpExample,
        ),
      ),
    ],
  );
}
