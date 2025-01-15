import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String segmentedControlPath = '$componentsPath/Segmented Control';

@widgetbook.UseCase(
  name: 'Text',
  type: ZetaSegmentedControl,
  path: segmentedControlPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22683-71169&t=sHwT9f9HuPjkpi1x-4',
)
Widget segmentedControlTextUseCase(BuildContext context) {
  final text = context.knobs.string(label: 'Text', initialValue: 'Item');
  final textSegments = List.generate(
    context.knobs.int.slider(label: 'Number of items', min: 1, max: 10, initialValue: 3),
    (index) => '$text ${index + 1}',
  );
  var selectedTextSegment = textSegments.first;
  return StatefulBuilder(builder: (context, setState) {
    return ZetaSegmentedControl(
      segments: textSegments.map((value) => ZetaButtonSegment(value: value, child: Text(value))).toList(),
      onChanged: (value) => setState(() => selectedTextSegment = value),
      selected: selectedTextSegment,
    );
  });
}

@widgetbook.UseCase(
  name: 'Icon',
  type: ZetaSegmentedControl,
  path: segmentedControlPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22683-71169&t=sHwT9f9HuPjkpi1x-4',
)
Widget segmentedControlIconUseCase(BuildContext context) {
  final icon = iconKnob(context, initial: ZetaIcons.star);
  final iconsSegments = List.generate(
    context.knobs.int.slider(label: 'Number of items', min: 1, max: 10, initialValue: 3),
    (index) => index,
  );
  var selectedIconSegment = iconsSegments.first;

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaSegmentedControl(
        segments: iconsSegments.map((value) => ZetaButtonSegment(value: value, child: ZetaIcon(icon))).toList(),
        onChanged: (value) => setState(() => selectedIconSegment = value),
        selected: selectedIconSegment,
      );
    },
  );
}
