import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget navigationRailUseCase(BuildContext context) {
  final zeta = Zeta.of(context);
  int? selectedIndex;
  final items = context.knobs.string(
    label: 'Items separated with comma',
    initialValue: 'Label,User Preferences,Account Settings,Label',
  );
  final iconData = iconKnob(
    context,
    name: "Icon",
    initial: ZetaIcons.star,
  );
  final wordWrap = context.knobs.boolean(label: 'Word wrap', initialValue: true);
  final disabled = disabledKnob(context);
  final itemsList = items.split(',').where((element) => element.trim().isNotEmpty).toList();
  return SafeArea(
    child: WidgetbookScaffold(
      builder: (context, _) => StatefulBuilder(
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
                          icon: ZetaIcon(iconData),
                          disabled: disabled,
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
                          style: ZetaTextStyles.titleMedium.copyWith(
                            color: zeta.colors.mainDefault,
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
