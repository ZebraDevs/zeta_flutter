import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget radioButtonUseCase(BuildContext context) {
  String option1 = 'Label 1';
  String option2 = 'Label 2';
  String? groupValue;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        ValueChanged<String?>? onChanged =
            !disabledKnob(context) ? (value) => setState(() => groupValue = value) : null;
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.x5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: ZetaSpacing.x5),
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
