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
      initialThemeData: themePreferences.$1 ?? ZetaThemeData(),
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
    required this.initialThemeData,
  });

  final ZetaThemeService themeService;
  final ZetaContrast initialContrast;
  final ThemeMode initialThemeMode;
  final ZetaThemeData initialThemeData;

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      themeService: themeService,
      initialContrast: initialContrast,
      initialThemeData: initialThemeData,
      initialThemeMode: initialThemeMode,
      builder: (context, themeData, themeMode) {
        final dark = themeData.colorsDark.toScheme();
        final light = themeData.colorsLight.toScheme();
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: light.background,
            colorScheme: light,
            textTheme: zetaTextTheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: dark.background,
            colorScheme: dark,
            textTheme: zetaTextTheme,
          ),
        );
      },
    );
  }
}
