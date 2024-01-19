import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

WidgetbookComponent checkboxWidgetBook() {
  return WidgetbookComponent(
    isInitiallyExpanded: false,
    name: 'Checkbox',
    useCases: [
      WidgetbookUseCase(
        name: 'Checkbox',
        builder: (context) => TestWidget(
          widget: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ZetaCheckbox(
                  value: context.knobs.booleanOrNull(label: 'Checked'),
                  onChanged: (_) {},
                  borderType: context.knobs.boolean(label: 'Rounded') ? BorderType.rounded : BorderType.sharp,
                  isEnabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
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
