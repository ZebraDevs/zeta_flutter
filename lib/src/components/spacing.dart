import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../tokens.dart';

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
  /// Constructs [ZetaSpacing].
  const ZetaSpacing(
    this.child, {
    this.type = ZetaSpacingType.square,
    this.size = Dimensions.x0,
    super.key,
  }) : assert(
          size % _mod == 0 && size >= 0 && size <= Dimensions.x24,
          'Size should be a whole, even number, and be no larger than [x24]',
        );

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.square] insets.
  ///
  /// {@macro zeta-spacing-square}
  const ZetaSpacing.square(this.child, {this.size = Dimensions.x0, super.key}) : type = ZetaSpacingType.square;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.squish] insets.
  ///
  /// {@macro zeta-spacing-squish}
  const ZetaSpacing.squish(this.child, {this.size = Dimensions.x0, super.key}) : type = ZetaSpacingType.squish;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.stack] insets.
  ///
  /// {@macro zeta-spacing-stack}
  const ZetaSpacing.stack(this.child, {this.size = Dimensions.x0, super.key}) : type = ZetaSpacingType.stack;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.inline] insets.
  ///
  /// {@macro zeta-spacing-inline-only}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inline(this.child, {this.size = Dimensions.x0, super.key}) : type = ZetaSpacingType.inline;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.inlineStart] insets.
  ///
  /// {@macro zeta-spacing-inline-start}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inlineStart(this.child, {this.size = Dimensions.x0, super.key})
      : type = ZetaSpacingType.inlineStart;

  /// Constructs a [ZetaSpacing] widget with [ZetaSpacingType.inlineEnd] insets.
  ///
  /// {@macro zeta-spacing-inline-end}
  ///
  /// {@macro zeta-spacing-inline}
  const ZetaSpacing.inlineEnd(this.child, {this.size = Dimensions.x0, super.key}) : type = ZetaSpacingType.inlineEnd;
  static const double _mod = 2;

  /// Child to be wrapped with spacing insets.
  final Widget child;

  /// [ZetaSpacingType] insets applied to [child].
  ///
  /// Defaults to [ZetaSpacingType.square].
  final ZetaSpacingType? type;

  /// Size of insets to be applied around [child].
  ///
  /// Should be an even number, and be no larger than [Dimensions.x24].
  ///
  /// Defaults to [Dimensions.x0].
  final double size;

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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaSpacingType?>('type', type))
      ..add(DoubleProperty('size', size));
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
