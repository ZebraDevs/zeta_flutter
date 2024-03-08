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

/// Linear progress bar.
///
/// Uses progress percentage value to fill bar.
class ZetaProgressBar extends ZetaProgress {
  ///Constructor for [ZetaProgressBar].
  const ZetaProgressBar({
    super.key,
    required super.progress,
    required this.type,
    this.rounded = true,
    this.isThin = false,
    this.label,
  });

  /// Constructs a standard progress bar.
  const ZetaProgressBar.standard({
    super.key,
    required super.progress,
    this.rounded = true,
    this.isThin = false,
    this.label,
  }) : type = ZetaProgressBarType.standard;

  /// Constructs buffering example
  const ZetaProgressBar.buffering({
    super.key,
    required super.progress,
    this.rounded = true,
    this.isThin = false,
    this.label,
  }) : type = ZetaProgressBarType.buffering;

  /// Constructs indeterminate progress bar.
  const ZetaProgressBar.indeterminate({
    super.key,
    required super.progress,
    this.rounded = true,
    this.isThin = false,
    this.label,
  }) : type = ZetaProgressBarType.indeterminate;

  /// {@macro zeta-component-rounded}
  final bool rounded;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ??
              (widget.label == null && widget.type != ZetaProgressBarType.indeterminate
                  ? '${(animation.value * 100).toInt()}%'
                  : ''),
          style: ZetaTextStyles.titleMedium,
          textAlign: TextAlign.start,
        ).paddingBottom(ZetaSpacing.x4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: _weight,
                child: LinearProgressIndicator(
                  borderRadius: _border,
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
    );
  }

  /// Returns border based on widgets border type.
  BorderRadius get _border => widget.rounded ? ZetaRadius.rounded : ZetaRadius.none;

  /// Returns thickness of progress bar based on its weight.
  double get _weight => widget.isThin ? ZetaSpacing.x2 : ZetaSpacing.x4;

  Widget bufferingWidget(ZetaColors colors) {
    final Iterable<List<Widget>> extraList = List.generate(
      3,
      (e) => [
        const SizedBox(width: ZetaSpacing.x4),
        Container(
          width: _weight,
          height: _weight,
          decoration: BoxDecoration(
            color: colors.surfaceDisabled,
            borderRadius: ZetaRadius.rounded,
          ),
        ),
      ],
    );

    return Row(children: extraList.expand((list) => list).toList());
  }
}
