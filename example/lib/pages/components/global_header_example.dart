import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class GroupHeaderExample extends StatefulWidget {
  static final name = "GlobalHeader";
  const GroupHeaderExample({super.key});

  @override
  State<GroupHeaderExample> createState() => _GroupHeaderExampleState();
}

class _GroupHeaderExampleState extends State<GroupHeaderExample> {
  final childrenOne = List.filled(5, ZetaTabItem());
  final childrenTwo = List.filled(10, ZetaTabItem());

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: "GlobalHeader",
      child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            ZetaGlobalHeader(
              title: "Title",
              tabItems: childrenTwo,
              utilityButtons: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    ZetaIcons.alert_round,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    ZetaIcons.help_round,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    ZetaIcons.apps_round,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ZetaSpacing.x5,
            ),
            // ZetaGlobalHeader(
            //   title: "Title",
            //   buttons: childrenOne,
            // ),
            const SizedBox(
              height: ZetaSpacing.x5,
            ),
            // ZetaGlobalHeader(
            //   title: "Title",
            //   buttons: childrenTwo,
            // ),
          ]),
        ),
      ),
    );
  }
}
