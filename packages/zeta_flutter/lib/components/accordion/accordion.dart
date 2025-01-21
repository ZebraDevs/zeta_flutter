import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../zeta_flutter.dart';

/// The accordion is a control element comprising a vertically stacked list of items,
/// such as labels or thumbnails. Each item can be "expanded" or "collapsed" to reveal
/// the content associated with that item. There can be zero expanded items, exactly one,
/// or more than one item expanded at a time, depending on the configuration.
///
/// Figma: https://www.figma.com/file/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?type=design&node-id=3427-67874
///
/// Widgetbook: https://zeta-ds.web.app/flutter/widgetbook/index.html#/?path=components/accordion
class ZetaAccordion extends ZetaStatefulWidget {
  /// The constructor of the component [ZetaAccordion].
  const ZetaAccordion({
    super.key,
    super.rounded,
    required this.title,
    this.child,
    this.contained = false,
    this.isOpen = false,
  });

  /// Children displayed when component is opened.
  ///
  /// If null, component will render as disabled.
  final Widget? child;

  /// Determines if the [ZetaAccordion]s should be in a box.
  ///
  /// Defaults to `false`.
  final bool contained;

  /// Title of Accordion.
  final String title;

  /// Whether the accordion is open or closed.
  ///
  /// Defaults to false(closed).
  final bool isOpen;

  @override
  State<ZetaAccordion> createState() => _ZetaAccordionState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('contained', contained))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('isOpen', isOpen));
  }
}

class _ZetaAccordionState extends State<ZetaAccordion> with TickerProviderStateMixin {
  late bool _isOpen;
  late bool _disabled;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: ZetaAnimationLength.normal,
      reverseDuration: ZetaAnimationLength.fast,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    setInitialOpen();
    _disabled = widget.child == null;
  }

  @override
  void didUpdateWidget(ZetaAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      setInitialOpen();
    }
    if (oldWidget.child != widget.child) {
      _disabled = widget.child == null;
    }
  }

  void setInitialOpen() {
    _isOpen = widget.isOpen;
    _controller.value = _isOpen ? 1 : 0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final borderColor = _disabled ? zetaColors.borderDisabled : zetaColors.borderSubtle;
    final childTextStyle = ZetaTextStyles.h5.apply(color: zetaColors.mainDefault);
    final rounded = context.rounded;
    final Color color = _disabled ? zetaColors.mainDisabled : zetaColors.mainDefault;
    return ZetaRoundedScope(
      rounded: rounded,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: widget.contained ? Border.all(color: borderColor) : Border(top: BorderSide(color: borderColor)),
          borderRadius: BorderRadius.all(rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(rounded ? Zeta.of(context).radius.minimal : Zeta.of(context).radius.none),
                    ),
                  ),
                  overlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return zetaColors.surfaceHover;
                    }
                    if (states.contains(WidgetState.pressed)) {
                      return zetaColors.surfaceSelectedHover;
                    }

                    if (states.contains(WidgetState.focused)) {
                      return Colors.transparent;
                    }

                    return null;
                  }),
                  side: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.focused)) {
                      return BorderSide(color: zetaColors.borderPrimary, width: 2);
                    }
                    return null;
                  }),
                ),
                onPressed: _disabled
                    ? null
                    : () => setState(() {
                          if (_isOpen) {
                            _controller.reverse();
                            _isOpen = false;
                          } else {
                            _isOpen = true;
                            _controller.forward();
                          }
                        }),
                child: Padding(
                  padding: EdgeInsets.all(Zeta.of(context).spacing.large),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: ZetaTextStyles.titleMedium.apply(
                          color: color,
                        ),
                        child: Flexible(child: Text(widget.title)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Zeta.of(context).spacing.large),
                        child: ZetaIcon(
                          _isOpen ? ZetaIcons.remove : ZetaIcons.add,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeTransition(
                sizeFactor: _animation,
                axisAlignment: -1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    Zeta.of(context).spacing.large,
                    Zeta.of(context).spacing.none,
                    Zeta.of(context).spacing.large,
                    Zeta.of(context).spacing.large,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(listTileTheme: ListTileThemeData(titleTextStyle: childTextStyle)),
                    child: DefaultTextStyle(
                      style: childTextStyle,
                      child: widget.child ?? const Nothing(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
