import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Leading widget should typically be an icon.
///
/// These chips use [Draggable] and can be dragged around the screen and placed in new locations using [DragTarget].
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-14215
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/chips/assist-chip
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
