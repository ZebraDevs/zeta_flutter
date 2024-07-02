import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeta_example/theme_service.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  final themeService = SharedPrefsThemeService(preferences);
  final themePreferences = await themeService.loadTheme();

  runApp(
    ZetaExample(
      themeService: themeService,
      initialZetaThemeData: themePreferences.$1 ?? ZetaThemeData(),
      initialThemeMode: themePreferences.$2 ?? ThemeMode.system,
      initialContrast: themePreferences.$3 ?? ZetaContrast.aa,
    ),
  );
}

class ZetaExample extends StatelessWidget {
  const ZetaExample({
    super.key,
    required this.themeService,
    required this.initialContrast,
    required this.initialThemeMode,
    required this.initialZetaThemeData,
  });

  final ZetaThemeService themeService;
  final ZetaContrast initialContrast;
  final ThemeMode initialThemeMode;
  final ZetaThemeData initialZetaThemeData;

  @override
  Widget build(BuildContext context) {
    final initialThemeData = null;
    final initialRounded = true;

    return ZetaProvider.base(
      initialZetaThemeData: initialZetaThemeData,
      initialThemeMode: initialThemeMode,
      initialContrast: initialContrast,
      initialThemeData: initialThemeData,
      initialRounded: initialRounded,
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
