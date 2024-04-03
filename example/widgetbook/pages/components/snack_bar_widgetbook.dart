import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget snackBarUseCase(BuildContext context) {
  return WidgetbookTestWidget(
    widget: Builder(
      builder: (context) {
        final text = context.knobs.string(
          label: 'Content Text',
          initialValue: 'This is a snackbar',
        );

        final actionLabel = context.knobs.stringOrNull(
          label: 'Action Label',
          initialValue: null,
        );

        final type = context.knobs.listOrNull<ZetaSnackBarType>(
          label: 'Type',
          options: [null, ...ZetaSnackBarType.values],
          labelBuilder: enumLabelBuilder,
        );

        final leadingIcon = iconKnob(
          context,
          name: "Leading Icon",
          initial: Icons.mood_rounded,
          nullable: true,
        );

        final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);

        return ZetaButton.primary(
            label: "Show Snackbar",
            onPressed: () {
              print(actionLabel);
              final snackBar = ZetaSnackBar(
                context: context,
                onPressed: () {},
                actionLabel: actionLabel,
                type: type,
                leadingIcon: leadingIcon != null ? Icon(leadingIcon) : null,
                rounded: rounded,
                content: Text(text),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
      },
    ),
  );
}
