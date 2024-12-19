import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

export './assist_chip.dart';
export './filter_chip.dart';
export './input_chip.dart';
export './status_chip.dart';

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
    this.semanticLabel,
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

  /// The value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  /// If null, [label] is used.
  final String? semanticLabel;

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
      ..add(ObjectFlagProperty<ValueSetter<bool>>.has('onToggle', onToggle))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _ZetaChipState extends State<ZetaChip> {
  bool selected = false;
  bool _draggable = false;

  @override
  void initState() {
    super.initState();
    selected = widget.selected ?? false;
    _draggable = widget.draggable;
    _handleDisabledState();
  }

  @override
  void didUpdateWidget(covariant ZetaChip oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selected != widget.selected) {
      selected = widget.selected ?? false;
    }
    _handleDisabledState();
  }

  void _handleDisabledState() {
    if (widget.onTap == null && widget.onToggle == null) {
      _controller.update(WidgetState.disabled, true);
      setState(() {
        _draggable = false;
      });
    } else {
      _controller.update(WidgetState.disabled, false);
      setState(() {
        _draggable = widget.draggable;
      });
    }
  }

  Widget _renderLeading(Color foregroundColor) {
    if (widget.leading.runtimeType == ZetaIcon || widget.leading.runtimeType == Icon) {
      return IconTheme(
        data: IconThemeData(color: foregroundColor, size: Zeta.of(context).spacing.xl),
        child: widget.leading!,
      );
    } else if (widget.leading.runtimeType == ZetaAvatar) {
      return (widget.leading! as ZetaAvatar).copyWith(size: ZetaAvatarSize.xxxs);
    }
    return widget.leading ?? const Nothing();
  }

  final _controller = WidgetStatesController();

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Semantics(
        selected: selected,
        button: widget.onTap != null,
        label: widget.semanticLabel,
        child: SelectionContainer.disabled(
          child: _draggable
              ? Draggable(
                  feedback: Material(
                    color: Colors.transparent,
                    child: child(colors, isDragging: true),
                  ),
                  childWhenDragging: const Nothing(),
                  data: widget.data,
                  onDragCompleted: widget.onDragCompleted,
                  child: child(colors),
                )
              : child(colors),
        ),
      ),
    );
  }

  Widget? get trailing {
    if (widget.trailing != null) {
      if (widget.trailing.runtimeType == IconButton) {
        final t = widget.trailing! as IconButton;
        return IconButton(
          icon: Icon((t.icon as Icon).icon, color: t.color),
          onPressed: t.onPressed,
          visualDensity: VisualDensity.compact,
        );
      }
    }
    return widget.trailing;
  }

  double get _trailingPadding {
    if (widget.trailing != null) {
      if (widget.trailing.runtimeType == IconButton) {
        return Zeta.of(context).spacing.none;
      } else {
        return Zeta.of(context).spacing.small;
      }
    }
    return Zeta.of(context).spacing.large;
  }

  Color _foregroundColor(ZetaSemanticColors colors, bool disabled) {
    if (!disabled) {
      if (selected) {
        return colors.mainInverse;
      } else {
        return colors.mainDefault;
      }
    } else {
      return colors.mainDisabled;
    }
  }

  ValueListenableBuilder<Set<WidgetState>> child(
    ZetaSemanticColors colors, {
    bool isDragging = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, states, child) {
        final disabled = states.contains(WidgetState.disabled);
        final Color foregroundColor = _foregroundColor(colors, disabled);
        final double iconSize = selected ? Zeta.of(context).spacing.xl_2 : Zeta.of(context).spacing.none;
        final bool rounded = context.rounded;
        return InkWell(
          statesController: !disabled ? _controller : null,
          mouseCursor: !disabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
          borderRadius: rounded ? Zeta.of(context).radius.full : Zeta.of(context).radius.none,
          onTap: () {
            if (!disabled) {
              if (widget.selected != null) {
                setState(() => selected = !selected);
                widget.onToggle?.call(selected);
              } else {
                widget.onTap?.call();
              }
            }
          },
          child: AnimatedContainer(
            duration: Durations.short3,
            height: Zeta.of(context).spacing.xl_5,
            padding: EdgeInsets.fromLTRB(
              widget.leading != null ? Zeta.of(context).spacing.small : Zeta.of(context).spacing.medium,
              0,
              _trailingPadding,
              0,
            ),
            decoration: BoxDecoration(
              color: () {
                if (disabled) {
                  return colors.surfaceDisabled;
                } else {
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
                }
              }(),
              borderRadius: rounded ? Zeta.of(context).radius.full : Zeta.of(context).radius.none,
              border: Border.fromBorderSide(
                BorderSide(
                  color: _controller.value.contains(WidgetState.focused) ? colors.borderPrimary : colors.borderDefault,
                  width: _controller.value.contains(WidgetState.focused)
                      ? ZetaBorders.medium
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
                        ? ZetaIcon(
                            ZetaIcons.check_mark,
                            color: disabled ? colors.mainDisabled : colors.mainInverse,
                          )
                        : const Nothing()),
                  )
                else if (widget.leading != null)
                  _renderLeading(foregroundColor),
                if ((widget.selected != null && selected) || widget.leading != null)
                  SizedBox.square(dimension: Zeta.of(context).spacing.small),
                Text(
                  widget.label,
                  style: ZetaTextStyles.bodySmall.apply(color: foregroundColor),
                ),
                if (widget.trailing != null) ...[
                  SizedBox.square(dimension: Zeta.of(context).spacing.small),
                  IconTheme(
                    data: IconThemeData(color: foregroundColor, size: Zeta.of(context).spacing.xl),
                    child: trailing!,
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
