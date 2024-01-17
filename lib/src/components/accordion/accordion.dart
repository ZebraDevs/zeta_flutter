import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

/// Component [ZetaAccordion]
class ZetaAccordion extends StatelessWidget {
  /// The constructor of the component [ZetaAccordion]
  const ZetaAccordion({
    super.key,
    required this.children,
    this.separator,
    this.spaceBetween = 20.0,
    this.margin,
    this.rounded = true,
    this.contained = false,
  });

  /// List of [ZetaAccordionSection] to show in [ZetaAccordion]
  final List<ZetaAccordionSection> children;

  /// Custom separator between the [ZetaAccordionSection]s in the list `children`.
  /// Default is empty space with height of `spaceBetween`.
  final Widget? separator;

  /// The height of the space between [ZetaAccordionSection]s `children`.
  /// Default is 20.
  final double spaceBetween;

  /// The space around the [ZetaAccordion]. Default is `zero`.
  final EdgeInsets? margin;

  /// Sets rounded or sharp border of the containing box and the icon style.
  /// Default is `true`.
  final bool rounded;

  /// Determines if the [ZetaAccordionSection]s should be in a box.
  /// Default is `false`
  final bool contained;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: margin ?? EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder: (context, index) => children[index].copyWith(
        rounded: rounded,
        contained: contained,
      ),
      separatorBuilder: (context, index) => separator ?? SizedBox(height: spaceBetween),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<double>('spaceBetween', spaceBetween))
      ..add(DiagnosticsProperty<EdgeInsets?>('margin', margin))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('contained', contained));
  }
}

/// The element for the `children` of [ZetaAccordion]
class ZetaAccordionSection extends StatefulWidget {
  /// The constructor of the [ZetaAccordionSection]
  const ZetaAccordionSection({
    super.key,
    required this.title,
    required this.body,
    this.isOpen = false,
    this.disabled = false,
    this.rounded = true,
    this.contained = false,
  });

  /// The header of the [ZetaAccordionSection].
  final Widget title;

  /// The content of the [ZetaAccordionSection].
  final Widget body;

  /// Sets the initial state of the [ZetaAccordionSection].
  /// Default is `false`.
  final bool isOpen;

  /// Determines if [ZetaAccordionSection] should be disabled.
  /// Default is `false`.
  final bool disabled;

  /// Sets rounded or sharp border of the containing box and the icon style.
  /// Default is `true`.
  final bool rounded;

  /// Determines if the [ZetaAccordionSection]s should be in a box.
  /// Default is `false`
  final bool contained;

  @override
  State<ZetaAccordionSection> createState() => _ZetaAccordionSectionState();

  /// Creates another instance of the same [ZetaAccordionSection],
  /// but with modified properties.
  ZetaAccordionSection copyWith({
    bool rounded = true,
    bool contained = false,
  }) {
    return ZetaAccordionSection(
      title: title,
      body: body,
      isOpen: isOpen,
      disabled: disabled,
      rounded: rounded,
      contained: contained,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isOpen', isOpen))
      ..add(DiagnosticsProperty<bool>('disabled', disabled))
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(DiagnosticsProperty<bool>('contained', contained));
  }
}

class _ZetaAccordionSectionState extends State<ZetaAccordionSection> with TickerProviderStateMixin {
  late bool _isOpen;
  late bool _disabled;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    init();
  }

  @override
  void didUpdateWidget(ZetaAccordionSection oldWidget) {
    init();
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    _isOpen = widget.isOpen;
    _disabled = widget.disabled;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zetaColors = Zeta.of(context).colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: widget.contained
            ? Border.all(
                color: _disabled ? zetaColors.borderDisabled : zetaColors.borderDefault,
              )
            : null,
        borderRadius: widget.rounded ? BorderRadius.circular(Dimensions.xxs) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: _disabled
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
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontSize: 18,
                      height: 1.33,
                      fontWeight: FontWeight.w500,
                      color: _disabled ? zetaColors.textDisabled : zetaColors.textDefault,
                    ),
                    child: Flexible(child: widget.title),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Icon(
                      _isOpen
                          ? (widget.rounded ? ZetaIcons.remove_round : ZetaIcons.remove_sharp)
                          : (widget.rounded ? ZetaIcons.add_round : ZetaIcons.add_sharp),
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: zetaColors.textDefault,
                ),
                child: widget.body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
