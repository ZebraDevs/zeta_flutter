import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget switchUseCase(BuildContext context) {
  bool? isOn = false;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        ValueChanged<bool?>? onChanged = context.knobs.boolean(label: 'Enabled', initialValue: true)
            ? (value) => setState(() => isOn = value)
            : null;
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.xL),
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
