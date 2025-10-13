import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/config/assets_config.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/config/theme_config.dart';
import 'package:zeta_example/home.dart';
import 'package:zeta_example/zeta_example.dart';

final _routes = [...componentRoutes, ...themeRoutes, ...assetRoutes];

final routes = [
  GoRoute(
    path: '/',
    name: 'Home',
    builder: (_, __) => Home(routes: {
      'Components': componentRoutes,
      'Theme': themeRoutes,
      'Assets': assetRoutes,
    }),
    routes: _routes,
  ),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ZetaExample(
    router: GoRouter(routes: routes),
    routes: routes,
  ));
}
