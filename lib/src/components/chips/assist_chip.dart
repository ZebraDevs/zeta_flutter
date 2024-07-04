import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Assist Chip.
///
/// Leading widget should typically be an icon.
///
/// These chips use [Draggable] and can be dragged around the screen and placed in new locations using [DragTarget].
///
/// Extends [ZetaChip].
class ZetaAssistChip extends ZetaChip {
  /// Creates a [ZetaAssistChip].
  const ZetaAssistChip({
    super.key,
    required super.label,
    super.leading,
    super.rounded,
    super.draggable = false,
    super.data,
    super.onDragCompleted,
    super.onTap,
    super.semanticLabel,
  });
}
