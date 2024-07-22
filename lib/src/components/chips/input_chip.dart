import '../../../zeta_flutter.dart';

/// Zeta Input Chip typically is used to associate some content or action with a user.
///
/// Leading widget should typically be a [ZetaAvatar].
/// {@category Components}
class ZetaInputChip extends ZetaChip {
  /// Creates a [ZetaInputChip].
  const ZetaInputChip({
    required super.label,
    super.key,
    super.leading,
    super.rounded,
    super.trailing,
    super.onTap,
    super.semanticLabel,
  });
}
