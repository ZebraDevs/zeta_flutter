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

/// Tags are used to draw attention to a specific area or information.
/// The arrow shape helps direct the users attention to the desired place.
/// {@category Components}
class ZetaTag extends ZetaStatelessWidget {
  /// Constructs a [ZetaTag].
  const ZetaTag({
    super.key,
    super.rounded,
    this.direction = ZetaTagDirection.left,
    required this.label,
    this.semanticLabel,
  });

  /// Constructs left facing [ZetaTag].
  const ZetaTag.left({super.key, super.rounded, required this.label, this.semanticLabel})
      : direction = ZetaTagDirection.left;

  ///Constructs right facing [ZetaTag].
  const ZetaTag.right({super.key, super.rounded, required this.label, this.semanticLabel})
      : direction = ZetaTagDirection.right;

  ///Determines the direction of the tag
  ///
  /// Defaults to left
  final ZetaTagDirection direction;

  ///tag label
  final String label;

  /// The value passed into wrapping [Semantics] widget.
  ///
  /// {@macro zeta-widget-semantic-label}
  ///
  ///  If null, [label] is used.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    /// Fixed container size
    final Size containerSize = Size(Zeta.of(context).spacing.xl_5, Zeta.of(context).spacing.xl_3);
    return Semantics(
      value: semanticLabel ?? label,
      child: Row(
        children: <Widget>[
          if (direction == ZetaTagDirection.left) _buildCustomPaint(context),
          Container(
            decoration: BoxDecoration(
              color: Zeta.of(context).colors.surfaceHover,
              borderRadius: _getBorderRadius(context),
            ),
            height: containerSize.height,
            constraints: BoxConstraints(minWidth: containerSize.width),
            child: Center(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(Zeta.of(context).spacing.small, 1, Zeta.of(context).spacing.small, 1),
                  child: Text(
                    label,
                    style: ZetaTextStyles.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ),
          if (direction == ZetaTagDirection.right) _buildCustomPaint(context),
        ],
      ),
    );
  }

  BorderRadius? _getBorderRadius(BuildContext context) {
    if (!context.rounded) return null;
    if (direction == ZetaTagDirection.left) {
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
      size: Size(Zeta.of(context).spacing.medium, Zeta.of(context).spacing.xl_3),
      painter: _TagPainter(
        color: Zeta.of(context).colors.surfaceHover,
        direction: direction,
        rounded: context.rounded,
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaTagDirection>('direction', direction))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(StringProperty('semanticLabel', semanticLabel));
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
    final path = _drawPath(size, rounded, direction == ZetaTagDirection.left);

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
