import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

/// Zeta Radio Button
///
/// Radio Button can select one single option from a goup of different options.
class ZetaRadio<T> extends StatefulWidget {
  /// Constructor for [ZetaRadio].
  const ZetaRadio({
    super.key,
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
  final ToggleablePainter _painter = _RadioPainter();
  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Semantics(
          inMutuallyExclusiveGroup: true,
          checked: widget._selected,
          selected: value,
          child: buildToggleable(
            size: const Size(36, 36),
            painter: _painter
              ..position = position
              ..reaction = reaction
              ..reactionFocusFade = reactionFocusFade
              ..reactionHoverFade = reactionHoverFade
              ..inactiveReactionColor = Colors.transparent
              ..reactionColor = Colors.transparent
              ..hoverColor = Colors.transparent
              ..focusColor = zetaColors.blue.shade50
              ..splashRadius = 12
              ..downPosition = downPosition
              ..isFocused = states.contains(MaterialState.focused)
              ..isHovered = states.contains(MaterialState.hovered)
              ..activeColor =
                  states.contains(MaterialState.disabled) ? zetaColors.cool.shade30 : zetaColors.blue.shade60
              ..inactiveColor =
                  states.contains(MaterialState.disabled) ? zetaColors.cool.shade30 : zetaColors.cool.shade70,
            mouseCursor: MaterialStateProperty.all(
              MaterialStateProperty.resolveAs<MouseCursor>(
                MaterialStateMouseCursor.clickable,
                states,
              ),
            ),
          ),
        ),
        if (widget.label != null)
          GestureDetector(
            onTap: () => onChanged?.call(true),
            child: DefaultTextStyle(
              style: ZetaTextStyles.bodyLarge.copyWith(
                color: states.contains(MaterialState.disabled) ? zetaColors.textDisabled : zetaColors.textDefault,
                height: 1.33,
              ),
              child: widget.label!,
            ),
          ),
      ],
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
    _painter.dispose();
    super.dispose();
  }
}

const double _kOuterRadius = 10;
const double _kInnerRadius = 5;

class _RadioPainter extends ToggleablePainter {
  @override
  void paint(Canvas canvas, Size size) {
    paintRadialReaction(canvas: canvas, origin: size.center(Offset.zero));

    final Offset center = (Offset.zero & size).center;

    // Outer circle
    final Paint paint = Paint()
      ..color = Color.lerp(inactiveColor, activeColor, position.value)!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, _kOuterRadius, paint);

    // Inner circle
    if (!position.isDismissed) {
      paint.style = PaintingStyle.fill;
      canvas.drawCircle(center, _kInnerRadius * position.value, paint);
    }
  }
}
