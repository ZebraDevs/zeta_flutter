import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Radio buttons are used for mutually exclusive choices, not for multiple choices. Only one radio button can be selected at a time. When a user chooses a new item, the previous choice is automatically deselected.
/// {@category Components}
class ZetaRadio<T> extends ZetaStatefulWidget {
  /// Constructor for [ZetaRadio].
  const ZetaRadio({
    super.key,
    super.rounded,
    required this.value,
    this.groupValue,
    this.onChanged,
    this.label,
  });

  /// The value of the option, which can be selected by this Radio Button.
  final T value;

  /// The selected value among all possible options.
  final T? groupValue;

  /// Callback function to call when the Radio Button is tapped.
  ///
  /// {@macro zeta-widget-change-disable}
  final ValueChanged<T?>? onChanged;

  /// The label which appears next to the Radio Button, on the right side.
  final Widget? label;

  bool get _selected => value == groupValue;

  @override
  State<ZetaRadio<T>> createState() => _ZetaRadioState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<T>('value', value))
      ..add(DiagnosticsProperty<T?>('groupValue', groupValue))
      ..add(ObjectFlagProperty<ValueChanged<T?>?>('onChanged', onChanged, ifNull: 'disabled'));
  }
}

class _ZetaRadioState<T> extends State<ZetaRadio<T>> with TickerProviderStateMixin, ToggleableStateMixin {
  ToggleablePainter? _painter;

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    _painter ??= _RadioPainter(context: context);

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: !states.contains(WidgetState.disabled) ? () => onChanged?.call(true) : null,
          borderRadius: Zeta.of(context).radius.full,
          child: Semantics(
            inMutuallyExclusiveGroup: true,
            checked: widget._selected,
            selected: value,
            excludeSemantics: true,
            enabled: !states.contains(WidgetState.disabled),
            child: MouseRegion(
              cursor: states.contains(WidgetState.disabled) ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
              child: SelectionContainer.disabled(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildToggleable(
                      size: Size(Zeta.of(context).spacing.xl_6, Zeta.of(context).spacing.xl_6),
                      painter: _painter!
                        ..position = position
                        ..reaction = reaction
                        ..reactionFocusFade = reactionFocusFade
                        ..reactionHoverFade = reactionHoverFade
                        ..inactiveReactionColor = Colors.transparent
                        ..reactionColor = Colors.transparent
                        ..hoverColor = Colors.transparent
                        ..focusColor = zetaColors.blue.shade50
                        ..splashRadius = Zeta.of(context).spacing.medium
                        ..downPosition = downPosition
                        ..isFocused = states.contains(WidgetState.focused)
                        ..isHovered = states.contains(WidgetState.hovered)
                        ..activeColor = states.contains(WidgetState.hovered)
                            ? zetaColors.cool.shade90
                            : states.contains(WidgetState.disabled)
                                ? zetaColors.cool.shade30
                                : zetaColors.blue.shade60
                        ..inactiveColor = states.contains(WidgetState.hovered)
                            ? zetaColors.cool.shade90
                            : states.contains(WidgetState.disabled)
                                ? zetaColors.cool.shade30
                                : states.contains(WidgetState.focused)
                                    ? zetaColors.blue.shade50
                                    : zetaColors.cool.shade70,
                      mouseCursor: WidgetStateProperty.all(
                        states.contains(WidgetState.disabled) ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
                      ),
                    ),
                    if (widget.label != null)
                      DefaultTextStyle(
                        style: ZetaTextStyles.bodyMedium.copyWith(
                          color:
                              states.contains(WidgetState.disabled) ? zetaColors.textDisabled : zetaColors.textDefault,
                          height: 4 / 3,
                        ),
                        child: widget.label!,
                      ).paddingEnd(Zeta.of(context).spacing.minimum),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleChanged(bool? selected) {
    if (selected == null) {
      widget.onChanged!(null);
      return;
    }
    if (selected) {
      widget.onChanged!(widget.value);
    }
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => false;

  @override
  bool get value => widget._selected;

  @override
  void didUpdateWidget(ZetaRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._selected != oldWidget._selected) {
      animateToValue();
    }
  }

  @override
  void dispose() {
    _painter?.dispose();
    super.dispose();
  }
}

const double _kOuterRadius = 10;
const double _kInnerRadius = 5;

class _RadioPainter extends ToggleablePainter {
  _RadioPainter({required this.context});

  final BuildContext context;

  @override
  void paint(Canvas canvas, Size size) {
    paintRadialReaction(canvas: canvas, origin: size.center(Offset.zero));
    final Offset center = (Offset.zero & size).center;
    final colors = Zeta.of(context).colors;

    // Background mask for focus
    final Paint paint = Paint()
      ..color = colors.surfacePrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = Zeta.of(context).spacing.small + ZetaBorders.borderWidth;
    if (isFocused) canvas.drawCircle(center, _kInnerRadius, paint);

    // Outer circle
    paint
      ..color = isHovered
          ? colors.black
          : position.isDismissed
              ? inactiveColor
              : activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = ZetaBorders.borderWidth;
    canvas.drawCircle(center, _kOuterRadius, paint);

    // Inner circle
    if (!position.isDismissed) {
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(center, _kInnerRadius * position.value, paint);
    }
  }
}
