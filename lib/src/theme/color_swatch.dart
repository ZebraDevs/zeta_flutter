import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'color_extensions.dart';
import 'colors_base.dart';
import 'contrast.dart';

/// A swatch of colors with values from 10 (light) to 100 (dark).
/// {@category Theme}
@immutable
class ZetaColorSwatch extends ColorSwatch<int> with EquatableMixin {
  /// Constructs a [ZetaColorSwatch].
  ///
  /// See also:
  /// * [MaterialColor].
  const ZetaColorSwatch({
    this.brightness = Brightness.light,
    this.contrast = ZetaContrast.aa,
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
  /// It ensures that the 60th and 80th shades from swatch are abide by the AA and AAA accessibility standards on `background`, respectively.
  /// `background` color defaults to [ZetaColorBase.warm] shade10.
  /// {@endtemplate}
  factory ZetaColorSwatch.fromColor(
    Color primary, {
    Brightness brightness = Brightness.light,
    ZetaContrast contrast = ZetaContrast.aa,
    Color background = Colors.white,
  }) {
    /// Returns a map of colors shades with their respective indexes.
    /// Darker shades are obtained by darkening the primary color and
    /// lighter shades by lightening it.
    ///
    /// - 100, 90, 80, and 70 are darker shades of the primary color.
    /// - 60 is the primary color itself.
    /// - 50, 40, 30, 20, and 10 are progressively lighter shades of the primary color.
    return ZetaColorSwatch(
      contrast: contrast,
      brightness: brightness,
      primary: primary.value,
      swatch: primary.generateSwatch(background: background),
    ).apply(brightness: brightness);
  }

  /// Selected contrast level of the system
  final Brightness brightness;

  /// Selected contrast level of the system
  final ZetaContrast contrast;

  /// This method is an override of the index operator.
  ///
  /// If the requested index is not in the table (i.e., it results in `null`), the method returns `this`,
  /// presumably the default color.
  ///
  /// [index] The index of the color swatch to return. Must be a non-negative integer.
  ///
  /// Returns the color at the specified swatch index, or the default color if the index is not in the table.
  @override
  Color? operator [](int index) => super[brightness == Brightness.dark ? 110 - index : index] ?? this;

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

  /// Returns the color shade for a surface depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  Color get text => shade(contrast.text);

  /// Returns the color shade for an icon depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  Color get icon => shade(contrast.icon);

  /// Returns the color shade for a hover state depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 70.
  /// For [ZetaContrast.aaa], it returns 90.
  Color get hover => shade(contrast.hover);

  /// Returns the color shade for a selected state depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 80.
  /// For [ZetaContrast.aaa], it returns 100.
  Color get selected => shade(contrast.selected);

  /// Returns the color shade for a focus state depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 80.
  /// For [ZetaContrast.aaa], it returns 100.
  Color get focus => shade(contrast.focus);

  /// Returns the color shade for a border depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  Color get border => shade(contrast.border);

  /// Returns the color shade for a subtle visual element depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 40.
  /// For [ZetaContrast.aaa], it returns 60.
  Color get subtle => shade(contrast.subtle);

  /// Returns the color shade for a surface depending on the ZetaContrast value.
  ///
  /// For both [ZetaContrast.aa] and [ZetaContrast.aaa], it returns 10.
  Color get surface => shade(contrast.surface);

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
    if (this.contrast == contrast && this.brightness == brightness) return this;

    // Generate a list of indices based on brightness level
    final indices = List.generate(10, (index) => (index + 1) * 10);

    // Create a new map (swatch) based on the indices and current swatch values
    final swatch = Map<int, Color>.fromEntries(indices.map((i) => MapEntry(i, super[i] ?? this)));

    // Determine the primaryIndex color of the new swatch based on the accessibility level
    final primaryIndex = brightness == Brightness.light ? contrast.primary : 110 - contrast.primary;

    // Return a new ZetaColorSwatch object with the new primaryIndex color and swatch
    return ZetaColorSwatch(
      contrast: contrast,
      brightness: brightness,
      primary: swatch[primaryIndex]!.value,
      swatch: swatch,
    );
  }

  @override
  List<Object?> get props => [
        super.value,
        brightness,
        contrast,
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
      primary: this[500]!.value,
      swatch: {
        0: this[0]!,
        500: this[500]!,
        1000: this[1000]!,
      },
    );
  }

  @override
  List<Object?> get props => [super.value, shade0, shade500, shade1000];
}
