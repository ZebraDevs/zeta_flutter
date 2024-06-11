import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget segmentedControlUseCase(BuildContext context) {
  final iconsSegments = List.generate(5, (index) => index);
  int selectedIconSegment = iconsSegments.first;

  final rounded = context.knobs.boolean(label: "Rounded", initialValue: true);
  final icon = iconKnob(context, rounded: rounded, initial: ZetaIcons.star_round);

  final text = context.knobs.string(label: 'Text', initialValue: "Item");

  final textSegments = List.generate(3, (index) => "$text ${index + 1}");
  String selectedTextSegment = textSegments.first;

  return WidgetbookTestWidget(
    widget: StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ZetaSpacing.xl_4),
            child: ZetaSegmentedControl(
              rounded: rounded,
              segments: [
                for (final value in iconsSegments)
                  ZetaButtonSegment(
                    value: value,
                    child: Icon(icon),
                  ),
              ],
              onChanged: (value) => setState(
                () => selectedIconSegment = value,
              ),
              selected: selectedIconSegment,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(ZetaSpacing.xl_4),
            child: ZetaSegmentedControl(
              rounded: rounded,
              segments: [
                for (final value in textSegments)
                  ZetaButtonSegment(
                    value: value,
                    child: Text(
                      value,
                    ),
                  ),
              ],
              onChanged: (value) => setState(
                () => selectedTextSegment = value,
              ),
              selected: selectedTextSegment,
            ),
          ),
        ],
      );
    }),
  );
}
