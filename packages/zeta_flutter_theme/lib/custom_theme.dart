import 'package:flutter/material.dart';

import 'color_swatch.dart';

/// A custom theme that can be used to define custom colors for the app.
///
class ZetaCustomTheme {
  /// Constructs a [ZetaCustomTheme].
  /// To define every shade of a color, provide a [ZetaColorSwatch] or a [MaterialColor].
  /// If only a [Color] is provided, a [ZetaColorSwatch] will be automatically generated.
  ZetaCustomTheme({
    required this.id,
    Color? primary,
    Color? primaryDark,
    Color? secondary,
    Color? secondaryDark,
  })  : assert(
          !(primaryDark != null && primary == null),
          'Primary dark cannot be set without a primary color',
        ),
        assert(
          !(secondaryDark != null && secondary == null),
          'Secondary dark cannot be set without a secondary color',
        ),
        primary = primary != null ? ZetaColorSwatch.fromColor(primary) : null,
        primaryDark = primaryDark != null
            ? ZetaColorSwatch.fromColor(primaryDark)
            : primary != null
                ? ZetaColorSwatch.inverse(ZetaColorSwatch.fromColor(primary))
                : null,
        secondary = secondary != null ? ZetaColorSwatch.fromColor(secondary) : null,
        secondaryDark = secondaryDark != null
            ? ZetaColorSwatch.fromColor(secondaryDark)
            : secondary != null
                ? ZetaColorSwatch.inverse(ZetaColorSwatch.fromColor(secondary))
                : null;

  /// The ID of the custom theme.
  final String id;

  /// The primary color of the custom theme.
  final ZetaColorSwatch? primary;

  /// The dark primary color of the custom theme.
  final ZetaColorSwatch? primaryDark;

  /// The secondary color of the custom theme.
  final ZetaColorSwatch? secondary;

  /// The dark secondary color of the custom theme.
  final ZetaColorSwatch? secondaryDark;
}
