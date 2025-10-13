import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/home.dart';
import 'package:zeta_example/utils/interop.dart';
import 'package:zeta_example/utils/multi_view_app.dart';
import 'package:zeta_example/zeta_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

final routes = [
  GoRoute(
    path: '/',
    name: 'Home',
    builder: (_, __) => Home(routes: {'Components': componentRoutes}),
    routes: [...componentRoutes],
  )
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runWidget(MultiViewApp(
    viewBuilder: (BuildContext context) {
      final int viewId = View.of(context).viewId;
      final InitialData? data = InitialData.forView(viewId);

      return ZetaExample(
        initialThemeMode: (data?.darkMode ?? false) ? ThemeMode.dark : ThemeMode.light,
        initialContrast: (data?.highContrast ?? false) ? ZetaContrast.aaa : ZetaContrast.aa,
        initialRoute: data?.route ?? '/',
        router: GoRouter(routes: routes),
        routes: routes,
      );
    },
  ));
}
