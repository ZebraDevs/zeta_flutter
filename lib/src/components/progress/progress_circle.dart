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

///Class definition for [ZetaProgressCircle]
class ZetaProgressCircle extends ZetaProgress {
  /// Constructor for [ZetaProgressCircle]
  const ZetaProgressCircle({
    super.key,
    super.progress = 0,
    this.size = ZetaCircleSizes.xl,
    this.rounded = true,
  });

  ///Size of [ZetaProgressCircle]
  final ZetaCircleSizes size;

 ///{@macro zeta-component-rounded}
  final bool rounded;

  @override
  State<ZetaProgressCircle> createState() => ZetaProgressCircleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaCircleSizes>('size', size))
      ..add(DoubleProperty('progress', progress))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

///Class definition for [ZetaProgressCircleState]
class ZetaProgressCircleState extends ZetaProgressState<ZetaProgressCircle> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(_getSize()),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return CustomPaint(
            size: _getSize(),
            painter: CirclePainter(
              progress: animation.value,
              rounded: widget.rounded,
              colors: Zeta.of(context).colors
            ),
          );
        },
      ),
    );
  }

  Size _getSize() {
    switch (widget.size) {
      case ZetaCircleSizes.xs:
        return const Size(ZetaSpacing.x6, ZetaSpacing.x6);
      case ZetaCircleSizes.s:
        return const Size(ZetaSpacing.x9, ZetaSpacing.x9);
      case ZetaCircleSizes.m:
        return const Size(ZetaSpacing.x10, ZetaSpacing.x10);
      case ZetaCircleSizes.l:
        return const Size(ZetaSpacing.x12, ZetaSpacing.x12);
      case ZetaCircleSizes.xl:
        return const Size(ZetaSpacing.x16, ZetaSpacing.x16);
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

///Class definition for [CirclePainter]
class CirclePainter extends CustomPainter {
  ///Constructor for [CirclePainter]
  CirclePainter({this.progress = 0, this.rounded = true,required this.colors});

  ///Percentage of progress in decimal value, defaults to 0
  final double progress;

  ///Is circle rounded, defaults to true
  final bool rounded;

  /// ZetaColors
  final ZetaColors colors;

  final _paint = Paint()
    ..strokeWidth = 4
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    if (rounded) _paint.strokeCap = StrokeCap.round;
    _paint.color = colors.primary;


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
