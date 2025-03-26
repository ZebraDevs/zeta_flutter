import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../zeta_flutter.dart';

const _horizontalArrowSize = Size(4, 8);
const _verticalArrowSize = Size(8, 4);

/// The direction of [ZetaTooltip]'s arrow
enum ZetaTooltipArrowDirection {
  /// [up]
  up,

  /// [down]
  down,

  /// [left]
  left,

  /// [right]
  right,
}

/// Tooltips display informative text when users hover over, focus on, or tap an element.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-16&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/tooltip/zetatooltip/tooltip
class ZetaTooltip extends ZetaStatelessWidget {
  /// Constructor for [ZetaTooltip].
  const ZetaTooltip({
    super.key,
    super.rounded,
    required this.child,
    this.padding,
    this.color,
    this.textStyle,
    this.arrowDirection = ZetaTooltipArrowDirection.down,
    this.maxWidth,
  });

  /// The content of the tooltip.
  final Widget child;

  /// The padding inside the [ZetaTooltip].
  /// Default is:
  /// ```dart
  ///  EdgeInsets.symmetric(
  ///   horizontal: Zeta.of(context).spacing.small,
  ///   vertical: Zeta.of(context).spacing.minimum,
  /// )
  /// ```
  final EdgeInsets? padding;

  /// The color of the tooltip.
  /// Default is `zeta.colors.mainDefault`.
  final Color? color;

  /// The text style of the tooltip.
  /// Default is:
  /// ```dart
  /// ZetaTextStyles.bodyXSmall.copyWith(
  ///   color: zeta.colors.mainInverse,
  ///   fontWeight: FontWeight.w500,
  /// ),
  /// ```
  final TextStyle? textStyle;

  /// The direction of the tooltip's arrow.
  /// Default is `ZetaTooltipArrowDirection.down`.
  final ZetaTooltipArrowDirection arrowDirection;

  /// The maximum width of the tooltip.
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final color = this.color ?? zeta.colors.mainDefault;
    final horizontalArrowWidth =
        [ZetaTooltipArrowDirection.left, ZetaTooltipArrowDirection.right].contains(arrowDirection)
            ? _horizontalArrowSize.width
            : Zeta.of(context).spacing.none;

    return ZetaRoundedScope(
      rounded: context.rounded,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return MergeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (arrowDirection == ZetaTooltipArrowDirection.up)
                      Center(
                        child: CustomPaint(
                          painter: _FilledArrow(
                            color: color,
                            direction: arrowDirection,
                          ),
                          size: _verticalArrowSize,
                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (arrowDirection == ZetaTooltipArrowDirection.left)
                          Center(
                            child: CustomPaint(
                              painter: _FilledArrow(
                                color: color,
                                direction: arrowDirection,
                              ),
                              size: _horizontalArrowSize,
                            ),
                          ),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: maxWidth ?? (constraints.maxWidth - horizontalArrowWidth),
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: context.rounded ? BorderRadius.all(Zeta.of(context).radius.minimal) : null,
                            ),
                            child: Padding(
                              padding: padding ??
                                  EdgeInsets.symmetric(
                                    horizontal: Zeta.of(context).spacing.small,
                                    vertical: Zeta.of(context).spacing.minimum,
                                  ),
                              child: DefaultTextStyle(
                                style: textStyle ??
                                    ZetaTextStyles.bodyXSmall.copyWith(
                                      color: zeta.colors.mainInverse,
                                      fontWeight: FontWeight.w500,
                                    ),
                                child: child,
                              ),
                            ),
                          ),
                        ),
                        if (arrowDirection == ZetaTooltipArrowDirection.right)
                          Center(
                            child: CustomPaint(
                              painter: _FilledArrow(
                                color: color,
                                direction: arrowDirection,
                              ),
                              size: _horizontalArrowSize,
                            ),
                          ),
                      ],
                    ),
                    if (arrowDirection == ZetaTooltipArrowDirection.down)
                      Center(
                        child: CustomPaint(
                          painter: _FilledArrow(
                            color: color,
                            direction: arrowDirection,
                          ),
                          size: _verticalArrowSize,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<EdgeInsets?>('padding', padding))
      ..add(ColorProperty('color', color))
      ..add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle))
      ..add(EnumProperty<ZetaTooltipArrowDirection>('arrowDirection', arrowDirection))
      ..add(DoubleProperty('maxWidth', maxWidth));
  }
}

class _FilledArrow extends CustomPainter {
  _FilledArrow({
    required this.direction,
    this.color,
  });

  final Color? color;
  final ZetaTooltipArrowDirection direction;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color ?? Colors.transparent;
    final path = switch (direction) {
      ZetaTooltipArrowDirection.up => Path()
        ..moveTo(size.width / 2, 0)
        ..lineTo(0, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width / 2, 0),
      ZetaTooltipArrowDirection.left => Path()
        ..moveTo(size.width, 0)
        ..lineTo(0, size.height / 2)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, 0),
      ZetaTooltipArrowDirection.down => Path()
        ..lineTo(size.width, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(0, 0),
      ZetaTooltipArrowDirection.right => Path()
        ..lineTo(size.width, size.height / 2)
        ..lineTo(0, size.height)
        ..lineTo(0, 0),
    };
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
