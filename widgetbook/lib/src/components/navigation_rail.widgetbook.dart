import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Navigation Rail',
  type: ZetaNavigationRail,
  path: '$componentsPath/Navigation Rail',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23753-18605&t=AZEbv7Mm0mjIx0Or-4',
)
Widget navigationRail(BuildContext context) {
  int? selectedIndex;

  return StatefulBuilder(
    builder: (context, setState) {
      return ZetaNavigationRail(
        selectedIndex: selectedIndex,
        onSelect: (index) => setState(() => selectedIndex = index),
        wordWrap: context.knobs.boolean(label: 'Word wrap', initialValue: true),
        items: context.knobs
            .string(label: 'Items separated with comma', initialValue: 'Label,User Preferences,Account Settings,Label')
            .split(',')
            .map((e) => e.trim())
            .where((element) => element.isNotEmpty)
            .map(
              (item) => ZetaNavigationRailItem(
                label: item,
                icon: ZetaIcon(iconKnob(context, initial: ZetaIcons.star)),
                disabled: disabledKnob(context),
              ),
            )
            .toList(),
      );
    },
  );
}
