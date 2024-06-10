import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget listItemUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        final subtitle = context.knobs.stringOrNull(label: 'Descriptor', initialValue: null);

        final trailing = context.knobs.boolean(label: 'Trailing', initialValue: false)
            ? Checkbox(value: false, onChanged: (_) {})
            : null;

        final leading = context.knobs.boolean(label: 'Leading', initialValue: false)
            ? Container(
                width: ZetaSpacing.xl_8,
                height: ZetaSpacing.xl_8,
                decoration: BoxDecoration(borderRadius: ZetaRadius.rounded),
                child: Placeholder(),
              )
            : null;

        return ZetaListItem(
          dense: context.knobs.boolean(label: 'Dense', initialValue: false),
          enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
          enabledDivider: context.knobs.boolean(
            label: 'Enabled Divider',
            initialValue: true,
          ),
          selected: context.knobs.boolean(label: 'Selected', initialValue: true),
          leading: leading,
          title: Text(
            context.knobs.string(label: 'Title', initialValue: 'List Item'),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: trailing,
          onTap: () {},
        );
      },
    ),
  );
}
