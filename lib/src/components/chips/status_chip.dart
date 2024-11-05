import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// The [ZetaStatusChip] is a chip that displays a status/label.
/// It can be dragged around the screen and placed in new locations using [DragTarget].
///
/// {@category Components}
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-2159
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/chips/input-chip
class ZetaStatusChip extends ZetaStatelessWidget {
  /// Creates a [ZetaStatusChip].
  const ZetaStatusChip({
    super.key,
    required this.label,
    super.rounded,
    this.draggable = false,
    this.data,
    this.onDragCompleted,
    this.semanticLabel,
  });

  /// The label on the [ZetaStatusChip]
  final String label;

  /// Whether the chip can be dragged.
  final bool draggable;

  /// Draggable data.
  final dynamic data;

  /// Called when the draggable is dropped and accepted by a [DragTarget].
  ///
  /// See also:
  /// * [DragTarget]
  /// * [Draggable]
  final VoidCallback? onDragCompleted;

  /// A semantic label for the chip.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return ZetaRoundedScope(
      rounded: context.rounded,
      child: MouseRegion(
        cursor: draggable ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Semantics(
          label: semanticLabel,
          child: SelectionContainer.disabled(
            child: draggable
                ? Draggable(
                    feedback: Material(
                      color: Colors.transparent,
                      child: _Child(context: context, label: label),
                    ),
                    childWhenDragging: const Nothing(),
                    data: data,
                    onDragCompleted: onDragCompleted,
                    child: _Child(context: context, label: label),
                  )
                : _Child(context: context, label: label),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('draggable', draggable))
      ..add(DiagnosticsProperty('data', data))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDragCompleted', onDragCompleted))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

/// The child widget of the [ZetaStatusChip].
class _Child extends StatelessWidget {
  const _Child({required this.context, required this.label});

  final BuildContext context;

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Zeta.of(context).colors.surfaceWarm,
        borderRadius: BorderRadius.all(
          Radius.circular(
            Zeta.of(context).spacing.small,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Zeta.of(context).spacing.small,
        vertical: Zeta.of(context).spacing.minimum,
      ),
      child: Text(label, style: ZetaTextStyles.bodyXSmall),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BuildContext>('context', context))
      ..add(StringProperty('label', label));
  }
}
