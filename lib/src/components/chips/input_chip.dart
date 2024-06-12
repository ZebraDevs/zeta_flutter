import '../../../zeta_flutter.dart';

/// Zeta Input Chip typically is used to associate some content or action with a user.
///
/// Leading widget should typically be a [ZetaAvatar].
///
/// Extends [ZetaChip].
class ZetaInputChip extends ZetaChip {
  /// Creates a [ZetaInputChip].
  const ZetaInputChip({
    super.key,
    required super.label,
    super.leading,
    super.rounded,
    super.trailing,
    super.onTap,
  });
}
