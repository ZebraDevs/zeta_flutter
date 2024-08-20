import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget switchUseCase(BuildContext context) {
  bool? isOn = false;

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        ValueChanged<bool?>? onChanged = !disabledKnob(context) ? (value) => setState(() => isOn = value) : null;
        return Padding(
          padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
          child: Column(
            children: [
              Text('Switch'),
              ZetaSwitch(
                value: isOn,
                onChanged: onChanged,
                variant: context.knobs.listOrNull(
                  label: 'Variant',
                  options: ZetaSwitchType.values,
                  labelBuilder: enumLabelBuilder,
                ),
              ),
              Text(isOn == true ? 'On' : 'Off'),
            ],
          ),
        );
      },
    ),
  );
}
