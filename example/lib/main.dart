// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
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
];

class _MyAppState extends State<MyApp> {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const Home(),
        routes: [
          ...components
              .map(
                (e) => GoRoute(
                  path: e.name,
                  builder: (_, __) => e.page,
                  routes: e.children.map((f) => GoRoute(path: f.name, builder: (_, __) => f.page)).toList(),
                ),
              )
              .toList()
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ZetaTheme.zeta,
      routerConfig: router,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final items = components..sort(((a, b) => a.name.compareTo(b.name)));

    return Scaffold(
      appBar: AppBar(title: const Text('Zeta')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            onTap: () => context.go('/${items[index].name}'),
          );
        },
      ),
    );
  }
}
