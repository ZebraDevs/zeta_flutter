import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String snackBarsPath = '$componentsPath/SnackBars';

@widgetbook.UseCase(
  name: 'Snackbar',
  type: ZetaSnackBar,
  path: snackBarsPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21510-55806&t=eEOivHU9uV4K8qJq-4',
)
Widget snackBar(BuildContext context) {
  final actionLabel = context.knobs.stringOrNull(label: 'Action Label', initialValue: 'Action');
  final content = context.knobs.string(label: 'Content Text', initialValue: 'This is a snackbar');

  return ZetaButton.primary(
    label: 'Show Snackbar',
    onPressed: () {
      final snackBar = ZetaSnackBar(
        context: context,
        onPressed: () {},
        actionLabel: actionLabel,
        content: Text(content),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
  );
}

@widgetbook.UseCase(
  name: 'Contextual Snackbar',
  type: ZetaSnackBar,
  path: snackBarsPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23105-92186&t=eEOivHU9uV4K8qJq-4',
)
Widget contextualSnackbar(BuildContext context) {
  final leadingIcon = iconKnob(context, name: 'Leading Icon', nullable: true);
  final type = context.knobs.object.dropdown<ZetaSnackBarType>(
    label: 'Type',
    options: ZetaSnackBarType.values,
    labelBuilder: enumLabelBuilder,
  );
  final actionLabel = context.knobs.stringOrNull(label: 'Action Label');
  final content = context.knobs.string(label: 'Content Text', initialValue: 'This is a snackbar');
  return ZetaButton.primary(
    label: 'Show Snackbar',
    onPressed: () {
      final snackBar = ZetaSnackBar(
        context: context,
        onPressed: () {},
        actionLabel: actionLabel,
        type: type,
        leadingIcon: leadingIcon != null ? Icon(leadingIcon) : null,
        content: Text(content),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
  );
}
