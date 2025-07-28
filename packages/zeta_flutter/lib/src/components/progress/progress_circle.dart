import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

import 'progress.dart';

/// Sizes for [ZetaProgressCircle]
enum ZetaCircleSizes {
  ///24 X 24
  xs,

  /// 36 X 36
  s,

  /// 40 x 40
  m,

  /// 48 X 48
  l,

  /// 64 X 64
  xl
}

/// Progress indicators express an unspecified wait time or display the length of a process.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-22&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/progress/zetaprogresscircle/progress-circle
class ZetaProgressCircle extends ZetaProgress {
  /// Constructor for [ZetaProgressCircle]
  const ZetaProgressCircle({
    super.key,
    super.progress = 0,
    super.maxValue = 1,
    this.size = ZetaCircleSizes.xl,
    super.rounded,
    this.onCancel,
    this.label,
    this.child,
  });

  ///Size of [ZetaProgressCircle]
  final ZetaCircleSizes size;

  /// Cancel function => cancel upload.
  final VoidCallback? onCancel;

  /// Label for [ZetaProgressCircle], override default percentage label.
  final String? label;

  /// Child widget shown in the center of the circle.
  ///
  /// If provided, it will replace the label text.
  final Widget? child;

  @override
  State<ZetaProgressCircle> createState() => _ZetaProgressCircleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaCircleSizes>('size', size))
      ..add(DoubleProperty('progress', progress))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onCancel', onCancel))
      ..add(DoubleProperty('maxValue', maxValue))
      ..add(StringProperty('label', label));
  }
}

/// Class definition for [_ZetaProgressCircleState]
class _ZetaProgressCircleState extends ZetaProgressState<ZetaProgressCircle> {
  final _controller = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (context.mounted && mounted && !_controller.value.contains(WidgetState.hovered)) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textVal = widget.label ?? '${(widget.progress * 100).round()}%';
    final colors = Zeta.of(context).colors;
    final centerWidget = widget.child ?? Text(textVal, style: _getTextSize());
    final size = _getSize(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tight(size),
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, child) {
          return CustomPaint(
            size: size,
            painter: _CirclePainter(
              progress: animation.value,
              rounded: context.rounded,
              context: context,
              maxValue: widget.maxValue,
            ),
            child: Center(
              child: widget.size == ZetaCircleSizes.xs
                  ? null
                  : widget.onCancel != null
                      ? ListenableBuilder(
                          listenable: _controller,
                          builder: (context, _) {
                            return MouseRegion(
                              onEnter: (hover) {
                                if (mounted) {
                                  _controller.update(WidgetState.hovered, true);
                                }
                              },
                              onExit: (hover) {
                                _controller.update(WidgetState.hovered, false);
                              },
                              child: _controller.value.contains(WidgetState.hovered)
                                  ? InkWell(
                                      enableFeedback: false,
                                      onTap: widget.onCancel,
                                      borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors.surfaceHover,
                                          borderRadius: BorderRadius.all(Zeta.of(context).radius.full),
                                        ),
                                        padding: EdgeInsets.all(Zeta.of(context).spacing.small),
                                        child: Icon(
                                          context.rounded ? ZetaIcons.close_round : ZetaIcons.close_sharp,
                                          size: widget.size == ZetaCircleSizes.s
                                              ? Zeta.of(context).spacing.medium
                                              : Zeta.of(context).spacing.large,
                                        ),
                                      ),
                                    )
                                  : centerWidget,
                            );
                          },
                        )
                      : centerWidget,
            ),
          );
        },
      ),
    );
  }

  Size _getSize(BuildContext context) {
    switch (widget.size) {
      case ZetaCircleSizes.xs:
        return Size(Zeta.of(context).spacing.xl_2, Zeta.of(context).spacing.xl_2);
      case ZetaCircleSizes.s:
        return Size(Zeta.of(context).spacing.xl_5, Zeta.of(context).spacing.xl_5);
      case ZetaCircleSizes.m:
        return Size(Zeta.of(context).spacing.xl_6, Zeta.of(context).spacing.xl_6);
      case ZetaCircleSizes.l:
        return Size(Zeta.of(context).spacing.xl_8, Zeta.of(context).spacing.xl_8);
      case ZetaCircleSizes.xl:
        return Size(Zeta.of(context).spacing.xl_9, Zeta.of(context).spacing.xl_9);
    }
  }

  TextStyle _getTextSize() {
    switch (widget.size) {
      case ZetaCircleSizes.xs:
      case ZetaCircleSizes.s:
        return Zeta.of(context).textStyles.labelSmall;
      case ZetaCircleSizes.m:
        return Zeta.of(context).textStyles.labelMedium;
      case ZetaCircleSizes.l:
      case ZetaCircleSizes.xl:
        return Zeta.of(context).textStyles.labelLarge;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('progress', progress))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<Animation<double>>('animation', animation));
  }
}

/// Class definition for [_CirclePainter]
class _CirclePainter extends CustomPainter {
  ///Constructor for [_CirclePainter]
  _CirclePainter({
    this.progress = 0,
    this.rounded = true,
    required this.context,
    this.maxValue = 1,
  });

  ///Percentage of progress in decimal value, defaults to 0
  final double progress;

  ///Is circle rounded, defaults to true
  final bool rounded;

  final BuildContext context;

  /// Maximum value for progress, defaults to 1
  final double maxValue;

  final _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    if (rounded) _paint.strokeCap = StrokeCap.round;
    _paint
      ..strokeWidth = Zeta.of(context).spacing.minimum
      ..style = PaintingStyle.stroke
      ..color = Zeta.of(context).colors.mainPrimary;

    const double fullCircle = 2 * math.pi;

    final double strokeWidth = _paint.strokeWidth;
    final Rect adjustedRect = Rect.fromLTRB(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth / 2,
      size.height - strokeWidth / 2,
    );

    canvas.drawArc(
      adjustedRect,
      3 * math.pi / 2,
      progress / maxValue * fullCircle,
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
