import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ZetaExample(initialRoute: '/ContactListItem'));
}

class ZetaExample extends StatelessWidget {
  final ZetaContrast? initialContrast;
  final ThemeMode? initialThemeMode;
  final String? initialRoute;

  const ZetaExample({super.key, this.initialContrast, this.initialThemeMode, this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      initialContrast: initialContrast,
      initialThemeMode: initialThemeMode,
      customThemes: [
        ZetaCustomTheme(
          id: 'teal',
          primary: ZetaPrimitivesLight().teal,
          primaryDark: ZetaPrimitivesDark().teal,
          secondary: ZetaPrimitivesLight().yellow,
          secondaryDark: ZetaPrimitivesDark().yellow,
        ),
        ZetaCustomTheme(
          id: 'yellow',
          primary: ZetaPrimitivesLight().yellow,
          primaryDark: ZetaPrimitivesDark().yellow,
          secondary: ZetaPrimitivesLight().red,
          secondaryDark: ZetaPrimitivesDark().red,
        ),
        ZetaCustomTheme(
          id: 'red',
          primary: ZetaPrimitivesLight().red,
          primaryDark: ZetaPrimitivesDark().red,
          secondary: ZetaPrimitivesLight().purple,
          secondaryDark: ZetaPrimitivesDark().purple,
        ),
        ZetaCustomTheme(
          id: 'purple',
          primary: ZetaPrimitivesLight().purple,
          primaryDark: ZetaPrimitivesDark().purple,
          secondary: ZetaPrimitivesLight().green,
          secondaryDark: ZetaPrimitivesDark().green,
        ),
        ZetaCustomTheme(
          id: 'green',
          primary: ZetaPrimitivesLight().green,
          primaryDark: ZetaPrimitivesDark().green,
          secondary: ZetaPrimitivesLight().blue,
          secondaryDark: ZetaPrimitivesDark().blue,
        ),
      ],
      builder: (context, lightTheme, darkTheme, _) {
        if (initialRoute != null) {
          return MaterialApp.router(
            routerConfig: GoRouter(
              routes: routes,
              initialLocation: initialRoute ?? '/',
              initialExtra: initialRoute != null ? 'docs' : null,
            ),
            themeMode: initialThemeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
          );
        }
        return MaterialApp.router(
          routerConfig: router,
          theme: lightTheme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
