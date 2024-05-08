import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget stepperInputUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: ZetaStepperInput(
      initialValue: context.knobs.intOrNull.input(label: 'Initial value'),
      min: context.knobs.intOrNull.input(label: 'Minimum value'),
      max: context.knobs.intOrNull.input(label: 'Maximum value'),
      size: context.knobs.list(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
      onChange: context.knobs.boolean(label: 'Disabled', initialValue: false) ? null : (_) {},
    ),
  );
}
