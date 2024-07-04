import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget listItemUseCase(BuildContext context) {
  bool checkedValue = false;

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        final type = context.knobs.list(
          label: 'Type',
          options: ['Default', 'Checkbox', 'Radio button', 'Switch'],
        );

        final primaryText = context.knobs.string(label: 'Primary text', initialValue: 'Label');

        final secondaryText = context.knobs.string(label: 'Secondary text', initialValue: 'Descriptor');

        final showIcon = context.knobs.boolean(label: 'Show icon');

        final showDivider = context.knobs.boolean(label: 'Show divider');

        final leading = showIcon ? ZetaIcon(ZetaIcons.star) : null;

        final onChanged = (bool? value) => setState(() {
              checkedValue = value!;
            });

        if (type == 'Checkbox') {
          return ZetaListItem.checkbox(
            primaryText: primaryText,
            secondaryText: secondaryText,
            leading: leading,
            showDivider: showDivider,
            onChanged: onChanged,
            value: checkedValue,
          );
        } else if (type == 'Switch') {
          return ZetaListItem.toggle(
            primaryText: primaryText,
            secondaryText: secondaryText,
            leading: leading,
            showDivider: showDivider,
            onChanged: onChanged,
            value: checkedValue,
          );
        } else if (type == 'Radio button') {
          return ZetaListItem.radio(
            primaryText: primaryText,
            secondaryText: secondaryText,
            leading: leading,
            showDivider: showDivider,
            onChanged: (_) {},
            value: 'value',
            groupValue: 'value',
          );
        } else {
          return ZetaListItem(
            primaryText: primaryText,
            secondaryText: secondaryText,
            leading: leading,
            showDivider: showDivider,
          );
        }
      },
    ),
  );
}
