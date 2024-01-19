import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent accordionWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Accordion',
    useCases: [
      WidgetbookUseCase(
        name: 'Accordian',
        builder: (context) => TestWidget(
          themeMode: ThemeMode.dark,
          widget: Padding(
            padding: const EdgeInsets.all(20),
            child: ZetaAccordion(
              children: [
                ZetaAccordionSection(
                  title: Text(context.knobs.string(label: 'Accordion Title', initialValue: 'Title')),
                  disabled: context.knobs.boolean(label: 'Disabled', initialValue: false),
                  contained: context.knobs.boolean(label: 'Contained', initialValue: false),
                  isOpen: context.knobs.boolean(label: 'Open', initialValue: false),
                  rounded: context.knobs.boolean(label: 'Rounded', initialValue: false),
                  body: Column(
                    children: [
                      ListTile(title: Text('Item One')),
                      ListTile(title: Text('Item  two')),
                      ListTile(title: Text('Item three')),
                      ListTile(title: Text('Item four')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
