import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TabsExample extends StatefulWidget {
  const TabsExample({super.key});

  static const String name = 'Tabs';

  @override
  State<TabsExample> createState() => _TabsExampleState();
}

class _TabsExampleState extends State<TabsExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: TabsExample.name,
      child: Column(
        children: [
          DefaultTabController(
            length: 2,
            child: ZetaTabBar(
              context: context,
              tabs: [
                ZetaTab(icon: Icon(ZetaIcons.star_round), text: "Tab Item"),
                ZetaTab(icon: Icon(ZetaIcons.star_round), text: "Tab Item"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: ZetaSpacing.l),
            child: DefaultTabController(
              length: 5,
              child: ZetaTabBar(
                context: context,
                isScrollable: true,
                tabs: [
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                  ZetaTab(text: "Tab Item"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: ZetaSpacing.l),
            child: DefaultTabController(
              length: 5,
              child: ZetaTabBar(
                context: context,
                isScrollable: true,
                enabled: false,
                tabs: [
                  ZetaTab(icon: Icon(ZetaIcons.star_sharp), text: "Tab Item"),
                  ZetaTab(icon: Icon(ZetaIcons.star_sharp), text: "Tab Item"),
                  ZetaTab(icon: Icon(ZetaIcons.star_sharp), text: "Tab Item"),
                  ZetaTab(icon: Icon(ZetaIcons.star_sharp), text: "Tab Item"),
                  ZetaTab(icon: Icon(ZetaIcons.star_sharp), text: "Tab Item"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
