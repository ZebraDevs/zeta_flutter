import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';
import '../../../zeta_flutter.dart';

/// A segmented control is a linear set of two or more segments, each of which functions as a mutually exclusive button. Like buttons, segments can contain text or images. Segmented controls are often used to display different views.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1046-20148&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/segmented-control/zetasegmentedcontrol/text
class ZetaSegmentedControl<T> extends ZetaStatefulWidget {
  /// Constructs an segmented control bar.
  const ZetaSegmentedControl({
    super.rounded,
    super.key,
    required this.segments,
    required this.onChanged,
    required this.selected,
    this.semanticLabel,
  });

  /// The callback that is called when a new option is tapped.
  final void Function(T)? onChanged;

  /// Descriptions of the segments in the button.
  final List<ZetaButtonSegment<T>> segments;

  /// Currently selected segment.
  final T selected;

  /// The semantic label for the segmented control.
  ///
  /// {@macro zeta-widget-semantic-label}
  final String? semanticLabel;

  @override
  State<ZetaSegmentedControl<T>> createState() => _ZetaSegmentedControlState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<void Function(T p1)?>.has('onChanged', onChanged))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(IterableProperty<ZetaButtonSegment<T>>('segments', segments))
      ..add(DiagnosticsProperty<T>('selected', selected))
      ..add(StringProperty('semanticLabel', semanticLabel));
  }
}

class _ZetaSegmentedControlState<T> extends State<ZetaSegmentedControl<T>>
    with TickerProviderStateMixin<ZetaSegmentedControl<T>> {
  T? _highlighted;
  Animatable<Rect?>? _thumbAnimatable;

  late final AnimationController _thumbController = AnimationController(
    duration: kThemeAnimationDuration,
    value: 0,
    vsync: this,
  );

  late final Animation<double> _thumbScaleAnimation = _thumbScaleController.drive(Tween<double>(begin: 1));

  late final _thumbScaleController = AnimationController(
    duration: kThemeAnimationDuration,
    value: 0,
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    _highlighted = widget.selected;
  }

  @override
  void didUpdateWidget(ZetaSegmentedControl<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_highlighted != widget.selected) {
      unawaited(
        _thumbController.animateWith(
          SpringSimulation(
            const SpringDescription(mass: 1, stiffness: 500, damping: 44),
            0,
            1,
            0, // Every time a new spring animation starts the previous animation stops.
          ),
        ),
      );
      _thumbAnimatable = null;
      _highlighted = widget.selected;
    }
  }

  @override
  void dispose() {
    _thumbScaleController.dispose();
    _thumbController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    int index = 0;
    int? highlightedIndex;
    for (final segment in widget.segments) {
      final isHighlighted = _highlighted == segment.value;
      if (isHighlighted) highlightedIndex = index;

      if (index != 0) {
        children.add(SizedBox(key: Key(index.toString())));
      }

      children.add(
        _Segment<T>(
          key: ValueKey<T>(segment.value),
          onTap: () => widget.onChanged?.call(segment.value),
          value: segment.value,
          child: segment.child,
        ),
      );

      index += 1;
    }

    final colors = Zeta.of(context).colors;
    final rounded = context.rounded;

    return ZetaRoundedScope(
      rounded: rounded,
      child: Semantics(
        label: widget.semanticLabel,
        container: true,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: SelectionContainer.disabled(
            child: Container(
              padding: EdgeInsets.all(Zeta.of(context).spacing.minimum),
              decoration: BoxDecoration(
                color: colors.surfaceDisabled,
                borderRadius:
                    BorderRadius.all(rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
              ),
              child: AnimatedBuilder(
                animation: _thumbScaleAnimation,
                builder: (BuildContext context, Widget? child) {
                  return _SegmentedControlRenderWidget<T>(
                    highlightedIndex: highlightedIndex,
                    thumbColor: colors.surfaceDefault,
                    thumbScale: _thumbScaleAnimation.value,
                    rounded: rounded,
                    state: this,
                    children: children,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Data describing a segment of a [ZetaSegmentedControl].
class ZetaButtonSegment<T> {
  /// Construct a [ZetaButtonSegment].
  const ZetaButtonSegment({
    required this.value,
    required this.child,
  });

  /// The child to be displayed
  final Widget child;

  /// Value used to identify the segment.
  ///
  /// This value must be unique across all segments.
  final T value;
}

class _Segment<T> extends ZetaStatefulWidget {
  const _Segment({
    required ValueKey<T> key,
    required this.child,
    required this.onTap,
    required this.value,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final T value;

  @override
  _SegmentState<T> createState() => _SegmentState<T>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap))
      ..add(DiagnosticsProperty<T>('value', value));
  }
}

class _SegmentState<T> extends State<_Segment<T>> with TickerProviderStateMixin<_Segment<T>> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return Semantics(
      button: true,
      excludeSemantics: true,
      value: widget.value.toString(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          borderRadius:
              BorderRadius.all(context.rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
          onTap: widget.onTap,
          child: IconTheme(
            data: IconThemeData(size: Zeta.of(context).spacing.xl),
            child: DefaultTextStyle(
              style: Zeta.of(context).textStyles.labelMedium.copyWith(
                    color: colors.mainDefault,
                  ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Zeta.of(context).spacing.large,
                  vertical: Zeta.of(context).spacing.minimum,
                ),
                child: Center(child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SegmentedControlRenderWidget<T> extends MultiChildRenderObjectWidget {
  const _SegmentedControlRenderWidget({
    super.key,
    super.children,
    required this.highlightedIndex,
    required this.thumbColor,
    required this.thumbScale,
    required this.state,
    required this.rounded,
  });

  final int? highlightedIndex;
  final bool rounded;
  final _ZetaSegmentedControlState<T> state;
  final Color thumbColor;
  final double thumbScale;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderSegmentedControl<T>(
      highlightedIndex: highlightedIndex,
      thumbColor: thumbColor,
      rounded: rounded,
      state: state,
      context: context,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('highlightedIndex', highlightedIndex))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<_ZetaSegmentedControlState<T>>('state', state))
      ..add(ColorProperty('thumbColor', thumbColor))
      ..add(DoubleProperty('thumbScale', thumbScale));
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderSegmentedControl<T> renderObject,
  ) {
    renderObject
      ..thumbColor = thumbColor
      ..highlightedIndex = highlightedIndex;
  }
}

class _SegmentedControlContainerBoxParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderSegmentedControl<T> extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, ContainerBoxParentData<RenderBox>>,
        RenderBoxContainerDefaultsMixin<RenderBox, ContainerBoxParentData<RenderBox>> {
  _RenderSegmentedControl({
    required int? highlightedIndex,
    required Color thumbColor,
    required this.rounded,
    required this.state,
    required this.context,
  })  : _highlightedIndex = highlightedIndex,
        _thumbColor = thumbColor;

  // The current **Unscaled** Thumb Rect in this RenderBox's coordinate space.
  Rect? currentThumbRect;

  /// Wether the corners to be rounded.
  final bool rounded;

  // Paint the separator to the right of the given child.
  final Paint separatorPaint = Paint();

  final _ZetaSegmentedControlState<T> state;

  final BuildContext context;

  int? _highlightedIndex;
  Color _thumbColor;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    state._thumbController.addListener(markNeedsPaint);
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    final Size childSize = _calculateChildSize(constraints);
    return _computeOverallSizeFromChildSize(childSize, constraints);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    RenderBox? child = firstChild;
    double maxMaxChildHeight = Zeta.of(context).spacing.xl_3;
    while (child != null) {
      final double childHeight = child.getMaxIntrinsicHeight(width);
      maxMaxChildHeight = math.max(maxMaxChildHeight, childHeight);
      child = nonSeparatorChildAfter(child);
    }
    return maxMaxChildHeight;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    final int childCount = this.childCount ~/ 2 + 1;
    RenderBox? child = firstChild;
    double maxMaxChildWidth = 0;
    while (child != null) {
      final double childWidth = child.getMaxIntrinsicWidth(height);
      maxMaxChildWidth = math.max(maxMaxChildWidth, childWidth);
      child = nonSeparatorChildAfter(child);
    }
    return maxMaxChildWidth * childCount + totalSeparatorWidth;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    RenderBox? child = firstChild;
    double maxMinChildHeight = Zeta.of(context).spacing.xl_3;
    while (child != null) {
      final double childHeight = child.getMinIntrinsicHeight(width);
      maxMinChildHeight = math.max(maxMinChildHeight, childHeight);
      child = nonSeparatorChildAfter(child);
    }
    return maxMinChildHeight;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    final int childCount = this.childCount ~/ 2 + 1;
    RenderBox? child = firstChild;
    double maxMinChildWidth = 0;
    while (child != null) {
      final double childWidth = child.getMinIntrinsicWidth(height);
      maxMinChildWidth = math.max(maxMinChildWidth, childWidth);
      child = nonSeparatorChildAfter(child);
    }
    return (maxMinChildWidth + 2 * Zeta.of(context).spacing.xl_4) * childCount + totalSeparatorWidth;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Rect?>('currentThumbRect', currentThumbRect))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<Paint>('separatorPaint', separatorPaint))
      ..add(DiagnosticsProperty<_ZetaSegmentedControlState<T>>('state', state))
      ..add(IntProperty('highlightedIndex', highlightedIndex))
      ..add(ColorProperty('thumbColor', thumbColor))
      ..add(DoubleProperty('totalSeparatorWidth', totalSeparatorWidth))
      ..add(DiagnosticsProperty<BuildContext>('context', context));
  }

  @override
  void detach() {
    state._thumbController.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    RenderBox? child = lastChild;
    while (child != null) {
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      if ((childParentData.offset & child.size).contains(position)) {
        return result.addWithPaintOffset(
          offset: childParentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset localOffset) {
            return child!.hitTest(result, position: localOffset);
          },
        );
      }
      child = childParentData.previousSibling;
    }
    return false;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final List<RenderBox> children = getChildrenAsList();

    for (int index = 1; index < childCount; index += 2) {
      _paintSeparator(context, offset, children[index]);
    }

    final int? highlightedChildIndex = highlightedIndex;
    // Paint thumb if there's a highlighted segment.
    if (highlightedChildIndex != null) {
      final RenderBox selectedChild = children[highlightedChildIndex * 2];

      final _SegmentedControlContainerBoxParentData childParentData =
          selectedChild.parentData! as _SegmentedControlContainerBoxParentData;
      final newThumbRect = childParentData.offset & selectedChild.size;

      // Update thumb animation's tween, in case the end rect changed (e.g., a
      // new segment is added during the animation).
      if (state._thumbController.isAnimating) {
        final Animatable<Rect?>? thumbTween = state._thumbAnimatable;
        if (thumbTween == null) {
          // This is the first frame of the animation.
          final Rect startingRect = moveThumbRectInBound(currentThumbRect, children) ?? newThumbRect;
          state._thumbAnimatable = RectTween(begin: startingRect, end: newThumbRect);
        } else if (newThumbRect != thumbTween.transform(1)) {
          // The thumbTween of the running sliding animation needs updating,
          // without restarting the animation.
          final Rect startingRect = moveThumbRectInBound(currentThumbRect, children) ?? newThumbRect;
          state._thumbAnimatable = RectTween(begin: startingRect, end: newThumbRect).chain(
            CurveTween(curve: Interval(state._thumbController.value, 1)),
          );
        }
      } else {
        state._thumbAnimatable = null;
      }

      final Rect unscaledThumbRect = state._thumbAnimatable?.evaluate(state._thumbController) ?? newThumbRect;
      currentThumbRect = unscaledThumbRect;
      final Rect thumbRect = Rect.fromCenter(
        center: unscaledThumbRect.center,
        width: unscaledThumbRect.width,
        height: unscaledThumbRect.height,
      );

      _paintThumb(context, offset, thumbRect);
    } else {
      currentThumbRect = null;
    }

    for (int index = 0; index < children.length; index += 2) {
      _paintChild(context, offset, children[index]);
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    final Size childSize = _calculateChildSize(constraints);
    final BoxConstraints childConstraints = BoxConstraints.tight(childSize);
    final BoxConstraints separatorConstraints = childConstraints.heightConstraints();

    RenderBox? child = firstChild;
    int index = 0;
    double start = 0;
    while (child != null) {
      child.layout(
        index.isEven ? childConstraints : separatorConstraints,
        parentUsesSize: true,
      );
      final _SegmentedControlContainerBoxParentData childParentData =
          child.parentData! as _SegmentedControlContainerBoxParentData;
      final Offset childOffset = Offset(start, 0);
      childParentData.offset = childOffset;
      start += child.size.width;

      child = childAfter(child);
      index += 1;
    }

    size = _computeOverallSizeFromChildSize(childSize, constraints);
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _SegmentedControlContainerBoxParentData) {
      child.parentData = _SegmentedControlContainerBoxParentData();
    }
  }

  int? get highlightedIndex => _highlightedIndex;

  set highlightedIndex(int? value) {
    if (_highlightedIndex == value) {
      return;
    }

    _highlightedIndex = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;

  set thumbColor(Color value) {
    if (_thumbColor == value) {
      return;
    }
    _thumbColor = value;
    markNeedsPaint();
  }

  double get totalSeparatorWidth => 0.0 * (childCount ~/ 2);

  RenderBox? nonSeparatorChildAfter(RenderBox child) {
    final RenderBox? nextChild = childAfter(child);
    return nextChild == null ? null : childAfter(nextChild);
  }

  // This method is used to convert the original unscaled thumb rect painted in
  // the previous frame, to a Rect that is within the valid boundary defined by
  // the child segments.
  //
  // The overall size does not include that of the thumb. That is, if the thumb
  // is located at the first or the last segment, the thumb can get cut off if
  // one of the values in _kThumbInsets is positive.
  Rect? moveThumbRectInBound(Rect? thumbRect, List<RenderBox> children) {
    if (thumbRect == null) {
      return null;
    }

    final Offset firstChildOffset = (children.first.parentData! as _SegmentedControlContainerBoxParentData).offset;
    final double leftMost = firstChildOffset.dx;
    final double rightMost =
        (children.last.parentData! as _SegmentedControlContainerBoxParentData).offset.dx + children.last.size.width;

    // Ignore the horizontal position and the height of `thumbRect`, and
    // calculates them from `children`.
    return Rect.fromLTRB(
      math.max(thumbRect.left, leftMost),
      firstChildOffset.dy,
      math.min(thumbRect.right, rightMost),
      firstChildOffset.dy + children.first.size.height,
    );
  }

  Size _calculateChildSize(BoxConstraints constraints) {
    final int childCount = this.childCount ~/ 2 + 1;
    double childWidth = (constraints.minWidth - totalSeparatorWidth) / childCount;
    double maxHeight = Zeta.of(context).spacing.xl_3;
    RenderBox? child = firstChild;
    while (child != null) {
      childWidth = math.max(childWidth, child.getMaxIntrinsicWidth(double.infinity) + 2);
      child = nonSeparatorChildAfter(child);
    }
    childWidth = math.min(
      childWidth,
      (constraints.maxWidth - totalSeparatorWidth) / childCount,
    );
    child = firstChild;
    while (child != null) {
      final double boxHeight = child.getMaxIntrinsicHeight(childWidth);
      maxHeight = math.max(maxHeight, boxHeight);
      child = nonSeparatorChildAfter(child);
    }
    return Size(childWidth, maxHeight);
  }

  Size _computeOverallSizeFromChildSize(
    Size childSize,
    BoxConstraints constraints,
  ) {
    final int childCount = this.childCount ~/ 2 + 1;
    return constraints.constrain(
      Size(
        childSize.width * childCount + totalSeparatorWidth,
        childSize.height,
      ),
    );
  }

  void _paintSeparator(
    PaintingContext context,
    Offset offset,
    RenderBox child,
  ) {
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData! as _SegmentedControlContainerBoxParentData;
    context.paintChild(child, offset + childParentData.offset);
  }

  void _paintChild(PaintingContext context, Offset offset, RenderBox child) {
    final _SegmentedControlContainerBoxParentData childParentData =
        child.parentData! as _SegmentedControlContainerBoxParentData;
    context.paintChild(child, childParentData.offset + offset);
  }

  void _paintThumb(PaintingContext paintingContext, Offset offset, Rect thumbRect) {
    final RRect thumbRRect = RRect.fromRectAndRadius(
      thumbRect.shift(offset),
      rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none,
    );

    paintingContext.canvas.drawRRect(
      thumbRRect,
      Paint()..color = thumbColor,
    );
  }
}
