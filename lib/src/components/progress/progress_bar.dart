import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';
import 'progress.dart';

/// Enum for types of progress bar
enum ZetaBarType {
  /// Standard bar type.
  standard,

  /// Indeterminate bar type. positions randomly
  indeterminate,

  /// Buffering bar type. Has buffering at end.
  buffering
}

/// Linear progress bar.
/// Uses progress percentage value to fill bar
class ZetaProgressBar extends ZetaProgress {
  ///Constructor for [ZetaProgressBar]

  const ZetaProgressBar(
      {super.key,
      required super.progress,
      required this.rounded,
      required this.type,
      required this.isThin,
      this.label,});

  /// Constructs a standard progress bar
  const ZetaProgressBar.standard(
      {super.key,
      required super.progress,
      this.rounded = true,
      this.isThin = false,
      this.label,})
      : type = ZetaBarType.standard;

  /// Constructs buffering example
  const ZetaProgressBar.buffering(
      {super.key,
      required super.progress,
      this.rounded = true,
      this.isThin = false,
      this.label,})
      : type = ZetaBarType.buffering;

  /// Constructs indeterminate example
  const ZetaProgressBar.indeterminate(
      {super.key,
      required super.progress,
      this.rounded = true,
      this.isThin = false,
      this.label,})
      : type = ZetaBarType.indeterminate;

  /// Is progress bar rounded or sharp.
  final bool rounded;

  /// Type of the progress bar.
  final ZetaBarType type;

  /// Is Progress bar thin or thick.
  final bool isThin;

  ///Optional label
  final String? label;

  @override
  State<ZetaProgressBar> createState() => _ZetaProgressBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('rounded', rounded))
      ..add(EnumProperty<ZetaBarType>('type', type))
      ..add(StringProperty('label', label))
      ..add(DiagnosticsProperty<bool>('isThin', isThin));
  }
}

class _ZetaProgressBarState extends ZetaProgressState<ZetaProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          Text(
            widget.label!,
            textAlign: TextAlign.start,
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: _weight,
                child: LinearProgressIndicator(
                  borderRadius: _border,
                  value: widget.type == ZetaBarType.indeterminate ? null : animation.value,
                  backgroundColor: widget.type == ZetaBarType.buffering
                      ? Zeta.of(context).colors.surfaceDisabled
                      : Colors.transparent,
                ),
              ),
            ),
            _extraWidgets(),
          ],
        ),
      ],
    );
  }

  /// Returns border based on widgets border type.
  BorderRadius get _border => widget.rounded ? ZetaRadius.rounded : ZetaRadius.none;

  /// Returns thickness of progress bar based on its weight.
  double get _weight => widget.isThin ? 8 : 16;

  Widget _extraWidgets() {
    final Iterable<List<Widget>> extraList = List.filled(3, false).map((e) => [
          const SizedBox(
            width: 16,
          ),
          Container(
            width: _weight,
            height: _weight,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(224, 227, 233, 1),
                borderRadius: ZetaRadius.rounded,),
          ),
        ],);

    final Widget extraWidgets = Row(
      children: widget.type == ZetaBarType.buffering ? extraList.expand((list) => list).toList() : [],
    );
    return extraWidgets;
  }
}
