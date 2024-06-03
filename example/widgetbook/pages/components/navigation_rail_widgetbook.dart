import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget navigationRailUseCase(BuildContext context) {
  final zeta = Zeta.of(context);
  int? selectedIndex;
  final items = context.knobs.string(
    label: 'Items separated with comma',
    initialValue: 'Label,User Preferences,Account Settings,Label',
  );
  final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);
  final iconData = iconKnob(
    context,
    name: "Icon",
    rounded: rounded,
    initial: rounded ? ZetaIcons.star_round : ZetaIcons.star_sharp,
  );
  final wordWrap = context.knobs.boolean(label: 'Word wrap', initialValue: true);
  final disabled = disabledKnob(context);
  final itemsList = items.split(',').where((element) => element.trim().isNotEmpty).toList();
  return SafeArea(
    child: WidgetbookTestWidget(
      widget: StatefulBuilder(
        builder: (context, setState) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZetaNavigationRail(
                selectedIndex: selectedIndex,
                onSelect: (index) => setState(() => selectedIndex = index),
                wordWrap: wordWrap,
                items: itemsList
                    .map((item) => ZetaNavigationRailItem(
                          label: item,
                          icon: Icon(iconData),
                          disabled: disabled,
                        ))
                    .toList(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(ZetaSpacing.xL),
                  child: selectedIndex == null
                      ? const SizedBox()
                      : Text(
                          itemsList[selectedIndex!],
                          textAlign: TextAlign.center,
                          style: ZetaTextStyles.titleMedium.copyWith(
                            color: zeta.colors.textDefault,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}
