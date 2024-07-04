import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget dialogUseCase(BuildContext context) {
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
    name: "Icon",
    initial: Icons.warning,
  );
  final barrierDismissible = context.knobs.boolean(label: 'Barrier dismissible', initialValue: true);
  final headerAlignment = context.knobs.list<ZetaDialogHeaderAlignment>(
    label: 'Header alignment',
    options: ZetaDialogHeaderAlignment.values,
    labelBuilder: (value) => value.name,
  );
  return WidgetbookScaffold(
    builder: (context, _) => Padding(
      padding: const EdgeInsets.all(ZetaSpacing.xl_1),
      child: Center(
        child: Column(
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
              child: Text('Show dialog with one button'),
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
              child: Text('Show dialog with two buttons'),
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
              child: Text('Show dialog with three buttons'),
            ),
          ],
        ),
      ),
    ),
  );
}
