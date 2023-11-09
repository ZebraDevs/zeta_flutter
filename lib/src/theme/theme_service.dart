import 'theme_data.dart';

/// `ZetaThemeService` is an abstract class.
/// It provides the structure for loading and saving themes in Zeta application.

abstract class ZetaThemeService {
  /// Loads the application's theme.
  ///
  /// `loadTheme` is a method to retrieve the current theme data.
  ///
  /// Returns a `Future` that completes with the `ZetaThemeData` object
  /// that represents the current theme.

  Future<ZetaThemeData?> loadTheme();

  /// Saves the provided theme data as the application's theme.
  ///
  /// `saveTheme` is a method used to save the current theme data.
  ///
  /// Takes a `ZetaThemeData` object that represents the theme to be saved.
  ///
  /// Returns a `Future` that completes when the theme data has been successfully saved.

  Future<void> saveTheme(ZetaThemeData themeData);
}
