import 'package:flutter/material.dart';

import 'color_extensions.dart';
import 'colors.dart';
import 'constants.dart';
import 'contrast.dart';

export 'breakpoints.dart';
export 'colors.dart';
export 'colors_base.dart';
export 'constants.dart';

/// A representation of the Zeta theme data.
///
/// This class encapsulates the colors and fonts used for the Zeta theme in both light and dark modes.
@immutable
class ZetaThemeData {
  /// The font family used in the Zeta theme.
  ///
  /// Defaults to [kZetaFontFamily] if not provided.
  final String fontFamily;

  /// An Identifier cab be assigned to identify the theme uniquely.
  ///
  /// It can be useful in case selected theme need to be displayed.
  ///
  /// Defaults to 'default'.
  final String identifier;

  final ZetaColors _colorsLight;

  /// The colors used for the light mode of the Zeta theme.
  ///
  /// Defaults to a light mode color palette with default Zeta colors if not explicitly provided.
  ZetaColors get colorsLight => _colorsLight;

  final ZetaColors _colorsDark;

  /// The colors used for the dark mode of the Zeta theme.
  ///
  /// Defaults to a dark mode color palette with default Zeta colors if not explicitly provided.
  ZetaColors get colorsDark => _colorsDark;

  /// Constructs a [ZetaThemeData].
  ///
  /// If [primary] and/or [secondary] colors are provided, they will be used to create the light and dark Zeta color palettes.
  ZetaThemeData({
    this.fontFamily = kZetaFontFamily,
    this.identifier = 'default',
    ZetaContrast contrast = ZetaContrast.aa,
    ZetaColors? colorsLight,
    ZetaColors? colorsDark,
    Color? primary,
    Color? secondary,
  })  : _colorsDark = (primary != null
                ? ZetaColors.dark(
                    contrast: contrast,
                    primary: primary.zetaColorSwatch,
                    secondary: secondary?.zetaColorSwatch,
                  )
                : (colorsDark ?? ZetaColors.dark()))
            .apply(contrast: contrast),
        _colorsLight = (primary != null
                ? ZetaColors.light(
                    contrast: contrast,
                    primary: primary.zetaColorSwatch,
                    secondary: secondary?.zetaColorSwatch,
                  )
                : (colorsLight ?? ZetaColors.light()))
            .apply(contrast: contrast);

  /// Applies the given [contrast] to the current [ZetaThemeData] and returns a new [ZetaThemeData] with the updated contrast.
  ZetaThemeData apply({
    required ZetaContrast contrast,
  }) {
    return ZetaThemeData(
      contrast: contrast,
      identifier: identifier,
      fontFamily: fontFamily,
      colorsDark: colorsDark,
      colorsLight: colorsLight,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZetaThemeData &&
          runtimeType == other.runtimeType &&
          fontFamily == other.fontFamily &&
          identifier == other.identifier &&
          _colorsLight == other._colorsLight &&
          _colorsDark == other._colorsDark;

  @override
  int get hashCode => fontFamily.hashCode ^ identifier.hashCode ^ _colorsLight.hashCode ^ _colorsDark.hashCode;
}
