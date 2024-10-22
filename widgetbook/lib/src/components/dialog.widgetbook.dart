import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

// TODO(luke): Refactor this widgetbook
@widgetbook.UseCase(
  name: 'Dialog',
  type: ZetaDialog,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23954-93036&t=6jmGZpLRLKTDIfJL-4',
)
Widget dialog(BuildContext context) {
  final zeta = Zeta.of(context);
  final title = context.knobs.string(
    label: 'Dialog title',
    initialValue: 'Dialog Title',
  );
  final message = context.knobs.string(
    label: 'Dialog message',
    initialValue:
        'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusm od tempor incididunt ut labore et do lore magna aliqua.',
  );
  final iconData = iconKnob(
    context,
    initial: Icons.warning,
  );
  final barrierDismissible = context.knobs.boolean(label: 'Barrier dismissible', initialValue: true);
  final headerAlignment = context.knobs.list<ZetaDialogHeaderAlignment>(
    label: 'Header alignment',
    options: ZetaDialogHeaderAlignment.values,
    labelBuilder: (value) => value.name,
  );
  return Column(
    children: [
      TextButton(
        onPressed: () => showZetaDialog(
          context,
          useRootNavigator: false,
          barrierDismissible: barrierDismissible,
          headerAlignment: headerAlignment,
          title: title,
          icon: ZetaIcon(
            iconData,
            color: zeta.colors.surfaceWarning,
          ),
          message: message,
          primaryButtonLabel: 'Confirm',
        ),
        child: const Text('Show dialog with one button'),
      ),
      TextButton(
        onPressed: () => showZetaDialog(
          context,
          useRootNavigator: false,
          barrierDismissible: barrierDismissible,
          headerAlignment: headerAlignment,
          title: title,
          icon: ZetaIcon(
            iconData,
            color: zeta.colors.surfaceWarning,
          ),
          message: message,
          primaryButtonLabel: 'Confirm',
          secondaryButtonLabel: 'Cancel',
        ),
        child: const Text('Show dialog with two buttons'),
      ),
      TextButton(
        onPressed: () => showZetaDialog(
          context,
          useRootNavigator: false,
          barrierDismissible: barrierDismissible,
          headerAlignment: headerAlignment,
          title: title,
          icon: ZetaIcon(
            iconData,
            color: zeta.colors.surfaceWarning,
          ),
          message: message,
          primaryButtonLabel: 'Confirm',
          secondaryButtonLabel: 'Cancel',
          tertiaryButtonLabel: 'Learn more',
          onTertiaryButtonPressed: () {},
        ),
        child: const Text('Show dialog with three buttons'),
      ),
    ],
  );
}
