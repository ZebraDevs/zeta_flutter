import 'chip.dart';

/// Zeta Input Chip.
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
  }) : super(type: ZetaChipType.input);
}
