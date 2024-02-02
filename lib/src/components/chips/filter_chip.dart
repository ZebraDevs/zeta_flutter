import 'chip.dart';

/// Zeta Filter Chip.
///
/// Extends [ZetaChip].
class ZetaFilterChip extends ZetaChip {
  /// Creates a [ZetaInputChip].
  const ZetaFilterChip({
    super.key,
    required super.label,
    super.rounded,
    super.selected,
  }) : super(type: ZetaChipType.filter);
}
