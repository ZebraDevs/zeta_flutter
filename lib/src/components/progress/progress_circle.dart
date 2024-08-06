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
/// {@category Components}
class ZetaProgressCircle extends ZetaProgress {
  /// Constructor for [ZetaProgressCircle]
  const ZetaProgressCircle({
    super.key,
    super.progress = 0,
    this.size = ZetaCircleSizes.xl,
    super.rounded,
    this.onCancel,
  });

  ///Size of [ZetaProgressCircle]
  final ZetaCircleSizes size;

  /// Cancel function => cancel upload.
  final VoidCallback? onCancel;

  @override
  State<ZetaProgressCircle> createState() => _ZetaProgressCircleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaCircleSizes>('size', size))
      ..add(DoubleProperty('progress', progress))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onCancel', onCancel));
  }
}

/// Class definition for [_ZetaProgressCircleState]
@Deprecated('Deprecated in 0.14.1')
typedef ZetaProgressCircleState = _ZetaProgressCircleState;

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
    final textVal = '${(widget.progress * 100).round()}%';
    final colors = Zeta.of(context).colors;
    final textWidget = Text(
      textVal,
      style: widget.size != ZetaCircleSizes.s
          ? ZetaTextStyles.labelSmall
          : ZetaTextStyles.labelSmall.copyWith(fontSize: Zeta.of(context).spacing.small),
    );
    final size = _getSize(context);

    return ConstrainedBox(
      constraints: BoxConstraints.tight(size),
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, child) {
          return CustomPaint(
            size: size,
            painter: _CirclePainter(progress: animation.value, rounded: context.rounded, context: context),
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
                                      borderRadius: ZetaRadius.full,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors.surfaceHover,
                                          borderRadius: ZetaRadius.full,
                                        ),
                                        padding: EdgeInsets.all(Zeta.of(context).spacing.small),
                                        child: ZetaIcon(
                                          ZetaIcons.close,
                                          size: widget.size == ZetaCircleSizes.s
                                              ? Zeta.of(context).spacing.medium
                                              : Zeta.of(context).spacing.large,
                                        ),
                                      ),
                                    )
                                  : textWidget,
                            );
                          },
                        )
                      : textWidget,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DoubleProperty('progress', progress))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<Animation<double>>('animation', animation));
  }
}

/// Class definition for [CirclePainter]
@Deprecated('Deprecated in 0.14.1')
typedef CirclePainter = _CirclePainter;

/// Class definition for [_CirclePainter]
class _CirclePainter extends CustomPainter {
  ///Constructor for [_CirclePainter]
  _CirclePainter({this.progress = 0, this.rounded = true, required this.context});

  ///Percentage of progress in decimal value, defaults to 0
  final double progress;

  ///Is circle rounded, defaults to true
  final bool rounded;

  final BuildContext context;

  final _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    if (rounded) _paint.strokeCap = StrokeCap.round;
    final color = Zeta.of(context).colors.primary;
    final strokeWidth = Zeta.of(context).spacing.minimum;
    if (_paint.color != color) _paint.color = color;
    if (_paint.strokeWidth != strokeWidth) _paint.strokeWidth = strokeWidth;

    const double fullCircle = 2 * math.pi;

    canvas.drawArc(
      Rect.fromLTRB(0, 0, size.width, size.height),
      3 * math.pi / 2,
      progress * fullCircle,
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
