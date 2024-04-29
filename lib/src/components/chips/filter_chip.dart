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
    super.onTap,
  }) : super(type: ZetaChipType.filter);

  /// Creates another instance of [ZetaFilterChip].
  ZetaFilterChip copyWith({
    bool? rounded,
  }) {
    return ZetaFilterChip(
      label: label,
      selected: selected,
      rounded: rounded ?? this.rounded,
      onTap: onTap,
    );
  }
}
