import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contrast.dart';
import 'generated/tokens/zeta_tokens.g.dart';

const String _kThemeMode = 'themeMode';
const String _kContrast = 'contrast';
const String _kThemeId = 'theme_id';
const String _kFontFamily = 'fontFamily';
const String _kColorMode = 'colorMode';
const String _kPrimitivesTheme = 'primitivesTheme';
const String _kPaletteTheme = 'paletteTheme';
const String _kSizeTheme = 'sizeTheme';
const String _kTypographyTheme = 'typographyTheme';

/// `ZetaThemeData` is a class that holds the theme data to be stored with the theme service.
///
/// It contains the theme mode, contrast, font family, color mode and token layer themes.
class ZetaThemeServiceData extends Equatable {
  /// Constructs a [ZetaThemeServiceData].
  ///
  /// All fields are optional. If null, defaults will be used.
  const ZetaThemeServiceData({
    this.themeId,
    this.themeMode,
    this.contrast,
    this.fontFamily,
    this.colorMode,
    this.primitivesTheme,
    this.paletteTheme,
    this.sizeTheme,
    this.typographyTheme,
  });

  /// The unique identifier for the custom theme data.
  final String? themeId;

  /// The theme mode of the Zeta theme.
  final ThemeMode? themeMode;

  /// The contrast of the Zeta theme.
  final ZetaContrast? contrast;

  /// The font family of the Zeta theme.
  final String? fontFamily;

  /// The explicitly selected color mode of the tokens; null follows [themeMode].
  final ZetaColorMode? colorMode;

  /// The theme of the `primitives` token layer.
  final ZetaPrimitivesTheme? primitivesTheme;

  /// The theme of the `palette` token layer.
  final ZetaPaletteTheme? paletteTheme;

  /// The theme of the `size` token layer.
  final ZetaSizeTheme? sizeTheme;

  /// The theme of the `typography` token layer.
  final ZetaTypographyTheme? typographyTheme;

  @override
  List<Object?> get props =>
      [themeId, themeMode, contrast, fontFamily, colorMode, primitivesTheme, paletteTheme, sizeTheme, typographyTheme];
}

/// `ZetaThemeService` is an abstract class.
/// It provides the structure for loading and saving themes in Zeta application.
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
  /// Returns a Future [ZetaThemeServiceData].
  Future<ZetaThemeServiceData> loadTheme();

  /// Saves the provided theme data as the application's theme.
  ///
  /// `saveTheme` is a method used to save the current theme data.
  ///
  /// Takes a `ZetaThemeData` object that represents the theme to be saved.
  ///
  /// Returns a `Future` that completes when the theme data has been successfully saved.

  Future<void> saveTheme({required ZetaThemeServiceData themeData});
}

/// A default implementation of `ZetaThemeService` that uses `SharedPreferences` to store the theme data.
class ZetaDefaultThemeService extends ZetaThemeService {
  /// Constructor for `ZetaDefaultThemeService`.
  const ZetaDefaultThemeService();

  @override
  Future<ZetaThemeServiceData> loadTheme() async {
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
    final fontFamily = preferences.getString(_kFontFamily);

    // Enums are stored by name; unknown names (e.g. a theme removed from Figma) load as null.
    T? byName<T extends Enum>(List<T> values, String key) => values.asNameMap()[preferences.getString(key)];

    return ZetaThemeServiceData(
      themeMode: themeMode,
      contrast: contrast,
      themeId: themeId,
      fontFamily: fontFamily,
      colorMode: byName(ZetaColorMode.values, _kColorMode),
      primitivesTheme: byName(ZetaPrimitivesTheme.values, _kPrimitivesTheme),
      paletteTheme: byName(ZetaPaletteTheme.values, _kPaletteTheme),
      sizeTheme: byName(ZetaSizeTheme.values, _kSizeTheme),
      typographyTheme: byName(ZetaTypographyTheme.values, _kTypographyTheme),
    );
  }

  @override
  Future<void> saveTheme({required ZetaThemeServiceData themeData}) async {
    final preferences = await SharedPreferences.getInstance();
    final List<Future<void>> futures = [];

    if (themeData.fontFamily != null) {
      futures.add(preferences.setString(_kFontFamily, themeData.fontFamily!));
    }
    if (themeData.themeMode != null) {
      futures.add(preferences.setString(_kThemeMode, themeData.themeMode!.name));
    }
    if (themeData.contrast != null) {
      futures.add(preferences.setString(_kContrast, themeData.contrast!.name));
    }
    if (themeData.themeId != null) {
      futures.add(preferences.setString(_kThemeId, themeData.themeId!));
    } else {
      futures.add(preferences.remove(_kThemeId));
    }
    // A null color mode means "follow the theme mode", so it is removed rather than skipped.
    if (themeData.colorMode != null) {
      futures.add(preferences.setString(_kColorMode, themeData.colorMode!.name));
    } else {
      futures.add(preferences.remove(_kColorMode));
    }
    for (final (key, theme) in [
      (_kPrimitivesTheme, themeData.primitivesTheme),
      (_kPaletteTheme, themeData.paletteTheme),
      (_kSizeTheme, themeData.sizeTheme),
      (_kTypographyTheme, themeData.typographyTheme),
    ]) {
      if (theme != null) futures.add(preferences.setString(key, theme.name));
    }
    await Future.wait(futures);
  }
}
