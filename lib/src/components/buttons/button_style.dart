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
  /// Returns background color based on [ZetaButtonType]
  Color backgroundColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaButtonType.primary:
        return colors.statePrimaryEnabled;
      case ZetaButtonType.secondary:
        return colors.stateSecondaryEnabled;
      case ZetaButtonType.positive:
        return colors.statePositiveEnabled;
      case ZetaButtonType.negative:
        return colors.stateNegativeEnabled;
      case ZetaButtonType.outline:
      case ZetaButtonType.outlineSubtle:
      case ZetaButtonType.text:
        return colors.stateDefaultEnabled;
    }
  }

  /// Returns hover color based on [ZetaButtonType]
  Color hoverColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaButtonType.primary:
        return colors.statePrimaryHover;
      case ZetaButtonType.secondary:
        return colors.stateSecondaryHover;
      case ZetaButtonType.positive:
        return colors.statePositiveHover;
      case ZetaButtonType.negative:
        return colors.stateNegativeHover;
      case ZetaButtonType.outline:
      case ZetaButtonType.outlineSubtle:
      case ZetaButtonType.text:
        return colors.stateDefaultHover;
    }
  }

  /// Returns pressed color based on [ZetaButtonType]
  Color pressedColor(ZetaColorSemantics colors) {
    switch (this) {
      case ZetaButtonType.primary:
        return colors.statePrimarySelected;
      case ZetaButtonType.secondary:
        return colors.stateSecondarySelected;
      case ZetaButtonType.positive:
        return colors.statePositiveSelected;
      case ZetaButtonType.negative:
        return colors.stateNegativeSelected;
      case ZetaButtonType.outline:
      case ZetaButtonType.outlineSubtle:
      case ZetaButtonType.text:
        return colors.stateDefaultSelected;
    }
  }

  /// Returns if button has border
  bool get border => this == ZetaButtonType.outline || this == ZetaButtonType.outlineSubtle;

  ///Returns if button is solid
  bool get solid => index < 4;
}

///Border utility functions
extension BorderFunctions on ZetaWidgetBorder {
  ///Returns radius based on [ZetaWidgetBorder]
  BorderRadius radius(BuildContext context) {
    switch (this) {
      case ZetaWidgetBorder.sharp:
        return Zeta.of(context).radius.none;
      case ZetaWidgetBorder.rounded:
        return Zeta.of(context).radius.minimal;
      case ZetaWidgetBorder.full:
        return Zeta.of(context).radius.full;
    }
  }
}

/// Shared buttonStyle for buttons and icon buttons
ButtonStyle buttonStyle(
  BuildContext context,
  ZetaWidgetBorder borderType,
  ZetaButtonType type,
) {
  final ZetaColorSemantics colors = Zeta.of(context).colors;
  final Color backgroundColor = type.backgroundColor(colors);
  final Color backgroundColorHover = type.hoverColor(colors);
  final Color backgroundColorPressed = type.pressedColor(colors);

  return ButtonStyle(
    minimumSize: WidgetStateProperty.all(Size.square(Zeta.of(context).spacing.xl_4)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: borderType.radius(context)),
    ),
    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.stateDisabledDisabled;
        }
        if (states.contains(WidgetState.pressed)) {
          return backgroundColorPressed;
        }
        if (states.contains(WidgetState.hovered)) {
          return backgroundColorHover;
        }
        return backgroundColor;
      },
    ),
    foregroundColor: WidgetStateProperty.resolveWith<Color?>(
      (states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.mainDisabled;
        }
        switch (type) {
          case ZetaButtonType.outline:
          case ZetaButtonType.text:
            return colors.mainPrimary;
          case ZetaButtonType.outlineSubtle:
            return colors.mainDefault;
          case ZetaButtonType.primary:
          case ZetaButtonType.secondary:
          case ZetaButtonType.positive:
          case ZetaButtonType.negative:
            return colors.mainInverse;
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
      // TODO(UX-1134): This removes a defualt border when focused, rather than adding a second border when focused.
      if (states.contains(WidgetState.focused)) {
        return BorderSide(color: colors.borderPrimary, width: ZetaBorders.medium);
      }
      if (type.border) {
        return BorderSide(
          color: type == ZetaButtonType.outline ? colors.borderPrimaryMain : colors.borderSubtle,
        );
      }

      return null;
    }),
    elevation: const WidgetStatePropertyAll(0),
    padding: WidgetStateProperty.all(EdgeInsets.zero),
  );
}
