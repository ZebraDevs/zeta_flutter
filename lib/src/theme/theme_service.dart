import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contrast.dart';

const String _kThemeMode = 'themeMode';
const String _kContrast = 'contrast';
const String _kThemeId = 'theme_id';
// TODO(colors): Re-add custom font somewhere (not here)
// TODO(colors): Add tests
/// `ZetaThemeService` is an abstract class.
/// It provides the structure for loading and saving themes in Zeta application.
/// {@category Theme}

abstract class ZetaThemeService {
  /// Constructor for `ZetaThemeService`.
  const ZetaThemeService();

  /// Asynchronously load the theme data.
  ///
  /// This method returns a `Future` that when complete will produce a
  /// tuple of `ZetaThemeData`, `ThemeMode`, and `ZetaContrast`.
  ///
  /// `ZetaThemeData` describes the colors that are used by a theme.
  ///
  /// `ThemeMode` determines the brightness of the system.
  ///
  /// `ZetaContrast` defines different contrast styles to use across the application.
  ///
  /// Returns a Future `(ZetaThemeData?, ThemeMode?, ZetaContrast?)`.
  Future<(ThemeMode?, ZetaContrast?, String?)> loadTheme();

  /// Saves the provided theme data as the application's theme.
  ///
  /// `saveTheme` is a method used to save the current theme data.
  ///
  /// Takes a `ZetaThemeData` object that represents the theme to be saved.
  ///
  /// Returns a `Future` that completes when the theme data has been successfully saved.

  Future<void> saveTheme({
    required ThemeMode themeMode,
    required ZetaContrast contrast,
    required String? themeId,
  });
}

/// A default implementation of `ZetaThemeService` that uses `SharedPreferences` to store the theme data.
class ZetaDefaultThemeService extends ZetaThemeService {
  /// Constructor for `ZetaDefaultThemeService`.
  const ZetaDefaultThemeService();

  @override
  Future<(ThemeMode?, ZetaContrast?, String?)> loadTheme() async {
    final preferences = await SharedPreferences.getInstance();

    final modeString = preferences.getString(_kThemeMode);

    final themeMode = modeString == ThemeMode.light.name
        ? ThemeMode.light
        : modeString == ThemeMode.dark.name
            ? ThemeMode.dark
            : ThemeMode.system;

    final contrastString = preferences.getString(_kContrast);
    final contrast = contrastString == ZetaContrast.aaa.name ? ZetaContrast.aaa : ZetaContrast.aa;

    final themeId = preferences.getString(_kThemeId);

    return (themeMode, contrast, themeId);
  }

  @override
  Future<void> saveTheme({
    required ThemeMode themeMode,
    required ZetaContrast contrast,
    required String? themeId,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString(_kThemeMode, themeMode.name);
    await preferences.setString(_kContrast, contrast.name);

    if (themeId != null) await preferences.setString(_kThemeId, themeId);
  }
}
