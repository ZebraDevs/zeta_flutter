import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SpacingExample extends StatelessWidget {
  const SpacingExample({super.key});
  static const String name = 'Spacing';

  @override
  Widget build(BuildContext context) {
    Map<String, double> semanticSpacings = {
      'none': Zeta.of(context).spacing.none,
      'minimum': Zeta.of(context).spacing.minimum,
      'small': Zeta.of(context).spacing.small,
      'medium': Zeta.of(context).spacing.medium,
      'large': Zeta.of(context).spacing.large,
      'xl': Zeta.of(context).spacing.xl,
      'xl_2': Zeta.of(context).spacing.xl_2,
      'xl_3': Zeta.of(context).spacing.xl_3,
      'xl_4': Zeta.of(context).spacing.xl_4,
      'xl_5': Zeta.of(context).spacing.xl_5,
      'xl_6': Zeta.of(context).spacing.xl_6,
      'xl_7': Zeta.of(context).spacing.xl_7,
      'xl_8': Zeta.of(context).spacing.xl_8,
      'xl_9': Zeta.of(context).spacing.xl_9,
      'xl_10': Zeta.of(context).spacing.xl_10,
      'xl_11': Zeta.of(context).spacing.xl_11,
    };
    Map<String, double> baseSpacings = {
      'primitives.x1': Zeta.of(context).spacing.primitives.x1,
      'primitives.x2': Zeta.of(context).spacing.primitives.x2,
      'primitives.x3': Zeta.of(context).spacing.primitives.x3,
      'primitives.x4': Zeta.of(context).spacing.primitives.x4,
      'primitives.x5': Zeta.of(context).spacing.primitives.x5,
      'primitives.x6': Zeta.of(context).spacing.primitives.x6,
      'primitives.x7': Zeta.of(context).spacing.primitives.x7,
      'primitives.x8': Zeta.of(context).spacing.primitives.x8,
      'primitives.x9': Zeta.of(context).spacing.primitives.x9,
      'primitives.x10': Zeta.of(context).spacing.primitives.x10,
      'primitives.x11': Zeta.of(context).spacing.primitives.x11,
      'primitives.x12': Zeta.of(context).spacing.primitives.x12,
      'primitives.x13': Zeta.of(context).spacing.primitives.x13,
      'primitives.x14': Zeta.of(context).spacing.primitives.x14,
      'primitives.x15': Zeta.of(context).spacing.primitives.x15,
    };

    return ExampleScaffold(
      name: name,
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: semanticSpacings.entries.map((obj) => _SpacingDemo(obj)).toList(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: baseSpacings.entries.map((obj) => _SpacingDemo(obj, true)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SpacingDemo extends StatelessWidget {
  final MapEntry<String, double> size;
  final bool primitive;

  const _SpacingDemo(this.size, [this.primitive = false]);

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return Container(
      color: colors.primitives.blue.shade30,
      margin: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
      child: CustomPaint(
        painter: _TagPainter(color: colors.primitives.pink),
        child: LayoutBuilder(builder: (context, c2) {
          return Container(
            margin: EdgeInsets.all(size.value),
            padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
            color: colors.surfacePrimary,
            child: Text(
              'Zeta.of(context).spacing.' + size.key,
              style: ZetaTextStyles.titleMedium.apply(
                color: Zeta.of(context).colors.mainDefault,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TagPainter extends CustomPainter {
  const _TagPainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke;

    final horizontal = Path()
      ..moveTo(0, (size.height / 2))
      ..lineTo(size.width, (size.height / 2))
      ..close();

    final vertical = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();

    canvas.drawPath(dashPath(horizontal, dashArray: CircularIntervalList([2, 3])), paint);
    canvas.drawPath(
      dashPath(vertical, dashArray: CircularIntervalList([2, 3]), dashOffset: DashOffset.absolute(size.height)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
