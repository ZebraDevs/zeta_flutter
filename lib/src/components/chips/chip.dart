import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

export './assist_chip.dart';
export './filter_chip.dart';
export './input_chip.dart';

/// Zeta Chip component.
///
/// This covers the broad functionality of [ZetaAssistChip], [ZetaFilterChip] and [ZetaInputChip].
///
/// If [selected] is not null, the chip will have the toggle behavior of [ZetaFilterChip].
class ZetaChip extends ZetaStatefulWidget {
  /// Constructs a [ZetaChip].
  const ZetaChip({
    super.key,
    super.rounded,
    required this.label,
    this.leading,
    this.trailing,
    this.selected,
    this.onTap,
    this.draggable = false,
    this.data,
    this.onDragCompleted,
    this.onToggle,
  });

  /// The label on the [ZetaChip]
  final String label;

  /// Leading component. Typically an [Icon] or [ZetaAvatar].
  final Widget? leading;

  /// Trailing component. Typically an [Icon].
  final Widget? trailing;

  /// Whether the [ZetaFilterChip] is selected.
  ///
  /// If null, chip can not be selected.
  final bool? selected;

  /// Callback when chip is tapped.
  final VoidCallback? onTap;

  /// Callback for when Filter Chip is toggled.
  final ValueSetter<bool>? onToggle;

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

  @override
  State<ZetaChip> createState() => _ZetaChipState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool?>('selected', selected))
      ..add(DiagnosticsProperty<bool>('draggable', draggable))
      ..add(DiagnosticsProperty('data', data))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onDragCompleted', onDragCompleted))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap))
      ..add(ObjectFlagProperty<ValueSetter<bool>>.has('onToggle', onToggle));
  }
}

class _ZetaChipState extends State<ZetaChip> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? false;
  }

  Widget _renderLeading(Color foregroundColor) {
    if (widget.leading.runtimeType == Icon) {
      return IconTheme(data: IconThemeData(color: foregroundColor, size: ZetaSpacing.xl_1), child: widget.leading!);
    } else if (widget.leading.runtimeType == ZetaAvatar) {
      return (widget.leading! as ZetaAvatar).copyWith(size: ZetaAvatarSize.xxxs);
    }
    return widget.leading ?? const SizedBox();
  }

  final _controller = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    final foregroundColor = selected ? colors.textInverse : colors.textDefault;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: SelectionContainer.disabled(
        child: widget.draggable
            ? Draggable(
                feedback: Material(
                  color: Colors.transparent,
                  child: child(colors, foregroundColor, isDragging: true),
                ),
                childWhenDragging: const SizedBox(),
                data: widget.data,
                onDragCompleted: widget.onDragCompleted,
                child: child(colors, foregroundColor),
              )
            : child(colors, foregroundColor),
      ),
    );
  }

  ValueListenableBuilder<Set<WidgetState>> child(ZetaColors colors, Color foregroundColor, {bool isDragging = false}) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, states, child) {
        final double iconSize = selected ? ZetaSpacing.xl_2 : ZetaSpacing.none;
        final bool rounded = context.rounded;
        return InkWell(
          statesController: _controller,
          borderRadius: rounded ? ZetaRadius.full : ZetaRadius.none,
          onTap: () {
            if (widget.selected != null) {
              setState(() => selected = !selected);
              widget.onToggle?.call(selected);
            } else {
              widget.onTap?.call();
            }
          },
          child: AnimatedContainer(
            duration: Durations.short3,
            height: ZetaSpacing.xl_5,
            padding: EdgeInsets.fromLTRB(
              widget.leading != null ? ZetaSpacingBase.x2_5 : ZetaSpacing.medium,
              0,
              widget.trailing != null ? ZetaSpacingBase.x2_5 : ZetaSpacing.medium,
              0,
            ),
            decoration: BoxDecoration(
              color: () {
                if (states.contains(WidgetState.disabled)) {
                  return colors.surfaceDisabled;
                }
                if (selected) {
                  if (states.contains(WidgetState.hovered)) {
                    return colors.borderHover;
                  }
                  return colors.surfaceDefaultInverse;
                }
                if (states.contains(WidgetState.pressed) || isDragging) {
                  return colors.surfaceSelected;
                }
                if (states.contains(WidgetState.hovered)) {
                  return colors.surfaceHover;
                }
                return colors.surfacePrimary;
              }(),
              borderRadius: rounded ? ZetaRadius.full : ZetaRadius.none,
              border: Border.fromBorderSide(
                BorderSide(
                  color: _controller.value.contains(WidgetState.focused) ? colors.blue.shade50 : colors.borderDefault,
                  width: _controller.value.contains(WidgetState.focused)
                      ? ZetaSpacingBase.x0_5
                      : !selected
                          ? 1
                          : 0,
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.selected != null)
                  AnimatedContainer(
                    duration: Durations.short1,
                    width: iconSize,
                    child: (selected
                        ? Icon(
                            rounded ? ZetaIcons.check_mark_round : ZetaIcons.check_mark_sharp,
                            color: widget.selected! ? colors.iconInverse : Colors.transparent,
                          )
                        : const SizedBox()),
                  )
                else if (widget.leading != null)
                  _renderLeading(foregroundColor),
                if ((widget.selected != null && selected) || widget.leading != null)
                  const SizedBox.square(dimension: ZetaSpacing.small),
                Text(
                  widget.label,
                  style: ZetaTextStyles.bodySmall.apply(color: foregroundColor),
                ),
                if (widget.trailing != null) ...[
                  const SizedBox.square(dimension: ZetaSpacing.small),
                  IconTheme(
                    data: IconThemeData(color: foregroundColor, size: ZetaSpacing.xl_1),
                    child: widget.trailing!,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', widget.rounded))
      ..add(StringProperty('label', widget.label))
      ..add(DiagnosticsProperty<bool?>('selected', widget.selected));
  }
}
