import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Shared enum for type of buttons.
enum ZetaButtonType {
  /// Background: Primary color; defaults to blue.
  /// Border: None.
  primary,

  /// Background: Secondary color; defaults to yellow.
  /// Border: None.
  secondary,

  /// Background: Positive color; defaults to green.
  /// Border: None.
  positive,

  /// Background: Negative color; defaults to red.
  /// Border: None.
  negative,

  /// Background: None.
  /// Border: Primary color; defaults to blue.
  outline,

  /// Background: None.
  /// Border: Subtle color; defaults to cool grey.
  outlineSubtle,

  /// Background: None.
  /// Border: None.
  /// Foreground color: Primary; defaults to blue.
  text,
}

/// Button utility functions for styling
extension ButtonFunctions on ZetaButtonType {
  /// Returns color based on [ZetaButtonType]
  ZetaColorSwatch color(ZetaColors colors) {
    switch (this) {
      case ZetaButtonType.secondary:
        return colors.secondary;
      case ZetaButtonType.positive:
        return colors.positive;
      case ZetaButtonType.negative:
        return colors.negative;
      case ZetaButtonType.outline:
      case ZetaButtonType.primary:
        return colors.primary;
      case ZetaButtonType.outlineSubtle:
      case ZetaButtonType.text:
        return colors.cool;
    }
  }

  /// Returns if button has border
  bool get border => this == ZetaButtonType.outline || this == ZetaButtonType.outlineSubtle;

  ///Returns if button is solid
  bool get solid => index < 4;
}

extension on ZetaColors {}

///Border utility functions
extension BorderFunctions on ZetaWidgetBorder {
  ///Returns radius based on [ZetaWidgetBorder]
  BorderRadius get radius {
    switch (this) {
      case ZetaWidgetBorder.sharp:
        return ZetaRadius.none;
      case ZetaWidgetBorder.rounded:
        return ZetaRadius.minimal;
      case ZetaWidgetBorder.full:
        return ZetaRadius.full;
    }
  }
}

/// Shared buttonStyle for buttons and icon buttons
ButtonStyle buttonStyle(
  ZetaColors colors,
  ZetaWidgetBorder borderType,
  ZetaButtonType type,
  Color? backgroundColor,
) {
  final ZetaColorSwatch color =
      backgroundColor != null ? ZetaColorSwatch.fromColor(backgroundColor) : type.color(colors);

  final bool isSolid = type.solid || backgroundColor != null;

  return ButtonStyle(
    minimumSize: WidgetStateProperty.all(const Size.square(32)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: borderType.radius),
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.surfaceDisabled;
        }
        if (states.contains(WidgetState.pressed)) {
          return isSolid ? color.shade70 : colors.primary.shade10;
        }
        if (states.contains(WidgetState.hovered)) {
          return isSolid ? color.shade50 : colors.cool.shade20;
        }
        if (backgroundColor != null) return backgroundColor;
        return isSolid ? color : Colors.transparent;
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.textDisabled;
        }
        switch (type) {
          case ZetaButtonType.outline:
          case ZetaButtonType.text:
            return colors.primary;
          case ZetaButtonType.outlineSubtle:
            return colors.textDefault;
          case ZetaButtonType.primary:
          case ZetaButtonType.secondary:
          case ZetaButtonType.positive:
          case ZetaButtonType.negative:
            return color.onColor;
        }
      },
    ),
    overlayColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      return null;
    }),
    side: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (type.border && states.contains(WidgetState.disabled)) {
        return BorderSide(color: colors.borderDisabled);
      }
      // TODO(thelukewalton): This removes a defualt border when focused, rather than adding a second border when focused.
      if (states.contains(WidgetState.focused)) {
        return BorderSide(color: colors.blue, width: ZetaSpacing.x0_5);
      }
      if (type.border) {
        return BorderSide(
          color: type == ZetaButtonType.outline ? colors.primary.border : colors.borderSubtle,
        );
      }

      return null;
    }),
    elevation: const WidgetStatePropertyAll(0),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
  );
}
