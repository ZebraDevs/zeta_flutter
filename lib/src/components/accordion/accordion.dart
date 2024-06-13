import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// The accordion is a control element comprising a vertically stacked list of items,
/// such as labels or thumbnails. Each item can be "expanded" or "collapsed" to reveal
/// the content associated with that item. There can be zero expanded items, exactly one,
/// or more than one item expanded at a time, depending on the configuration.
class ZetaAccordion extends ZetaStatefulWidget {
  /// The constructor of the component [ZetaAccordion].
  const ZetaAccordion({
    super.key,
    required this.title,
    this.child,
    this.contained = false,
    this.isOpen = false,
    super.rounded,
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
    init();
  }

  @override
  void didUpdateWidget(ZetaAccordion oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    _isOpen = widget.isOpen;
    _disabled = widget.child == null;
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
    final childTextStyle = ZetaTextStyles.h5.apply(color: zetaColors.textDefault);
    final rounded = context.rounded;
    return ZetaRoundedScope(
      rounded: rounded,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: widget.contained ? Border.all(color: borderColor) : Border(top: BorderSide(color: borderColor)),
          borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(borderRadius: rounded ? ZetaRadius.minimal : ZetaRadius.none),
                  ),
                  overlayColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return zetaColors.cool.shade20;
                    }
                    if (states.contains(WidgetState.pressed)) {
                      return zetaColors.cool.shade30;
                    }

                    if (states.contains(WidgetState.focused)) {
                      return Colors.transparent;
                    }

                    return null;
                  }),
                  side: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.focused)) {
                      return BorderSide(color: zetaColors.blue.shade50, width: 2);
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
                  padding: const EdgeInsets.all(ZetaSpacing.large),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: ZetaTextStyles.titleMedium.apply(
                          color: _disabled ? zetaColors.textDisabled : zetaColors.textDefault,
                        ),
                        child: Flexible(child: Text(widget.title)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: ZetaSpacing.large),
                        child: Icon(
                          _isOpen
                              ? (rounded ? ZetaIcons.remove_round : ZetaIcons.remove_sharp)
                              : (rounded ? ZetaIcons.add_round : ZetaIcons.add_sharp),
                          color: _disabled ? zetaColors.iconDisabled : zetaColors.iconDefault,
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
                  padding: const EdgeInsets.fromLTRB(
                    ZetaSpacing.large,
                    ZetaSpacing.none,
                    ZetaSpacing.large,
                    ZetaSpacing.large,
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(listTileTheme: ListTileThemeData(titleTextStyle: childTextStyle)),
                    child: DefaultTextStyle(
                      style: childTextStyle,
                      child: widget.child ?? const SizedBox(),
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
