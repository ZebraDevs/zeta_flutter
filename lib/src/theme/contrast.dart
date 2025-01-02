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

  /// Returns the target contrast value.
  ///
  /// The getter, `targetContrast`, returns a double value that represents the
  /// contrast ratio of a ZetaContrast object. The ratio can be either `4.53` or `8.33`,
  /// depending on whether the contrast level of this instance is `ZetaContrast.aa` or `ZetaContrast.aaa`.
  ///
  /// * When the object's contrast level is `aa`, the method returns `4.53`.
  /// * When the object's contrast level is `aaa`, the method returns `8.33`.
  ///
  /// These values serve as benchmarks for the contrast between the colours on a app's text
  /// and background. Being able to measure and adjust this contrast plays a critical role in
  /// improving a app's accessibility.
  double get targetContrast {
    switch (this) {
      case ZetaContrast.aa:
        return 4.53;
      case ZetaContrast.aaa:
        return 8.33;
    }
  }
}
