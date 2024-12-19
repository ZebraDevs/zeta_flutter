import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ZetaExample());
}

class ZetaExample extends StatelessWidget {
  const ZetaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      // initialContrast: ZetaContrast.aa,
      // initialThemeMode: ThemeMode.system,
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
      builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
