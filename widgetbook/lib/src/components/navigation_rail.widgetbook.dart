import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Navigation Rail',
  type: ZetaNavigationRail,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23753-18605&t=6jmGZpLRLKTDIfJL-4',
)
Widget navigationRail(BuildContext context) {
  final zeta = Zeta.of(context);
  int? selectedIndex;

  final itemsList = context.knobs
      .string(label: 'Items separated with comma', initialValue: 'Label,User Preferences,Account Settings,Label')
      .split(',')
      .where((element) => element.trim().isNotEmpty)
      .toList();

  return StatefulBuilder(
    builder: (context, setState) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ZetaNavigationRail(
            selectedIndex: selectedIndex,
            onSelect: (index) => setState(() => selectedIndex = index),
            wordWrap: context.knobs.boolean(label: 'Word wrap', initialValue: true),
            items: itemsList
                .map((item) => ZetaNavigationRailItem(
                      label: item,
                      icon: ZetaIcon(iconKnob(context, name: "Icon", initial: ZetaIcons.star)),
                      disabled: disabledKnob(context),
                    ))
                .toList(),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
              child: selectedIndex == null
                  ? const Nothing()
                  : Text(
                      itemsList[selectedIndex!],
                      textAlign: TextAlign.center,
                      style: ZetaTextStyles.titleMedium
                          .copyWith(color: zeta.colors.textDefault, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      );
    },
  );
}
