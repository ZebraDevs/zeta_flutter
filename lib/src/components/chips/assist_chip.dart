import 'chip.dart';

/// Zeta Assist Chip.
///
/// Extends [ZetaChip].
class ZetaAssistChip extends ZetaChip {
  /// Creates a [ZetaAssistChip].
  const ZetaAssistChip({
    super.key,
    required super.label,
    super.leading,
    super.rounded,
  }) : super(type: ZetaChipType.assist);
}
