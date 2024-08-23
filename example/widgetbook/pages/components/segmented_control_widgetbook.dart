import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget segmentedControlUseCase(BuildContext context) {
  final iconsSegments = List.generate(5, (index) => index);
  int selectedIconSegment = iconsSegments.first;

  final icon = iconKnob(context, initial: ZetaIcons.star);
  final text = context.knobs.string(label: 'Text', initialValue: "Item");

  final textSegments = List.generate(3, (index) => "$text ${index + 1}");
  String selectedTextSegment = textSegments.first;

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(Zeta.of(context).spacing.xl_4),
            child: ZetaSegmentedControl(
              segments: [
                for (final value in iconsSegments)
                  ZetaButtonSegment(
                    value: value,
                    child: ZetaIcon(icon),
                  ),
              ],
              onChanged: (value) => setState(
                () => selectedIconSegment = value,
              ),
              selected: selectedIconSegment,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Zeta.of(context).spacing.xl_4),
            child: ZetaSegmentedControl(
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
