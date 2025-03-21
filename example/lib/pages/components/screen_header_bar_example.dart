import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ScreenHeaderBarExample extends StatelessWidget {
  const ScreenHeaderBarExample({super.key});

  static const String name = 'ScreenHeaderBar';

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: ScreenHeaderBarExample.name,
      children: [
        ZetaScreenHeaderBar(
          title: Text("Add Subscribers"),
          actionButtonLabel: 'Done',
          onActionButtonPressed: () {},
          onBackButtonPressed: () {},
        )
      ],
    );
  }
}
