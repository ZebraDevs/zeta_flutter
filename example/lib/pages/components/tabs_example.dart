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
              onTap: (int) => print(int),
              tabs: [
                ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
                ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Zeta.of(context).spacing.xl_4),
            child: DefaultTabController(
              length: 5,
              child: ZetaTabBar(
                context: context,
                isScrollable: true,
                onTap: (int) => print(int),
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
            padding: EdgeInsets.only(top: Zeta.of(context).spacing.xl_4),
            child: DefaultTabController(
              length: 5,
              child: ZetaTabBar(
                context: context,
                isScrollable: true,
                tabs: [
                  ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
                  ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
                  ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
                  ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
                  ZetaTab(icon: ZetaIcon(ZetaIcons.star), text: "Tab Item"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
