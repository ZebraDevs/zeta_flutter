import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

///Tag Direction options
enum ZetaTagDirection {
  ///facing left
  left,

  ///facing right
  right
}

///Zeta Tag
class ZetaTag extends StatelessWidget {
  ///Constructs [ZetaTag]
  const ZetaTag({
    this.direction = ZetaTagDirection.left,
    this.borderType = BorderType.sharp,
    required this.label,
    super.key,
  });

  ///Constructor [ZetaTag] left sided
  factory ZetaTag.left({
    BorderType borderType = BorderType.sharp,
    required String label,
  }) =>
      ZetaTag(
        borderType: borderType,
        label: label,
      );

  ///Constructor [ZetaTag] right sided
  factory ZetaTag.right({
    BorderType borderType = BorderType.sharp,
    required String label,
  }) =>
      ZetaTag(
        direction: ZetaTagDirection.right,
        borderType: borderType,
        label: label,
      );

  /// Fixed container size
  static const Size _containerSize = Size(36, 28);

  ///Determines the direction of the tag
  ///
  /// Defaults to left
  final ZetaTagDirection direction;

  ///Border type of the widget
  ///Defaults to sharp
  final BorderType borderType;

  ///tag label
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        if (direction == ZetaTagDirection.right) ...[
          _buildCustomPaint(context),
        ],
        _buildContainer(context),
        if (direction == ZetaTagDirection.left) ...[
          _buildCustomPaint(context),
        ],
      ],
    );
  }

  BorderRadius _getBorderRadius() {
    if (borderType == BorderType.sharp) return BorderRadius.zero;
    if (direction == ZetaTagDirection.right) {
      return const BorderRadius.only(
        topRight: Radius.circular(2),
        bottomRight: Radius.circular(2),
      );
    } else {
      return const BorderRadius.only(
        topLeft: Radius.circular(2),
        bottomLeft: Radius.circular(2),
      );
    }
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getWidgetColor(context),
        borderRadius: _getBorderRadius(),
      ),
      height: _containerSize.height,
      constraints: BoxConstraints(minWidth: _containerSize.width),
      child: Center(
        child: FittedBox(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimensions.x2,
              1,
              Dimensions.x2,
              1,
            ),
            child: Text(
              label,
              style: ZetaText.zetaBodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomPaint(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: const Size(Dimensions.x3, Dimensions.x7),
          painter: _TagPainter(
            color: _getWidgetColor(context),
            direction: direction,
            borderType: borderType,
          ),
        ),
        // Additional widgets if needed
      ],
    );
  }

  Color _getWidgetColor(BuildContext context) =>
      Zeta.of(context).themeMode == ThemeMode.dark ? ZetaColorBase.greyWarm.shade90 : ZetaColorBase.greyCool.shade30;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaTagDirection>('direction', direction))
      ..add(EnumProperty<BorderType>('borderType', borderType))
      ..add(StringProperty('label', label));
  }
}

class _TagPainter extends CustomPainter {
  const _TagPainter({
    required this.color,
    required this.direction,
    required this.borderType,
  });

  final Color color;
  final ZetaTagDirection direction;
  final BorderType borderType;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final path = _buildPath(size);
    if (borderType != BorderType.sharp) _drawDot(canvas, size);
    canvas.drawPath(path, paint);
  }

  Path _buildPath(Size size) {
    return direction == ZetaTagDirection.left ? _leftPath(size) : _rightPath(size);
  }

  void _drawDot(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const double dotSize = 1.7;

    Offset dotPosition;
    if (direction == ZetaTagDirection.right) {
      dotPosition = Offset(2, size.height / 2);
    } else {
      dotPosition = Offset(size.width - 2, size.height / 2);
    }

    canvas.drawCircle(dotPosition, dotSize, paint);
  }

  Path _leftPath(Size size) {
    return Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(0, 0)
      ..close();
  }

  Path _rightPath(Size size) {
    return Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
