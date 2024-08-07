import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget stepperInputUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => ZetaStepperInput(
      value: context.knobs.int.input(label: 'Value'),
      min: context.knobs.int.input(label: 'Minimum value', initialValue: 0),
      max: context.knobs.int.input(label: 'Maximum value', initialValue: 10),
      size: context.knobs.list(
        label: 'Size',
        options: ZetaStepperInputSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      onChange: disabledKnob(context) ? null : (_) {},
    ),
  );
}
