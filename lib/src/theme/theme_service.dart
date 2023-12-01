import 'package:flutter/material.dart';

import 'contrast.dart';
import 'theme_data.dart';

/// `ZetaThemeService` is an abstract class.
/// It provides the structure for loading and saving themes in Zeta application.

abstract class ZetaThemeService {
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
  Future<(ZetaThemeData?, ThemeMode?, ZetaContrast?)> loadTheme();

  /// Saves the provided theme data as the application's theme.
  ///
  /// `saveTheme` is a method used to save the current theme data.
  ///
  /// Takes a `ZetaThemeData` object that represents the theme to be saved.
  ///
  /// Returns a `Future` that completes when the theme data has been successfully saved.

  Future<void> saveTheme({
    required ZetaThemeData themeData,
    required ThemeMode themeMode,
    required ZetaContrast contrast,
  });
}
