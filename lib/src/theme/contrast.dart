/// ZetaAccessibilityStandard is an enumeration that defines the Web Content Accessibility Guidelines (WCAG) 2.1.
/// It includes two levels of conformance: AA (minimum) and AAA (enhanced).
enum ZetaContrast {
  /// AA: The contrast ratio should be at least 4.57:1
  aa,

  /// AAA: The contrast ratio should be at least 8.33:1
  aaa,
}

/// Extension on [ZetaContrast] to provide color indices
/// for certain accessibility scenarios
extension AccessibilityIndices on ZetaContrast {
  /// Returns the color index value for a primary depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  int get primary {
    switch (this) {
      case ZetaContrast.aa:
        return 60;
      case ZetaContrast.aaa:
        return 80;
    }
  }

  /// Returns the color index value for a surface depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  int get text {
    switch (this) {
      case ZetaContrast.aa:
        return 60;
      case ZetaContrast.aaa:
        return 80;
    }
  }

  /// Returns the color index value for an icon depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  int get icon {
    switch (this) {
      case ZetaContrast.aa:
        return 60;
      case ZetaContrast.aaa:
        return 80;
    }
  }

  /// Returns the color index value for a hover state depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 70.
  /// For [ZetaContrast.aaa], it returns 90.
  int get hover {
    switch (this) {
      case ZetaContrast.aa:
        return 70;
      case ZetaContrast.aaa:
        return 90;
    }
  }

  /// Returns the color index value for a selected state depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 80.
  /// For [ZetaContrast.aaa], it returns 100.
  int get selected {
    switch (this) {
      case ZetaContrast.aa:
        return 80;
      case ZetaContrast.aaa:
        return 100;
    }
  }

  /// Returns the color index value for a focus state depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 80.
  /// For [ZetaContrast.aaa], it returns 100.
  int get focus {
    switch (this) {
      case ZetaContrast.aa:
        return 80;
      case ZetaContrast.aaa:
        return 100;
    }
  }

  /// Returns the color index value for a border depending on the ZetaContrast value.
  ///
  /// For [ZetaContrast.aa], it returns 60.
  /// For [ZetaContrast.aaa], it returns 80.
  int get border {
    switch (this) {
      case ZetaContrast.aa:
        return 60;
      case ZetaContrast.aaa:
        return 80;
    }
  }

  /// Returns the color index value for a subtle visual element depending on the ZetaContrast value.
  ///
  /// For both [ZetaContrast.aa] and [ZetaContrast.aaa], it returns 40.
  int get subtle {
    switch (this) {
      case ZetaContrast.aa:
        return 40;
      case ZetaContrast.aaa:
        return 40;
    }
  }

  /// Returns the color index value for a surface depending on the ZetaContrast value.
  ///
  /// For both [ZetaContrast.aa] and [ZetaContrast.aaa], it returns 10.
  int get surface {
    switch (this) {
      case ZetaContrast.aa:
        return 10;
      case ZetaContrast.aaa:
        return 10;
    }
  }
}
