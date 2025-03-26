import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

const String rangeSelectorPath = '$componentsPath/Range Selector';

@widgetbook.UseCase(
  name: 'Range Selector',
  type: ZetaRangeSelector,
  path: rangeSelectorPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=27560-8260&t=AZEbv7Mm0mjIx0Or-4',
)
Widget rangeSelectorUseCase(BuildContext context) {
  return ZetaRangeSelector(
    label: context.knobs.string(label: 'Label', initialValue: 'Range Selector'),
    divisions: context.knobs.intOrNull.input(label: 'Divisions', initialValue: null),
    showValues: context.knobs.boolean(label: 'Show Values', initialValue: true),
    onChange: disabledKnob(context) ? null : (value) {},
    initialValues: context.knobs.range(label: 'Initial Range', initialValue: RangeValues(20, 80)),
    min: context.knobs.int.input(label: 'Min', initialValue: 0).toDouble(),
    max: context.knobs.int.input(label: 'Max', initialValue: 100).toDouble(),
  ).paddingHorizontal(16);
}

@widgetbook.UseCase(
  name: 'Selector',
  type: ZetaRangeSelector,
  path: rangeSelectorPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1186-28564&t=AZEbv7Mm0mjIx0Or-4',
)
Widget selectorUseCase(BuildContext context) {
  return ZetaRangeSelector(
    label: context.knobs.stringOrNull(label: 'Label'),
    divisions: context.knobs.intOrNull.input(label: 'Divisions', initialValue: null),
    showValues: false,
    onChange: disabledKnob(context) ? null : (value) {},
    initialValues: context.knobs.range(label: 'Initial Range', initialValue: RangeValues(20, 80)),
    min: context.knobs.int.input(label: 'Min', initialValue: 0).toDouble(),
    max: context.knobs.int.input(label: 'Max', initialValue: 100).toDouble(),
  );
}
