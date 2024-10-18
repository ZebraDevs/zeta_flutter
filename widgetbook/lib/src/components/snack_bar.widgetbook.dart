import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Snackbar',
  type: ZetaSnackBar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23105-92186&t=9UKEEDe1Zek0JZal-4',
)
Widget snackBar(BuildContext context) {
  final leadingIcon = iconKnob(context, name: "Leading Icon", initial: null, nullable: true);

  return ZetaButton.primary(
      label: "Show Snackbar",
      onPressed: () {
        final snackBar = ZetaSnackBar(
          context: context,
          onPressed: () {},
          actionLabel: context.knobs.stringOrNull(label: 'Action Label', initialValue: null),
          type: context.knobs.listOrNull<ZetaSnackBarType>(
            label: 'Type',
            options: [null, ...ZetaSnackBarType.values],
            labelBuilder: enumLabelBuilder,
          ),
          leadingIcon: leadingIcon != null ? ZetaIcon(leadingIcon) : null,
          content: Text(context.knobs.string(label: 'Content Text', initialValue: 'This is a snackbar')),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
}
