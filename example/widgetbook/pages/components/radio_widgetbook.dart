import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget radioButtonUseCase(BuildContext context) {
  String option1 = 'Label 1';
  String option2 = 'Label 2';
  String? groupValue;

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        ValueChanged<String?>? onChanged =
            !disabledKnob(context) ? (value) => setState(() => groupValue = value) : null;
        return Padding(
          padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: Zeta.of(context).spacing.xl),
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
