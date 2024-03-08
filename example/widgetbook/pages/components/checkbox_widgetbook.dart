import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget checkboxUseCase(BuildContext context) {
  bool? b = true;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        dynamic onChanged =
            context.knobs.boolean(label: 'Enabled', initialValue: true) ? (b2) => setState(() => b = b2) : null;
        return ZetaCheckbox(
          value: b,
          onChanged: onChanged,
          useIndeterminate: context.knobs.boolean(label: 'Use Indeterminate', initialValue: true),
          rounded: roundedKnob(context),
          label: context.knobs.string(label: 'Label', initialValue: 'Checkbox'),
        );
      },
    ),
  );
}
