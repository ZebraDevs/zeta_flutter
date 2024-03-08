import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

Map<String, double> namedSpacings = {
  'xxs': ZetaSpacing.xxs,
  'xs': ZetaSpacing.xs,
  's': ZetaSpacing.s,
  'b': ZetaSpacing.b,
  'm': ZetaSpacing.m,
  'l': ZetaSpacing.l,
  'xl': ZetaSpacing.xl,
  'xxl': ZetaSpacing.xxl,
  'xxxl': ZetaSpacing.xxxl,
};
Map<String, double> valueSpacings = {
  'x1': ZetaSpacing.x1,
  'x2': ZetaSpacing.x2,
  'x3': ZetaSpacing.x3,
  'x3.5': ZetaSpacing.x3_5,
  'x4': ZetaSpacing.x4,
  'x5': ZetaSpacing.x5,
  'x6': ZetaSpacing.x6,
  'x7': ZetaSpacing.x7,
  'x8': ZetaSpacing.x8,
  'x9': ZetaSpacing.x9,
  'x10': ZetaSpacing.x10,
  'x11': ZetaSpacing.x11,
  'x12': ZetaSpacing.x12,
  'x13': ZetaSpacing.x13,
  'x14': ZetaSpacing.x14,
  'x16': ZetaSpacing.x16,
  'x20': ZetaSpacing.x20,
  'x24': ZetaSpacing.x24,
};

class SpacingExample extends StatelessWidget {
  const SpacingExample({super.key});
  static const String name = 'Spacing';

  @override
  Widget build(BuildContext context) {
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
                children: valueSpacings.entries.map((obj) => _SpacingDemo(obj)).toList(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: namedSpacings.entries.map((obj) => _SpacingDemo(obj)).toList(),
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

  const _SpacingDemo(this.size);

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return Container(
      color: colors.blue.shade30,
      margin: EdgeInsets.all(ZetaSpacing.m),
      child: CustomPaint(
        painter: _TagPainter(color: colors.pink),
        child: LayoutBuilder(builder: (context, c2) {
          return Container(
            margin: EdgeInsets.all(size.value),
            padding: EdgeInsets.all(ZetaSpacing.s),
            color: colors.surfacePrimary,
            child: Text(
              'ZetaSpacing.' + size.key,
              style: ZetaTextStyles.titleMedium.apply(
                color: Zeta.of(context).colors.textDefault,
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
