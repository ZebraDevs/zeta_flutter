import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'pages/color_example.dart';
import 'pages/grid_example.dart';
import 'pages/spacing_example.dart';
import 'pages/typography_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

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

class _MyAppState extends State<MyApp> {
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

  @override
  Widget build(BuildContext context) {
    return Zeta(
      builder: (context, theme, colors) {
        return MaterialApp.router(theme: theme, routerConfig: router);
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

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
