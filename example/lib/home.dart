import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/pages/color_example.dart';
import 'package:zeta_example/pages/grid_example.dart';
import 'package:zeta_example/pages/spacing_example.dart';
import 'package:zeta_example/pages/typography_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class Component {
  final String name;
  final Widget page;
  final List<Component> children;
  Component(this.name, this.page, [this.children = const []]);
}

final List<Component> components = [
  Component(GridExample.name, const GridExample()),
  Component(SpacingExample.name, const SpacingExample()),
  Component(TypographyExample.name, const TypographyExample()),
  Component(ColorExample.name, const ColorExample()),
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
            builder: (_, __) => e.page,
            routes: e.children.map((f) => GoRoute(path: f.name, builder: (_, __) => f.page)).toList(),
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

    final colors = ZetaColors.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zeta'),
        backgroundColor: colors.primary,
      ),
      body: ColoredBox(
        color: colors.background,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: ZetaText(items[index].name),
              onTap: () => context.go('/${items[index].name}'),
            );
          },
        ),
      ),
    );
  }
}
