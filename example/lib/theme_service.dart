import 'package:flutter/src/material/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zeta_example/utils/theme_color_switch.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SharedPrefsThemeService extends ZetaThemeService {
  SharedPrefsThemeService(this.preferences);

  final SharedPreferences preferences;

  @override
  Future<(ZetaThemeData?, ThemeMode?, ZetaContrast?)> loadTheme() async {
    final theme = preferences.getString('theme') ?? 'default';
    final themeData = appThemes[theme];

    final modeString = preferences.getString('themeMode');
    final themeMode = modeString == 'light'
        ? ThemeMode.light
        : modeString == 'dark'
            ? ThemeMode.dark
            : ThemeMode.system;

    final contrastString = preferences.getString('contrast');
    final contrast = contrastString == 'aaa' ? ZetaContrast.aaa : ZetaContrast.aa;

    return (themeData, themeMode, contrast);
  }

  @override
  Future<void> saveTheme({
    required ZetaThemeData themeData,
    required ThemeMode themeMode,
    required ZetaContrast contrast,
  }) async {
    await preferences.setString('theme', themeData.identifier);

    final modeString = themeMode == ThemeMode.light
        ? 'light'
        : themeMode == ThemeMode.dark
            ? 'dark'
            : 'system';
    await preferences.setString('themeMode', modeString);

    final contrastString = contrast == ZetaContrast.aaa ? 'aaa' : 'aa';
    await preferences.setString('contrast', contrastString);
  }
}
