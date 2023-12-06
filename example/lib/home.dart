import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/pages/color_example.dart';
import 'package:zeta_example/pages/grid_example.dart';
import 'package:zeta_example/pages/spacing_example.dart';
import 'package:zeta_example/pages/status_label_example.dart';
import 'package:zeta_example/pages/typography_example.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class Component {
  final String name;
  final WidgetBuilder pageBuilder;
  final List<Component> children;
  Component(this.name, this.pageBuilder, [this.children = const []]);
}

final List<Component> components = [
  Component(GridExample.name, (context) => const GridExample()),
  Component(SpacingExample.name, (context) => const SpacingExample()),
  Component(TypographyExample.name, (context) => const TypographyExample()),
  Component(ColorExample.name, (context) => const ColorExample()),
  Component(LabelExample.name, (context) => const LabelExample()),
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const Home(),
      routes: [
        ...components.map(
          (e) => GoRoute(
            path: e.name,
            builder: (_, __) => e.pageBuilder.call(_),
            routes: e.children.map((f) => GoRoute(path: f.name, builder: (_, __) => f.pageBuilder(_))).toList(),
          ),
        )
      ],
    ),
  ],
);

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final items = components..sort((a, b) => a.name.compareTo(b.name));
    return ExampleScaffold(
      name: 'Zeta',
      child: ListView.builder(
        padding: EdgeInsets.all(Dimensions.s),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: ZetaText(items[index].name),
            onTap: () => context.go('/${items[index].name}'),
          );
        },
      ),
    );
  }
}
