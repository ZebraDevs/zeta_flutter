import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// The accordion is a control element comprising a vertically stacked list of items,
/// such as labels or thumbnails. Each item can be "expanded" or "collapsed" to reveal
/// the content associated with that item. There can be zero expanded items, exactly one,
/// or more than one item expanded at a time, depending on the configuration.
/// {@category Components}
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
  late bool isOpen;
  late bool disabled;
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: ZetaAnimationLength.normal,
      reverseDuration: ZetaAnimationLength.fast,
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    setInitialOpen();
    disabled = widget.child == null;
  }

  @override
  void didUpdateWidget(ZetaAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isOpen != widget.isOpen) {
      setInitialOpen();
    }
    if (oldWidget.child != widget.child) {
      disabled = widget.child == null;
    }
  }

  void setInitialOpen() {
    isOpen = widget.isOpen;
    controller.value = isOpen ? 1 : 0;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;
    final borderColor = disabled ? zetaColors.borderDisabled : zetaColors.borderSubtle;
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
                onPressed: disabled
                    ? null
                    : () => setState(() {
                          if (isOpen) {
                            controller.reverse();
                            isOpen = false;
                          } else {
                            isOpen = true;
                            controller.forward();
                          }
                        }),
                child: Padding(
                  padding: const EdgeInsets.all(ZetaSpacing.large),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultTextStyle(
                        style: ZetaTextStyles.titleMedium.apply(
                          color: disabled ? zetaColors.textDisabled : zetaColors.textDefault,
                        ),
                        child: Flexible(child: Text(widget.title)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: ZetaSpacing.large),
                        child: ZetaIcon(
                          isOpen ? ZetaIcons.remove : ZetaIcons.add,
                          color: disabled ? zetaColors.iconDisabled : zetaColors.iconDefault,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizeTransition(
                sizeFactor: animation,
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isOpen', isOpen))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<AnimationController>('controller', controller))
      ..add(DiagnosticsProperty<Animation<double>>('animation', animation));
  }
}
