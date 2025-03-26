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
      paddingAll: 0,
      children: [
        DefaultTabController(
          length: 2,
          child: ZetaTabBar(
            context: context,
            onTap: (int) => print(int),
            tabs: [
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
            ],
          ),
        ),
        DefaultTabController(
          key: Key('docs-tabbar'),
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
        DefaultTabController(
          length: 5,
          key: Key('docs-tabbar-icon'),
          child: ZetaTabBar(
            context: context,
            isScrollable: true,
            onTap: (int) => print(int),
            tabs: [
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
              ZetaTab(icon: Icon(ZetaIcons.star), text: "Tab Item"),
            ],
          ),
        ),
        DefaultTabController(
          length: 5,
          key: Key('docs-tabbar-disabled'),
          child: ZetaTabBar(
            context: context,
            isScrollable: true,
            tabs: [
              ZetaTab(text: "Disabled"),
              ZetaTab(text: "Disabled"),
              ZetaTab(text: "Disabled"),
              ZetaTab(text: "Disabled"),
              ZetaTab(text: "Disabled"),
            ],
          ),
        ),
      ],
    );
  }
}
