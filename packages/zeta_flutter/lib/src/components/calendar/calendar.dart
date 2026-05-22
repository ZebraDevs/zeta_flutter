import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'calendar_month.dart';
import 'calendar_year_picker.dart';

/// An inline calendar widget with date range selection.
///
/// Displays consecutive months side by side. The number of visible months is
/// controlled by [visibleMonthCount] (1–3, defaults to 2). Users can select a
/// date range by tapping a start date and an end date. Navigation arrows on
/// the first and last months allow scrolling, and tapping the month/year
/// header opens a year/month picker.
///
/// The footer provides Reset, Cancel, and Apply actions.
class ZetaCalendar extends ZetaStatefulWidget {
  /// Creates a [ZetaCalendar].
  ZetaCalendar({
    super.key,
    super.rounded,
    this.visibleMonthCount = 2,
    this.initialStartDate,
    this.initialEndDate,
    this.minDate,
    this.maxDate,
    this.onRangeChanged,
    this.onApply,
    this.onCancel,
    this.onReset,
  })  : assert(
          minDate == null || maxDate == null || !minDate.isAfter(maxDate),
          'minDate must not be after maxDate',
        ),
        assert(
          initialStartDate == null || initialEndDate == null || !initialStartDate.isAfter(initialEndDate),
          'initialStartDate must not be after initialEndDate',
        ),
        assert(
          initialStartDate == null || minDate == null || !initialStartDate.isBefore(minDate),
          'initialStartDate must not be before minDate',
        ),
        assert(
          initialEndDate == null || maxDate == null || !initialEndDate.isAfter(maxDate),
          'initialEndDate must not be after maxDate',
        );

  /// The number of consecutive months to display side by side.
  ///
  /// Accepted values are **1**, **2**, or **3**:
  /// - `1` — shows a single month.
  /// - `2` — shows two consecutive months (default).
  /// - `3` — shows three consecutive months.
  ///
  /// If a value outside the 1–3 range is provided, it is automatically
  /// clamped to the nearest bound (e.g. `0` becomes `1`, `5` becomes `3`).
  final int visibleMonthCount;

  /// The initial start date of the selected range.
  final DateTime? initialStartDate;

  /// The initial end date of the selected range.
  final DateTime? initialEndDate;

  /// The minimum selectable date.
  final DateTime? minDate;

  /// The maximum selectable date.
  final DateTime? maxDate;

  /// Called whenever the selected range changes.
  ///
  /// Receives a [DateTimeRange] when both start and end dates are selected,
  /// or `null` when the selection is incomplete (only a start date picked)
  /// or cleared (via reset). Use [onReset] to distinguish a deliberate clear
  /// from an in-progress selection.
  final ValueChanged<DateTimeRange?>? onRangeChanged;

  /// Called when the Apply button is pressed with the current range.
  final ValueChanged<DateTimeRange?>? onApply;

  /// Called when the Cancel button is pressed.
  final VoidCallback? onCancel;

  /// Called when the Reset button is pressed.
  final VoidCallback? onReset;

  @override
  State<ZetaCalendar> createState() => _ZetaCalendarState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('visibleMonthCount', visibleMonthCount))
      ..add(DiagnosticsProperty<DateTime?>('initialStartDate', initialStartDate))
      ..add(DiagnosticsProperty<DateTime?>('initialEndDate', initialEndDate))
      ..add(DiagnosticsProperty<DateTime?>('minDate', minDate))
      ..add(DiagnosticsProperty<DateTime?>('maxDate', maxDate))
      ..add(ObjectFlagProperty<ValueChanged<DateTimeRange?>?>.has('onRangeChanged', onRangeChanged))
      ..add(ObjectFlagProperty<ValueChanged<DateTimeRange?>?>.has('onApply', onApply))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onCancel', onCancel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onReset', onReset));
  }
}

class _ZetaCalendarState extends State<ZetaCalendar> {
  late int _leftMonth;
  late int _leftYear;
  DateTime? _startDate;
  DateTime? _endDate;
  bool _showYearPicker = false;

  int get _monthCount => widget.visibleMonthCount.clamp(1, 3);

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;

    final referenceDate = _startDate ?? DateTime.now();
    _leftMonth = referenceDate.month;
    _leftYear = referenceDate.year;
  }

  @override
  void didUpdateWidget(covariant ZetaCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStartDate != widget.initialStartDate) {
      _startDate = widget.initialStartDate;
    }
    if (oldWidget.initialEndDate != widget.initialEndDate) {
      _endDate = widget.initialEndDate;
    }
    if (oldWidget.initialStartDate != widget.initialStartDate || oldWidget.initialEndDate != widget.initialEndDate) {
      final referenceDate = _startDate ?? DateTime.now();
      _leftMonth = referenceDate.month;
      _leftYear = referenceDate.year;
    }
  }

  /// Returns the (year, month) for the month at [offset] positions after the leftmost month.
  ({int year, int month}) _monthAt(int offset) {
    var m = _leftMonth + offset;
    var y = _leftYear;
    while (m > 12) {
      m -= 12;
      y++;
    }
    return (year: y, month: m);
  }

  void _goToPreviousMonth() {
    setState(() {
      if (_leftMonth == 1) {
        _leftMonth = 12;
        _leftYear--;
      } else {
        _leftMonth--;
      }
    });
  }

  void _goToNextMonth() {
    setState(() {
      if (_leftMonth == 12) {
        _leftMonth = 1;
        _leftYear++;
      } else {
        _leftMonth++;
      }
    });
  }

  void _onDayTap(DateTime date) {
    setState(() {
      if (_startDate == null || (_startDate != null && _endDate != null)) {
        _startDate = date;
        _endDate = null;
      } else {
        if (date.isBefore(_startDate!)) {
          _endDate = _startDate;
          _startDate = date;
        } else if (date.isAtSameMomentAs(_startDate!)) {
          _startDate = null;
        } else {
          _endDate = date;
        }
      }
    });

    final range = _startDate != null && _endDate != null ? DateTimeRange(start: _startDate!, end: _endDate!) : null;
    widget.onRangeChanged?.call(range);
  }

  void _onHeaderTap() {
    setState(() {
      _showYearPicker = true;
    });
  }

  void _onMonthYearSelected(int year, int month) {
    setState(() {
      _leftYear = year;
      _leftMonth = month;
      _showYearPicker = false;
    });
  }

  void _onReset() {
    setState(() {
      _startDate = null;
      _endDate = null;
    });
    widget.onRangeChanged?.call(null);
    widget.onReset?.call();
  }

  void _onApply() {
    final range = _startDate != null && _endDate != null ? DateTimeRange(start: _startDate!, end: _endDate!) : null;
    widget.onApply?.call(range);
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;
    final spacing = zeta.spacing;
    final rounded = context.rounded;

    if (_showYearPicker) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceDefault,
          borderRadius: BorderRadius.all(rounded ? zeta.radius.rounded : zeta.radius.none),
          border: Border.all(color: colors.borderSubtle, width: ZetaBorders.small),
        ),
        child: SizedBox(
          height: 360,
          child: ZetaCalendarYearPicker(
            currentYear: _leftYear,
            currentMonth: _leftMonth,
            minDate: widget.minDate,
            maxDate: widget.maxDate,
            onMonthYearSelected: _onMonthYearSelected,
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceDefault,
        borderRadius: BorderRadius.all(rounded ? zeta.radius.rounded : zeta.radius.none),
        border: Border.all(color: colors.borderSubtle, width: ZetaBorders.small),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.large),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 280.0 * _monthCount + spacing.large * (_monthCount - 1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i = 0; i < _monthCount; i++) ...[
                      if (i > 0) SizedBox(width: spacing.large),
                      SizedBox(
                        width: 280,
                        child: ZetaCalendarMonth(
                          month: _monthAt(i).month,
                          year: _monthAt(i).year,
                          startDate: _startDate,
                          endDate: _endDate,
                          minDate: widget.minDate,
                          maxDate: widget.maxDate,
                          onDayTap: _onDayTap,
                          onHeaderTap: _onHeaderTap,
                          leadingIcon: i == 0
                              ? ZetaIconButton.text(
                                  icon: ZetaIcons.chevron_left,
                                  size: ZetaWidgetSize.small,
                                  onPressed: _goToPreviousMonth,
                                  semanticLabel: 'Previous month',
                                )
                              : null,
                          trailingIcon: i == _monthCount - 1
                              ? ZetaIconButton.text(
                                  icon: ZetaIcons.chevron_right,
                                  size: ZetaWidgetSize.small,
                                  onPressed: _goToNextMonth,
                                  semanticLabel: 'Next month',
                                )
                              : null,
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: spacing.large),
                Divider(height: 1, color: colors.borderSubtle),
                SizedBox(height: spacing.medium),
                Row(
                  children: [
                    ZetaButton.text(
                      label: 'Reset',
                      size: ZetaWidgetSize.small,
                      onPressed: _onReset,
                    ),
                    const Spacer(),
                    ZetaButton.outline(
                      label: 'Cancel',
                      size: ZetaWidgetSize.small,
                      onPressed: widget.onCancel,
                    ),
                    SizedBox(width: spacing.small),
                    ZetaButton.primary(
                      label: 'Apply',
                      size: ZetaWidgetSize.small,
                      onPressed: _onApply,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('leftMonth', _leftMonth))
      ..add(IntProperty('leftYear', _leftYear))
      ..add(DiagnosticsProperty<DateTime?>('startDate', _startDate))
      ..add(DiagnosticsProperty<DateTime?>('endDate', _endDate))
      ..add(DiagnosticsProperty<bool>('showYearPicker', _showYearPicker));
  }
}
