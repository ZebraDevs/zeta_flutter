import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget dropdownListItemUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final primaryText = context.knobs.string(label: 'Primary text', initialValue: 'Label');

        final secondaryText = context.knobs.string(label: 'Secondary text', initialValue: 'Descriptor');

        final showIcon = context.knobs.boolean(label: 'Show icon');

        final showDivider = context.knobs.boolean(label: 'Show divider');

        final rounded = roundedKnob(context);

        final leading = showIcon ? Icon(ZetaIcons.star_round) : null;

        return ZetaDropdownListItem(
          primaryText: primaryText,
          items: [
            ZetaListItem(primaryText: 'List Item'),
            ZetaListItem(primaryText: 'List Item'),
            ZetaListItem(primaryText: 'List Item'),
          ],
          rounded: rounded,
          secondaryText: secondaryText,
          leading: leading,
          showDivider: showDivider,
        );
      },
    ),
  );
}
