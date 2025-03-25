import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';

import 'progress.dart';

/// Enum for types of progress bar.
enum ZetaProgressBarType {
  /// Standard bar type.
  standard,

  /// Indeterminate bar type. positions randomly.
  indeterminate,

  /// Buffering bar type. Has buffering at end.
  buffering
}

/// Progress indicators express an unspecified wait time or display the length of a process.
///
/// Linear progress bar. Uses progress percentage value to fill bar.
///
/// Figma: https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=229-22&node-type=canvas&m=dev
///
/// Widgetbook: https://design.zebra.com/flutter/widgetbook/index.html#/?path=components/progress/zetaprogressbar/progress-bar
class ZetaProgressBar extends ZetaProgress {
  ///Constructor for [ZetaProgressBar].
  const ZetaProgressBar({
    super.key,
    super.rounded,
    required super.progress,
    this.type = ZetaProgressBarType.standard,
    this.isThin = false,
    this.label,
  });

  /// Constructs a standard progress bar.
  const ZetaProgressBar.standard({
    super.key,
    super.rounded,
    required super.progress,
    this.isThin = false,
    this.label,
  }) : type = ZetaProgressBarType.standard;

  /// Constructs buffering example
  const ZetaProgressBar.buffering({
    super.key,
    super.rounded,
    required super.progress,
    this.isThin = false,
    this.label,
  }) : type = ZetaProgressBarType.buffering;

  /// Constructs indeterminate progress bar.
  const ZetaProgressBar.indeterminate({
    super.key,
    super.rounded,
    required super.progress,
    this.isThin = false,
    this.label,
  }) : type = ZetaProgressBarType.indeterminate;

  /// Type of the progress bar.
  final ZetaProgressBarType type;

  /// Is Progress bar thin or thick.
  ///
  /// Defaults to `false`.
  final bool isThin;

  /// Optional label.
  ///
  /// If null, default label will show percentage.
  ///
  /// Currently Zeta does not have translation support, so there are no built in strings
  // TODO(UX-1003): Investigate i18n.
  final String? label;

  @override
  State<ZetaProgressBar> createState() => _ZetaProgressBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaProgressBarType>('type', type))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('isThin', isThin));
  }
}

class _ZetaProgressBarState extends ZetaProgressState<ZetaProgressBar> {
  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;
    return Semantics(
      value: widget.type != ZetaProgressBarType.indeterminate ? '${progress * 100}%' : null,
      label: widget.label,
      excludeSemantics: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label ??
                (widget.label == null && widget.type != ZetaProgressBarType.indeterminate
                    ? '${(animation.value * 100).toInt()}%'
                    : ''),
            style: ZetaTextStyles.titleMedium,
            textAlign: TextAlign.start,
          ).paddingBottom(Zeta.of(context).spacing.large),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: ZetaAnimationLength.verySlow,
                  height: _weight,
                  child: LinearProgressIndicator(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    // TODO(Design): This does not use a token but is hardcoded
                    value: widget.type == ZetaProgressBarType.indeterminate ? null : animation.value,
                    backgroundColor:
                        widget.type == ZetaProgressBarType.buffering ? colors.surfaceDisabled : Colors.transparent,
                  ),
                ),
              ),
              if (widget.type == ZetaProgressBarType.buffering) bufferingWidget(colors),
            ],
          ),
        ],
      ),
    );
  }

  /// Returns thickness of progress bar based on its weight.
  double get _weight => widget.isThin ? Zeta.of(context).spacing.small : Zeta.of(context).spacing.large;

  Widget bufferingWidget(ZetaColors colors) {
    final Iterable<List<Widget>> extraList = List.generate(
      3,
      (e) => [
        SizedBox(width: Zeta.of(context).spacing.large),
        Container(
          width: _weight,
          height: _weight,
          decoration: BoxDecoration(color: colors.surfaceDisabled, shape: BoxShape.circle),
        ),
      ],
    );

    return Row(children: extraList.expand((list) => list).toList());
  }
}
