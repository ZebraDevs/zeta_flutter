/// Tokenised durations used for animations
class ZetaAnimationLength {
  /// 100ms
  static const veryFast = Duration(milliseconds: 100);

  /// 200ms
  static const fast = Duration(milliseconds: 200);

  /// 300ms
  static const normal = Duration(milliseconds: 300);

  /// 400ms
  static const slow = Duration(milliseconds: 400);

  /// 500ms
  static const verySlow = Duration(milliseconds: 500);
}

/// Temporary class to hold border values.
///
///
// TODO(Tokens): Remove this class and design / develop  Zeta.of(context).border instead.
abstract final class ZetaBorders {
  /// Small border width
  static double get small => 0.5;

  /// Medium border width
  static double get medium => 2;
}
