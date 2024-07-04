import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget checkboxUseCase(BuildContext context) {
  bool b = true;

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        ValueChanged<bool>? onChanged = !disabledKnob(context) ? (b2) => setState(() => b = b2) : null;
        return ZetaCheckbox(
          value: b,
          onChanged: onChanged,
          useIndeterminate: context.knobs.boolean(label: 'Use Indeterminate', initialValue: true),
          label: context.knobs.string(label: 'Label', initialValue: 'Checkbox'),
        );
      },
    ),
  );
}
