import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SnackBarExample extends StatefulWidget {
  static const String name = 'SnackBar';

  const SnackBarExample({super.key});

  @override
  State<SnackBarExample> createState() => _SnackBarExampleState();
}

class _SnackBarExampleState extends State<SnackBarExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: SnackBarExample.name,
      children: [
        Column(
          spacing: 40,
          children: [
            ZetaButton.primary(
              label: "Standard Snackbar",
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  ZetaSnackBar(
                    context: context,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                    actionLabel: "Action",
                    content: Text('This is a snackbar'),
                  ),
                );
              },
            ),
            Wrap(
              runSpacing: 24,
              spacing: 24,
              children: [
                ZetaButton.primary(
                  label: "Default",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.defaultType,
                        leadingIcon: ZetaIcon(Icons.mood),
                        content: Text('Message with icon'),
                      ),
                    );
                  },
                ),
                ZetaButton.primary(
                  label: "Action",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.action,
                        onPressed: () {},
                        actionLabel: "Action",
                        content: Text('Actionable message with icon'),
                      ),
                    );
                  },
                ),
                ZetaButton.positive(
                  label: "Positive",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.positive,
                        content: Text('Request sent successfully'),
                      ),
                    );
                  },
                ),
                ZetaButton.text(
                  label: "Info",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.info,
                        content: Text('Information is being displayed'),
                      ),
                    );
                  },
                ),
                ZetaButton.outlineSubtle(
                  label: "Warning",
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.warning,
                        content: Text('Warning has been issued'),
                      ),
                    );
                  },
                ),
                ZetaButton.negative(
                  label: "Error",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.error,
                        content: Text('Error has been detected'),
                      ),
                    );
                  },
                ),
                ZetaButton.negative(
                  label: "Deletion",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.deletion,
                        onPressed: () {},
                        content: Text('Item was deleted'),
                      ),
                    );
                  },
                ),
                ZetaButton.text(
                  label: "View",
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      ZetaSnackBar(
                        context: context,
                        type: ZetaSnackBarType.view,
                        onPressed: () {},
                        content: Text('Something neeeds your attention'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
