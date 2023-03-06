import 'package:flutter/widgets.dart';

const double _space = 4;

/// 0dp space
const double x0 = _space * 0;

/// 4dp space
const double x1 = _space;

/// 4dp space
const double xxs = _space;

/// 8dp space
const double x2 = _space * 2;

/// 8dp space
const double xs = _space * 2;

/// 12dp space
const double x3 = _space * 3;

/// 12dp space
const double s = _space * 3;

/// 16dp space
const double x4 = _space * 4;

/// 16dp space
const double b = _space * 4;

/// 20dp space
const double x5 = _space * 5;

/// 24dp space
const double x6 = _space * 6;

/// 24dp space
const double m = _space * 6;

/// 28dp space
const double x7 = _space * 7;

/// 32dp space
const double x8 = _space * 8;

/// 32dp space
const double l = _space * 8;

/// 36dp space
const double x9 = _space * 9;

/// 40dp space
const double x10 = _space * 10;

/// 44dp space
const double x11 = _space * 11;

/// 48dp space
const double x12 = _space * 12;

/// 64dp space
const double x16 = _space * 16;

/// 64dp space
const double xl = _space * 16;

/// 80dp space
const double x20 = _space * 20;

/// 80dp space
const double xxl = _space * 20;

/// 96dp space
const double x24 = _space * 24;

/// 96dp space
const double xxxl = _space * 24;

/// Spacing types for [ZetaSpacing].
enum SpacingType {
  /// {@template zeta-spacing-square}
  /// Identical spacing on all four sides.
  ///
  /// It’s use is widespread, across many components at varying sizes.
  /// {@endtemplate}
  square,

  /// {@template zeta-spacing-squish}
  /// Identical padding on top and bottom, nothing on sides.
  ///
  /// While less common than its squared counterpart, a squish occurred frequently in elements (like a button) and cell-like containers like a data table or list item.
  /// {@endtemplate}
  squish,

  /// {@template zeta-spacing-stack}
  /// Padding on bottom only.
  ///
  /// With all due respect to horizontally scrolled UI, the overwhelming majority scroll vertically. And that means one thing: we stack things. We stack message on heading on data table. We stack modules in rails. We stack copy, pills & toolbars, all in a card, each in a grid. Heck, infinite scroll means infinite stack! We stack, stack, stack.
  /// {@endtemplate}
  stack,

  /// {@template zeta-spacing-inline-only}
  /// Padding on start and end only.
  /// {@endtemplate}
  /// {@template zeta-spacing-inline}
  /// We arrange objects inline, wrapping as they flow like text from the left or right. Such objects — pills, tags, breadcrumbs, and more — may stand alone or stack and mingle with other objects.
  /// {@endtemplate}
  inline,

  /// {@template zeta-spacing-inline-start}
  /// Padding on start only.
  ///
  /// {@macro zeta-spacing-inline}
  ///
  /// {@endtemplate}
  inlineStart,

  /// {@template zeta-spacing-inline-end}
  /// Padding on end only.
  /// {@endtemplate}
  inlineEnd,
}

/// Zeta Spacing widget
class ZetaSpacing extends StatelessWidget {
  /// Child to be wrapped with spacing insets.
  final Widget child;

  /// [SpacingType] insets applied to [child].
  ///
  /// Defaults to [SpacingType.square].
  final SpacingType? type;

  /// Size of insets to be applied around [child].
  ///
  /// Should be an even number, and be no larger than [x24].
  ///
  /// Defaults to [x0].
  final double size;

  /// Constructs [ZetaSpacing].
  const ZetaSpacing({
    required this.child,
    this.type = SpacingType.square,
    this.size = x0,
    super.key,
  }) : assert(
          size % 2 == 0 && size >= 0 && size <= x24,
          'Size should be a whole, even number, and be no larger than [x24]',
        );

  /// Constructs a [ZetaSpacing] widget with [SpacingType.square] insets.
  ///
  /// {@macro zeta-spacing-square}
  const ZetaSpacing.square({required this.child, this.size = x0, super.key}) : type = SpacingType.square;

  /// Constructs a [ZetaSpacing] widget with [SpacingType.squish] insets.
  ///
  /// {@macro zeta-spacing-squish}
  const ZetaSpacing.squish({required this.child, this.size = x0, super.key}) : type = SpacingType.squish;

  /// Constructs a [ZetaSpacing] widget with [SpacingType.stack] insets.
  ///
  /// {@macro zeta-spacing-stack}
  const ZetaSpacing.stack({required this.child, this.size = x0, super.key}) : type = SpacingType.stack;

  /// Constructs a [ZetaSpacing] widget with [SpacingType.inline] insets.
  ///
  /// {@macro zeta-spacing-inline-only}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inline({required this.child, this.size = x0, super.key}) : type = SpacingType.inline;

  /// Constructs a [ZetaSpacing] widget with [SpacingType.inlineStart] insets.
  ///
  /// {@macro zeta-spacing-inline-start}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inlineStart({required this.child, this.size = x0, super.key}) : type = SpacingType.inlineStart;

  /// Constructs a [ZetaSpacing] widget with [SpacingType.inlineEnd] insets.
  ///
  /// {@macro zeta-spacing-inline-end}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inlineEnd({required this.child, this.size = x0, super.key}) : type = SpacingType.inlineEnd;

  @override
  Widget build(BuildContext context) {
    switch (type ?? SpacingType.square) {
      case SpacingType.square:
        return child.square(size);
      case SpacingType.squish:
        return child.squish(size);
      case SpacingType.stack:
        return child.stack(size);
      case SpacingType.inline:
        return child.inline(size);
      case SpacingType.inlineStart:
        return child.inlineStart(size);
      case SpacingType.inlineEnd:
        return child.inlineEnd(size);
    }
  }
}

/// Extension to get Spacing type as [EdgeInsets] from a double.
extension SpacingSize on double {
  /// {@macro zeta-spacing-square}
  EdgeInsets get square => EdgeInsets.all(this);

  /// {@macro zeta-spacing-squish}
  EdgeInsets get squish => EdgeInsets.symmetric(vertical: this);

  /// {@macro zeta-spacing-stack}
  EdgeInsets get stack => EdgeInsets.only(bottom: this);

  /// {@macro zeta-spacing-inline}
  EdgeInsetsDirectional get inline => EdgeInsetsDirectional.only(start: this, end: this);

  /// {@macro zeta-spacing-inline-start}
  EdgeInsetsDirectional get inlineStart => EdgeInsetsDirectional.only(start: this);

  /// {@macro zeta-spacing-inline-end}
  EdgeInsetsDirectional get inlineEnd => EdgeInsetsDirectional.only(end: this);
}

/// Extension to add spacing to any [Widget].
extension SpacingWidget on Widget {
  /// {@macro zeta-spacing-square}
  Widget square(double space) => Padding(padding: space.square, child: this);

  /// {@macro zeta-spacing-squish}
  Widget squish(double space) => Padding(padding: space.squish, child: this);

  /// {@macro zeta-spacing-stack}
  Widget stack(double space) => Padding(padding: space.stack, child: this);

  /// {@macro zeta-spacing-inline-only}
  ///
  /// {@macro zeta-spacing-inline}
  Widget inline(double space) => Padding(padding: space.inline, child: this);

  /// {@macro zeta-spacing-inline-end}
  ///
  /// {@macro zeta-spacing-inline}
  Widget inlineStart(double space) => Padding(padding: space.inlineStart, child: this);

  /// {@macro zeta-spacing-inline-end}
  ///
  /// {@macro zeta-spacing-inline}
  Widget inlineEnd(double space) => Padding(padding: space.inlineEnd, child: this);
}
