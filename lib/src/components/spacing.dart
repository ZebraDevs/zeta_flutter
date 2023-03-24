import 'package:flutter/widgets.dart';

/// Spacing types for [ZetaSpacing].
enum ZetaSpacingType {
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
  /// With all due respect to horizontally scrolled UI, the overwhelming majority scroll vertically. And that means one thing, we stack things. We stack message on heading on data table. We stack modules in rails. We stack copy, pills & toolbars, all in a card, each in a grid. Heck, infinite scroll means infinite stack! We stack, stack, stack.
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

/// Zeta Spacing widget.
class ZetaSpacing extends StatelessWidget {
  static const double _space = 4;

  /// 0dp space.
  static const double x0 = _space * 0;

  /// 4dp space.
  static const double x1 = _space;

  /// 4dp space.
  static const double xxs = _space;

  /// 8dp space.
  static const double x2 = _space * 2;

  /// 8dp space.
  static const double xs = _space * 2;

  /// 12dp space.
  static const double x3 = _space * 3;

  /// 12dp space.
  static const double s = _space * 3;

  /// 14dp space.
  static const double x3_5 = _space * 3.5;

  /// 16dp space.
  static const double x4 = _space * 4;

  /// 16dp space.
  static const double b = _space * 4;

  /// 20dp space.
  static const double x5 = _space * 5;

  /// 24dp space.
  static const double x6 = _space * 6;

  /// 24dp space.
  static const double m = _space * 6;

  /// 28dp space.
  static const double x7 = _space * 7;

  /// 32dp space.
  static const double x8 = _space * 8;

  /// 32dp space.
  static const double l = _space * 8;

  /// 36dp space.
  static const double x9 = _space * 9;

  /// 40dp space.
  static const double x10 = _space * 10;

  /// 44dp space.
  static const double x11 = _space * 11;

  /// 48dp space.
  static const double x12 = _space * 12;

  /// 52dp Space.
  static const double x13 = _space * 13;

  /// 56dp Space.
  static const double x14 = _space * 14;

  /// 64dp space.
  static const double x16 = _space * 16;

  /// 64dp space.
  static const double xl = _space * 16;

  /// 80dp space.
  static const double x20 = _space * 20;

  /// 80dp space.
  static const double xxl = _space * 20;

  /// 96dp space.
  static const double x24 = _space * 24;

  /// 96dp space.
  static const double xxxl = _space * 24;

  static const double _mod = 2;

  /// Child to be wrapped with spacing insets.
  final Widget child;

  /// [ZetaSpacingType] insets applied to [child].
  ///
  /// Defaults to [ZetaSpacingType.square].
  final ZetaSpacingType? type;

  /// Size of insets to be applied around [child].
  ///
  /// Should be an even number, and be no larger than [x24].
  ///
  /// Defaults to [x0].
  final double size;

  /// Constructs [ZetaSpacing].
  const ZetaSpacing(
    this.child, {
    this.type = ZetaSpacingType.square,
    this.size = x0,
    super.key,
  }) : assert(
          size % _mod == 0 && size >= 0 && size <= x24,
          'Size should be a whole, even number, and be no larger than [x24]',
        );

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.square] insets.
  ///
  /// {@macro zeta-spacing-square}
  const ZetaSpacing.square(this.child, {this.size = x0, super.key}) : type = ZetaSpacingType.square;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.squish] insets.
  ///
  /// {@macro zeta-spacing-squish}
  const ZetaSpacing.squish(this.child, {this.size = x0, super.key}) : type = ZetaSpacingType.squish;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.stack] insets.
  ///
  /// {@macro zeta-spacing-stack}
  const ZetaSpacing.stack(this.child, {this.size = x0, super.key}) : type = ZetaSpacingType.stack;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.inline] insets.
  ///
  /// {@macro zeta-spacing-inline-only}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inline(this.child, {this.size = x0, super.key}) : type = ZetaSpacingType.inline;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.inlineStart] insets.
  ///
  /// {@macro zeta-spacing-inline-start}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inlineStart(this.child, {this.size = x0, super.key}) : type = ZetaSpacingType.inlineStart;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.inlineEnd] insets.
  ///
  /// {@macro zeta-spacing-inline-end}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inlineEnd(this.child, {this.size = x0, super.key}) : type = ZetaSpacingType.inlineEnd;

  @override
  Widget build(BuildContext context) {
    switch (type ?? ZetaSpacingType.square) {
      case ZetaSpacingType.square:
        return child.square(size);
      case ZetaSpacingType.squish:
        return child.squish(size);
      case ZetaSpacingType.stack:
        return child.stack(size);
      case ZetaSpacingType.inline:
        return child.inline(size);
      case ZetaSpacingType.inlineStart:
        return child.inlineStart(size);
      case ZetaSpacingType.inlineEnd:
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
