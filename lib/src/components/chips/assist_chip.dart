import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Leading widget should typically be an icon.
///
/// These chips use [Draggable] and can be dragged around the screen and placed in new locations using [DragTarget].
/// {@category Components}
class ZetaAssistChip extends ZetaChip {
  /// Creates a [ZetaAssistChip].
  const ZetaAssistChip({
    required super.label,
    super.key,
    super.leading,
    super.rounded,
    super.draggable = false,
    super.data,
    super.onDragCompleted,
    super.onTap,
    super.semanticLabel,
  });
}
