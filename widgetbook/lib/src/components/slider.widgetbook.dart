import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Slider',
  type: ZetaSlider,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=875-15530&t=9UKEEDe1Zek0JZal-4',
)
Widget sliderUseCase(BuildContext context) {
  var value = 0.5;

  return StatefulBuilder(builder: (context, setState) {
    return ZetaSlider(
      value: value,
      divisions: context.knobs.intOrNull.slider(label: 'Divisions', min: 1, initialValue: 10),
      onChange: context.knobs.boolean(label: 'Disabled') ? null : (newValue) => setState(() => value = newValue),
    );
  },);
}