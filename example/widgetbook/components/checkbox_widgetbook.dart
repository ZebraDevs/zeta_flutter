import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../test/test_components.dart';

WidgetbookComponent checkboxWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Checkbox',
    useCases: [
      WidgetbookUseCase(
        name: 'Checkbox',
        builder: (context) => WidgetbookTestWidget(
          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ZetaCheckbox(
                  value: context.knobs.booleanOrNull(label: 'Checked'),
                  onChanged: context.knobs.boolean(label: 'Enabled', initialValue: true) ? (_) {} : null,
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  label: context.knobs.string(label: 'Label', initialValue: 'Checkbox'),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
