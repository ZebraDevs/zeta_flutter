import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget listItemUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final leading = context.knobs.boolean(label: 'Leading', initialValue: false)
            ? Container(
                width: ZetaSpacing.xl_8,
                height: ZetaSpacing.xl_8,
                decoration: BoxDecoration(borderRadius: ZetaRadius.rounded),
                child: Placeholder(),
              )
            : null;

        return ZetaListItem.checkbox(
          leading: leading,
          primaryText: 'List Item',
          onChanged: (_) {},
        );
      },
    ),
  );
}
