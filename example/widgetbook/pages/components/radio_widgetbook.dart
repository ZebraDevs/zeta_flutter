import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget radioButtonUseCase(BuildContext context) {
  String option1 = 'Label 1';
  String option2 = 'Label 2';
  String? groupValue;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        ValueChanged<String?>? onChanged = context.knobs.boolean(label: 'Enabled', initialValue: true)
            ? (value) => setState(() => groupValue = value)
            : null;
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.xL),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: ZetaSpacing.xL),
                child: Text('Radio Button'),
              ),
              ZetaRadio<String>(
                value: option1,
                groupValue: groupValue,
                onChanged: onChanged,
                label: Text(option1),
              ),
              ZetaRadio<String>(
                value: option2,
                groupValue: groupValue,
                onChanged: onChanged,
                label: Text(option2),
              ),
            ],
          ),
        );
      },
    ),
  );
}
