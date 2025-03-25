import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SnackBarExample extends StatelessWidget {
  static const String name = 'SnackBar';

  const SnackBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: SnackBarExample.name,
      child: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                // Standard
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                      child: ZetaButton.primary(
                        label: "Standard SnackBar",
                        onPressed: () {
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
                    ),
                  ],
                ),

                // Default
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Contectual Default",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        ZetaSnackBar(
                          context: context,
                          type: ZetaSnackBarType.defaultType,
                          leadingIcon: Icon(Icons.mood),
                          content: Text('Message with icon'),
                        ),
                      );
                    },
                  ),
                ),

                // Action
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Action",
                    onPressed: () {
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
                ),

                // Positive
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Positive",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        ZetaSnackBar(
                          context: context,
                          type: ZetaSnackBarType.positive,
                          content: Text('Request sent successfully'),
                        ),
                      );
                    },
                  ),
                ),

                // Info
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Info",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        ZetaSnackBar(
                          context: context,
                          type: ZetaSnackBarType.info,
                          content: Text('Information is being displayed'),
                        ),
                      );
                    },
                  ),
                ),

                // Info
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Info",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        ZetaSnackBar(
                          context: context,
                          type: ZetaSnackBarType.info,
                          content: Text('Information is being displayed'),
                        ),
                      );
                    },
                  ),
                ),

                // Warning
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
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
                ),

                // Error
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Error",
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        ZetaSnackBar(
                          context: context,
                          type: ZetaSnackBarType.error,
                          content: Text('Error has been detected'),
                        ),
                      );
                    },
                  ),
                ),

                // Deletion
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "Deletion",
                    onPressed: () {
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
                ),

                // View
                Padding(
                  padding: EdgeInsets.only(top: Zeta.of(context).spacing.large),
                  child: ZetaButton.primary(
                    label: "View",
                    onPressed: () {
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
