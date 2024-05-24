import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class DialogExample extends StatelessWidget {
  static const String name = 'Dialog';

  const DialogExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    return ExampleScaffold(
      name: 'Dialog',
      child: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () => showZetaDialog(
                context,
                useRootNavigator: false,
                title: 'Dialog Title',
                icon: Icon(
                  ZetaIcons.warning_round,
                  color: zeta.colors.surfaceWarning,
                ),
                message:
                    'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusm od tempor incididunt ut labore et do lore magna aliqua.',
                primaryButtonLabel: 'Confirm',
              ),
              child: Text('Show dialog with one button'),
            ),
            TextButton(
              onPressed: () => showZetaDialog(
                context,
                useRootNavigator: false,
                title: 'Dialog Title',
                icon: Icon(
                  ZetaIcons.warning_round,
                  color: zeta.colors.surfaceWarning,
                ),
                message:
                    'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusm od tempor incididunt ut labore et do lore magna aliqua.',
                primaryButtonLabel: 'Confirm',
                secondaryButtonLabel: 'Cancel',
              ),
              child: Text('Show dialog with two buttons'),
            ),
            TextButton(
              onPressed: () => showZetaDialog(
                context,
                useRootNavigator: false,
                title: 'Dialog Title',
                icon: Icon(
                  ZetaIcons.warning_round,
                  color: zeta.colors.surfaceWarning,
                ),
                message:
                    'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusm od tempor incididunt ut labore et do lore magna aliqua.',
                primaryButtonLabel: 'Confirm',
                secondaryButtonLabel: 'Cancel',
                tertiaryButtonLabel: 'Learn more',
                onTertiaryButtonPressed: () {},
              ),
              child: Text('Show dialog with three buttons'),
            ),
            TextButton(
              onPressed: () => showZetaDialog(
                context,
                useRootNavigator: false,
                title: 'Dialog Title',
                icon: Icon(
                  ZetaIcons.warning_round,
                  color: zeta.colors.surfaceWarning,
                ),
                message:
                    'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusm od tempor incididunt ut labore et do lore magna aliqua.',
                headerAlignment: ZetaDialogHeaderAlignment.left,
                primaryButtonLabel: 'Confirm',
                secondaryButtonLabel: 'Cancel',
                rounded: false,
              ),
              child: Text(
                'Show dialog with header to the left\nand sharp buttons',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
