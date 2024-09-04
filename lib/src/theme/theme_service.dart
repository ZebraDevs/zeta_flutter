import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contrast.dart';

const String _kThemeMode = 'themeMode';
const String _kContrast = 'contrast';
const String _kColor = 'color';
// TODO(colors): Revert this to include color also?
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
  Future<(ThemeMode?, ZetaContrast?)> loadTheme();

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
  });
}

/// A default implementation of `ZetaThemeService` that uses `SharedPreferences` to store the theme data.
class ZetaDefaultThemeService extends ZetaThemeService {
  /// Constructor for `ZetaDefaultThemeService`.
  const ZetaDefaultThemeService();

  @override
  Future<(ThemeMode?, ZetaContrast?)> loadTheme() async {
    final preferences = await SharedPreferences.getInstance();

    final modeString = preferences.getString(_kThemeMode);

    final themeMode = modeString == ThemeMode.light.name
        ? ThemeMode.light
        : modeString == ThemeMode.dark.name
            ? ThemeMode.dark
            : ThemeMode.system;

    final contrastString = preferences.getString(_kContrast);
    final contrast = contrastString == ZetaContrast.aaa.name ? ZetaContrast.aaa : ZetaContrast.aa;

    return (themeMode, contrast);
  }

  @override
  Future<void> saveTheme({
    required ThemeMode themeMode,
    required ZetaContrast contrast,
  }) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setString('themeMode', themeMode.name);
    await preferences.setString('contrast', contrast.name);
  }
}
