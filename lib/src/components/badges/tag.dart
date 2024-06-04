import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';

///Tag Direction options for [ZetaTag].
enum ZetaTagDirection {
  ///Tag facing left.
  left,

  ///Tag facing right.
  right
}

///Zeta Tag
class ZetaTag extends StatelessWidget {
  ///Constructs [ZetaTag].
  const ZetaTag({
    super.key,
    this.direction = ZetaTagDirection.left,
    required this.label,
    this.rounded = true,
  });

  /// Constructs left facing [ZetaTag].
  const ZetaTag.left({super.key, required this.label, this.rounded = true}) : direction = ZetaTagDirection.left;

  ///Constructs right facing [ZetaTag].
  const ZetaTag.right({super.key, required this.label, this.rounded = true}) : direction = ZetaTagDirection.right;

  ///Determines the direction of the tag
  ///
  /// Defaults to left
  final ZetaTagDirection direction;

  /// {@macro zeta-component-rounded}
  final bool rounded;

  ///tag label
  final String label;

  /// Fixed container size
  static const Size _containerSize = Size(ZetaSpacing.xL5, ZetaSpacing.xL3);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (direction == ZetaTagDirection.right) _buildCustomPaint(context),
        Container(
          decoration: BoxDecoration(
            color: Zeta.of(context).colors.surfaceHover,
            borderRadius: _getBorderRadius(),
          ),
          height: _containerSize.height,
          constraints: BoxConstraints(minWidth: _containerSize.width),
          child: Center(
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(ZetaSpacing.small, 1, ZetaSpacing.small, 1),
                child: Text(
                  label,
                  style: ZetaTextStyles.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        if (direction == ZetaTagDirection.left) _buildCustomPaint(context),
      ],
    );
  }

  BorderRadius? _getBorderRadius() {
    if (!rounded) return null;
    if (direction == ZetaTagDirection.right) {
      return const BorderRadius.only(
        topRight: Radius.circular(ZetaSpacingBase.x0_5),
        bottomRight: Radius.circular(ZetaSpacingBase.x0_5),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(ZetaSpacingBase.x0_5),
        bottomLeft: Radius.circular(ZetaSpacingBase.x0_5),
      );
    }
  }

  Widget _buildCustomPaint(BuildContext context) {
    return CustomPaint(
      size: const Size(ZetaSpacing.medium, ZetaSpacing.xL3),
      painter: _TagPainter(
        color: Zeta.of(context).colors.surfaceHover,
        direction: direction,
        rounded: rounded,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaTagDirection>('direction', direction))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded));
  }
}

class _TagPainter extends CustomPainter {
  const _TagPainter({
    required this.color,
    required this.direction,
    required this.rounded,
  });

  final Color color;
  final ZetaTagDirection direction;
  final bool rounded;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = _drawPath(size, rounded, direction == ZetaTagDirection.right);

    canvas.drawPath(path, paint);
  }

  Path _drawPath(Size size, bool rounded, bool isRight) {
    /// Const points of path
    const double a = 0.1;
    const double b = 0.04;
    const double c = 0.48;
    const double d = 0.55;

    // Dynamic points on path
    final double e = isRight ? size.width : 0;
    final double f = isRight ? 1 : -1;

    final path = Path()
      ..moveTo(e + f, 0)
      ..lineTo(e, 0);
    if (rounded) {
      path
        ..lineTo(size.width * (isRight ? a : 1 - a), size.height * (1 - d))
        ..cubicTo(
          size.width * (isRight ? b : 1 - b),
          size.height * c,
          size.width * (isRight ? b : 1 - b),
          size.height * (1 - c),
          size.width * (isRight ? a : 1 - a),
          size.height * d,
        );
    } else {
      path.lineTo(isRight ? 0 : size.width, size.height / 2);
    }

    path
      ..lineTo(e, size.height)
      ..lineTo(e + f, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
