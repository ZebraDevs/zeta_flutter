import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../zeta_flutter.dart';
import 'progress.dart';

/// Enum for types of progress bar
enum BarType {
  /// Standard bar type.
  standard,

  /// Indeterminate bar type. positions randomly
  indeterminate,

  /// Buffering bar type. Has buffering at end.
  buffering
}

/// BarWeight of progress bar
enum BarWeight {
  /// Thin weight.
  thin,

  ///Medium weight
  medium
}

/// Linear progress bar.
/// Uses progress percentage value to fill bar
class ProgressBar extends Progress {
  ///Constructor for [ProgressBar]

  const ProgressBar(
      {super.key,
      required super.progress,
      required this.border,
      required this.type,
      required this.weight,
      this.label});

  /// Constructs a standard progress bar
  const ProgressBar.standard(
      {super.key,
      required super.progress,
      this.border = ZetaWidgetBorder.rounded,
      this.type = BarType.standard,
      this.weight = BarWeight.medium,
      this.label});

  /// Constructs buffering example
  const ProgressBar.buffering(
      {super.key,
      required super.progress,
      this.border = ZetaWidgetBorder.rounded,
      this.type = BarType.buffering,
      this.weight = BarWeight.medium,
      this.label});

  /// Constructs indeterminate example
  const ProgressBar.indeterminate(
      {super.key,
      required super.progress,
      this.border = ZetaWidgetBorder.rounded,
      this.type = BarType.indeterminate,
      this.weight = BarWeight.medium,
      this.label});

  /// Border type of the progress bar.
  final ZetaWidgetBorder border;

  /// Type of the progress bar.
  final BarType type;

  /// Weight of progress bar to determine its thickness.
  final BarWeight weight;

  ///Optional label
  final String? label;

  @override
  _ProgressBarState createState() => _ProgressBarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<ZetaWidgetBorder>('border', border))
      ..add(EnumProperty<BarType>('type', type))
      ..add(EnumProperty<BarWeight>('weight', weight))
      ..add(StringProperty('label', label));
  }
}

class _ProgressBarState extends ProgressState<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null)
          SizedBox(
            child: Text(
              widget.label!,
              textAlign: TextAlign.start,
            ),
          ),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: _weight(),
              child: LinearProgressIndicator(
                borderRadius: _border(),
                value: widget.type == BarType.indeterminate
                    ? null
                    : animation.value,
                backgroundColor: widget.type == BarType.buffering
                    ? const Color.fromRGBO(224, 227, 233, 1)
                    : Colors.transparent,
              ),
            ),
          ),
          _extraWidgets(),
        ])
      ],
    );
  }

  /// Returns border based on widgets border type.
  BorderRadius _border() {
    return BorderRadius.all(widget.border == ZetaWidgetBorder.rounded
        ? const Radius.circular(12)
        : Radius.zero);
  }

  /// Returns thickness of progress bar based on its weight.
  double _weight() {
    switch (widget.weight) {
      case BarWeight.medium:
        return 16;
      case BarWeight.thin:
        return 8;
    }
  }

  Widget _extraWidgets() {
    final Iterable<List<Widget>> extraList = List.filled(3, false).map((e) => [
          const SizedBox(
            width: 16,
          ),
          Container(
            width: _weight(),
            height: _weight(),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(224, 227, 233, 1),
                borderRadius: ZetaRadius.rounded),
          ),
        ]);

    final Widget extraWidgets = Row(
      children: widget.type == BarType.buffering
          ? extraList.expand((list) => list).toList()
          : [],
    );
    return extraWidgets;
  }
}
