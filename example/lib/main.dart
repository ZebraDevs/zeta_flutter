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

  Component(this.name, this.page);
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
        routes: [...components.map((e) => GoRoute(path: e.name, builder: (_, __) => e.page)).toList()],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ZetaTheme.zeta,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zeta')),
      body: ListView.builder(
        itemCount: components.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(components[index].name),
            onTap: () => context.go('/${components[index].name}'),
          );
        },
      ),
    );
  }
}
