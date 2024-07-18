import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

/// Easily craft stunning Flutter themes using pre-set color patterns or your own
/// choices.
///
/// While Flutter's [ThemeData.from] offers a starting point for [ColorScheme]-based
/// themes, it sometimes defaults to the standard [ThemeData] factory, leading to inconsistencies,
/// particularly in dark themes. [ZetaColorScheme] addresses this by ensuring a seamless theme creation
/// with the [ColorScheme] approach.
///
/// Themes can be formed using a default [ColorScheme], or by inputting select color values. If both a
/// [ColorScheme] and individual colors are provided, the individual colors will prevail.
///
/// These factory constructors enable the creation of color-toned themes from a singular color. Additionally,
/// [ZetaColorScheme] simplifies theme crafting with color-branded backgrounds, blending different color degrees, primarily
/// the primary color.
///
/// Adjusting the themed background of the [AppBar] is straightforward with [ZetaColorScheme], ensuring it aligns with themed colors.
/// {@category Theme}
@immutable
class ZetaColorScheme extends ColorScheme with Diagnosticable {
  /// Default constructor with no required properties.
  ///
  /// Creates a light theme by default using the M2 colors as its default
  /// theme.
  const ZetaColorScheme({
    required this.zetaColors,

    /// If null, defaults to  [kZetaFontFamily];
    this.fontFamily = kZetaFontFamily,
    required super.brightness,
    @Deprecated('Use surface instead. ' 'This feature was deprecated after v3.18.0-0.1.pre.') super.background,
    required super.error,
    @Deprecated('Use onSurface instead. ' 'This feature was deprecated after v3.18.0-0.1.pre.') super.onBackground,
    required super.onError,
    required super.onPrimary,
    required super.onSecondary,
    required super.onSurface,
    required super.primary,
    required super.secondary,
    required super.surface,
    super.errorContainer,
    super.inversePrimary,
    super.inverseSurface,
    super.onErrorContainer,
    super.onInverseSurface,
    super.onPrimaryContainer,
    super.onSecondaryContainer,
    super.onSurfaceVariant,
    super.onTertiary,
    super.onTertiaryContainer,
    super.outline,
    super.outlineVariant,
    super.primaryContainer,
    super.scrim,
    super.secondaryContainer,
    super.shadow,
    super.surfaceTint,
    @Deprecated('Use surfaceContainerHighest instead. ' 'This feature was deprecated after v3.18.0-0.1.pre.')
    super.surfaceVariant,
    super.tertiary,
    super.tertiaryContainer,
    super.primaryFixed,
    super.primaryFixedDim,
    super.onPrimaryFixed,
    super.onPrimaryFixedVariant,
    super.secondaryFixed,
    super.secondaryFixedDim,
    super.onSecondaryFixed,
    super.onSecondaryFixedVariant,
    super.surfaceDim,
    super.surfaceBright,
    super.surfaceContainerLowest,
    super.surfaceContainerLow,
    super.surfaceContainer,
    super.surfaceContainerHigh,
    super.surfaceContainerHighest,
  });

  /// Current instance of the [ZetaColors]
  final ZetaColors zetaColors;

  /// Name of the font family to use as default font for the text theme in
  /// created theme.
  ///
  /// Same feature as in [ThemeData] factory. Used to apply the font family
  /// name to default text theme and primary text theme, also passed along
  /// to [ThemeData],
  final String? fontFamily;

  /// Creates the copy of the current scheme from the provided values.
  @override
  ZetaColorScheme copyWith({
    ZetaColors? zetaColors,
    String? fontFamily,
    Brightness? brightness,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? primaryFixed,
    Color? primaryFixedDim,
    Color? onPrimaryFixed,
    Color? onPrimaryFixedVariant,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? secondaryFixed,
    Color? secondaryFixedDim,
    Color? onSecondaryFixed,
    Color? onSecondaryFixedVariant,
    Color? tertiary,
    Color? onTertiary,
    Color? tertiaryContainer,
    Color? onTertiaryContainer,
    Color? tertiaryFixed,
    Color? tertiaryFixedDim,
    Color? onTertiaryFixed,
    Color? onTertiaryFixedVariant,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    @Deprecated('Use surface instead. ' 'This feature was deprecated after v3.18.0-0.1.pre.') Color? background,
    @Deprecated('Use onSurface instead. ' 'This feature was deprecated after v3.18.0-0.1.pre.') Color? onBackground,
    Color? surface,
    Color? onSurface,
    @Deprecated('Use surfaceContainerHighest instead. ' 'This feature was deprecated after v3.18.0-0.1.pre.')
    Color? surfaceVariant,
    Color? surfaceDim,
    Color? surfaceBright,
    Color? surfaceContainerLowest,
    Color? surfaceContainerLow,
    Color? surfaceContainer,
    Color? surfaceContainerHigh,
    Color? surfaceContainerHighest,
    Color? onSurfaceVariant,
    Color? outline,
    Color? outlineVariant,
    Color? shadow,
    Color? scrim,
    Color? inverseSurface,
    Color? onInverseSurface,
    Color? inversePrimary,
    Color? surfaceTint,
  }) {
    return ZetaColorScheme(
      zetaColors: zetaColors ?? this.zetaColors,
      fontFamily: fontFamily ?? this.fontFamily,
      brightness: brightness ?? this.brightness,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryFixed: primaryFixed ?? this.primaryFixed,
      primaryFixedDim: primaryFixedDim ?? this.primaryFixedDim,
      onPrimaryFixed: onPrimaryFixed ?? this.onPrimaryFixed,
      onPrimaryFixedVariant: onPrimaryFixedVariant ?? this.onPrimaryFixedVariant,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryFixed: secondaryFixed ?? this.secondaryFixed,
      secondaryFixedDim: secondaryFixedDim ?? this.secondaryFixedDim,
      onSecondaryFixed: onSecondaryFixed ?? this.onSecondaryFixed,
      onSecondaryFixedVariant: onSecondaryFixedVariant ?? this.onSecondaryFixedVariant,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      tertiaryContainer: tertiaryContainer ?? this.tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer ?? this.onTertiaryContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceDim: surfaceDim ?? this.surfaceDim,
      surfaceBright: surfaceBright ?? this.surfaceBright,
      surfaceContainerLowest: surfaceContainerLowest ?? this.surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow ?? this.surfaceContainerLow,
      surfaceContainer: surfaceContainer ?? this.surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh ?? this.surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest ?? this.surfaceContainerHighest,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      outline: outline ?? this.outline,
      outlineVariant: outlineVariant ?? this.outlineVariant,
      shadow: shadow ?? this.shadow,
      scrim: scrim ?? this.scrim,
      inverseSurface: inverseSurface ?? this.inverseSurface,
      onInverseSurface: onInverseSurface ?? this.onInverseSurface,
      inversePrimary: inversePrimary ?? this.inversePrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ZetaColors>('zetaColors', zetaColors))
      ..add(StringProperty('fontFamily', fontFamily));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ZetaColorScheme &&
          runtimeType == other.runtimeType &&
          zetaColors == other.zetaColors &&
          fontFamily == other.fontFamily;

  @override
  int get hashCode => super.hashCode ^ zetaColors.hashCode ^ fontFamily.hashCode;
}
