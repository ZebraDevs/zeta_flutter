import '../../zeta_flutter.dart';

/// Zeta Input Chip typically is used to associate some content or action with a user.
///
/// Leading widget should typically be a [ZetaAvatar].
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-2159
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/chips/input-chip
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
