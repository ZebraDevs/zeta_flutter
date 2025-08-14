import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Chips that are clickable, selectable and draggable.
///
/// Leading widget should typically be an icon.
///
/// These chips use [Draggable] and can be dragged around the screen and placed in new locations using [DragTarget].
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-14215
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/chips/zetaassistchip/assist-chip
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
