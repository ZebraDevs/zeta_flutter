import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Filter chips have 2 togglable states, representing selected and not selected.
///
/// The chips are commonly used within a [ZetaFilterSelection].
///
/// These chips use [Draggable] and can be dragged around the screen and placed in new locations using [DragTarget].
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-14112
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/chips/filter-chip
class ZetaFilterChip extends ZetaChip {
  /// Creates a [ZetaFilterChip].
  const ZetaFilterChip({
    required super.label,
    super.key,
    super.rounded,
    super.selected,
    super.draggable = false,
    super.data,
    super.onDragCompleted,
    super.semanticLabel,
    ValueSetter<bool>? onTap,
  }) : super(onToggle: onTap);

  /// Creates another instance of [ZetaFilterChip].
  ZetaFilterChip copyWith({
    bool? rounded,
  }) {
    return ZetaFilterChip(
      label: label,
      selected: selected,
      rounded: rounded ?? this.rounded,
      draggable: draggable,
      data: data,
      onDragCompleted: onDragCompleted,
      onTap: onToggle,
    );
  }
}
