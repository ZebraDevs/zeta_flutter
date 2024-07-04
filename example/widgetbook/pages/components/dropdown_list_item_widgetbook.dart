import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget dropdownListItemUseCase(BuildContext context) {
  return WidgetBookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        final primaryText = context.knobs.string(label: 'Primary text', initialValue: 'Label');

        final secondaryText = context.knobs.string(label: 'Secondary text', initialValue: 'Descriptor');

        final showIcon = context.knobs.boolean(label: 'Show icon');

        final showDivider = context.knobs.boolean(label: 'Show divider');

        final leading = showIcon ? ZetaIcon(ZetaIcons.star) : null;

        return ZetaDropdownListItem(
          primaryText: primaryText,
          items: [
            ZetaListItem(primaryText: 'List Item'),
            ZetaListItem(primaryText: 'List Item'),
            ZetaListItem(primaryText: 'List Item'),
          ],
          secondaryText: secondaryText,
          leading: leading,
          showDivider: showDivider,
        );
      },
    ),
  );
}
