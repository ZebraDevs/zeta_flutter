import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'color_extensions.dart';
import 'contrast.dart';

/// {@template zeta-color-swatch}
/// Contains shades from 10 (light) to 100 (dark).
///
/// See also:
/// * [ColorSwatch].
/// {@endtemplate}
///
/// {@category Theme}
@immutable
class ZetaColorSwatch extends ColorSwatch<int> with EquatableMixin {
  /// Constructs a [ZetaColorSwatch].
  ///
  ///
  /// See also:
  /// * [MaterialColor].
  const ZetaColorSwatch({
    required int primary,
    required Map<int, Color> swatch,
  }) : super(primary, swatch);

  /// {@template zeta.color.color_to_swatch}
  /// `ZetaColorSwatch` is a color swatch utility to produce different shades
  /// of a primary color, following a specific progression of lightness and darkness.
  ///
  /// This factory constructor creates a color swatch based on a provided primary color.
  /// The darker and lighter shades are determined by predefined percentage values.
  ///
  /// It ensures that the 60th and 80th shades from swatch abide by AA and AAA accessibility standards on `background`, respectively.
  /// {@endtemplate}
  // TODO(UX-1144): Find a way to make this better
  factory ZetaColorSwatch.fromColor(
    Color primary, {
    Color background = Colors.white,
  }) {
    /// Returns a map of colors shades with their respective indexes.
    /// Darker shades are obtained by darkening the primary color and
    /// lighter shades by lightening it.
    ///
    /// - 100, 90, 80, and 70 are darker shades of the primary color.
    /// - 60 is the primary color itself.
    /// - 50, 40, 30, 20, and 10 are progressively lighter shades of the primary color.
    if (primary is ZetaColorSwatch) {
      return primary;
    } else if (primary is MaterialColor) {
      return ZetaColorSwatch.fromMaterialColor(primary);
    }
    return ZetaColorSwatch(
      primary: primary.intValue,
      swatch: primary.generateSwatch(background: background),
    );
  }

  /// Creates a [ZetaColorSwatch] from a [MaterialColor] swatch.
  factory ZetaColorSwatch.fromMaterialColor(MaterialColor swatch) {
    return ZetaColorSwatch(
      primary: swatch.intValue,
      swatch: {
        10: swatch.shade50,
        20: swatch.shade100,
        30: swatch.shade200,
        40: swatch.shade300,
        50: swatch.shade400,
        60: swatch.shade500,
        70: swatch.shade600,
        80: swatch.shade700,
        90: swatch.shade800,
        100: swatch.shade900,
      },
    );
  }

  /// Creates a [ZetaColorSwatch] from a [ZetaColorSwatch] with inverted shades.
  factory ZetaColorSwatch.inverse(ZetaColorSwatch swatch) {
    return ZetaColorSwatch(
      primary: swatch.shade40.intValue,
      swatch: {
        10: swatch.shade100,
        20: swatch.shade90,
        30: swatch.shade80,
        40: swatch.shade70,
        50: swatch.shade60,
        60: swatch.shade50,
        70: swatch.shade40,
        80: swatch.shade30,
        90: swatch.shade20,
        100: swatch.shade10,
      },
    );
  }

  /// The lightest shade.
  Color get shade10 => this[10]!;

  /// The second lightest shade.
  Color get shade20 => this[20]!;

  /// The third lightest shade.
  Color get shade30 => this[30]!;

  /// The fourth lightest shade.
  Color get shade40 => this[40]!;

  /// The fifth lightest shade.
  Color get shade50 => this[50]!;

  /// The default shade.
  Color get shade60 => this[60]!;

  /// The fourth darkest shade.
  Color get shade70 => this[70]!;

  /// The third darkest shade.
  Color get shade80 => this[80]!;

  /// The second darkest shade.
  Color get shade90 => this[90]!;

  /// The darkest shade.
  Color get shade100 => this[100]!;

  /// Takes an integer as argument and returns a color shade based on that number.
  /// If no shade with the given number exists, it returns the color itself.
  ///
  /// [number] - The number representing the shade of the color.
  /// Returns a color object that represents a specified shade or the color itself.
  ///
  Color shade(int number) => this[number]!;

  /// Creates a copy of the current [ZetaColorSwatch] with potential modifications
  /// based on the provided [contrast] and [brightness].
  ///
  /// The [contrast] determines which shade of the color should be used
  /// as the primary color in the copied swatch.
  ///
  /// - [contrast] : The shade to use as the primary color in the new swatch.
  ///   Defaults to [ZetaContrast.aa].
  /// - [brightness] : The brightness value for the new swatch.
  ///   Defaults to [Brightness.light].
  ZetaColorSwatch apply({
    ZetaContrast contrast = ZetaContrast.aa,
    Brightness brightness = Brightness.light,
  }) {
    // Generate a list of indices based on brightness level
    final indices = List.generate(10, (index) => (index + 1) * 10);

    // Create a new map (swatch) based on the indices and current swatch values
    final swatch = Map<int, Color>.fromEntries(indices.map((i) => MapEntry(i, super[i] ?? this)));

    // Determine the primaryIndex color of the new swatch based on the accessibility level
    final primaryIndex = brightness == Brightness.light ? contrast.primary : 110 - contrast.primary;

    // Return a new ZetaColorSwatch object with the new primaryIndex color and swatch
    return ZetaColorSwatch(
      primary: swatch[primaryIndex]!.intValue,
      swatch: swatch,
    );
  }

  @override
  List<Object?> get props => [
        shade10,
        shade20,
        shade30,
        shade40,
        shade50,
        shade60,
        shade70,
        shade80,
        shade90,
        shade100,
      ];
}

/// A swatch of colors with values 0 (light), 500 (medium) and 1000(dark).
class ZetaPureColorSwatch extends ColorSwatch<int> with EquatableMixin {
  /// Constructs a [ZetaPureColorSwatch].
  ///
  /// See also:
  /// * [MaterialColor].
  const ZetaPureColorSwatch({
    required int primary,
    required Map<int, Color> swatch,
    this.brightness = Brightness.light,
  }) : super(primary, swatch);

  /// Selected contrast level of the system
  final Brightness brightness;

  /// Lightest shade of the color.
  Color get shade0 => this[0] ?? Colors.white;

  /// Medium shade of the color.
  Color get shade500 => this[500] ?? Colors.grey;

  /// Darkest shade of the color.
  Color get shade1000 => this[1000] ?? Colors.white;

  /// Takes an integer as argument and returns a color shade based on that number.
  Color shade(int number) => this[number]!;

  /// Creates a copy of the current [ZetaColorSwatch] with potential modifications
  /// based on the provided [contrast] and [brightness].
  ///
  /// The [contrast] determines which shade of the color should be used
  /// as the primary color in the copied swatch.
  ///
  /// - [contrast] : The shade to use as the primary color in the new swatch.
  ///   Defaults to [ZetaContrast.aa].
  /// - [brightness] : The brightness value for the new swatch.
  ///   Defaults to [Brightness.light].
  ZetaPureColorSwatch apply({
    ZetaContrast contrast = ZetaContrast.aa,
    Brightness brightness = Brightness.light,
  }) {
    if (this.brightness == brightness) return this;

    return ZetaPureColorSwatch(
      brightness: brightness,
      primary: this[500]!.intValue,
      swatch: {
        0: this[0]!,
        500: this[500]!,
        1000: this[1000]!,
      },
    );
  }

  @override
  List<Object?> get props => [shade0, shade500, shade1000];
}
