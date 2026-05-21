import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'calendar_month.dart';
import 'calendar_year_picker.dart';

/// A dual-month inline calendar widget with date range selection.
///
/// Displays two consecutive months side by side. Users can select a date range
/// by tapping a start date and an end date. Navigation arrows allow scrolling
/// through months, and tapping the month/year header opens a year/month picker.
///
/// The footer provides Reset, Cancel, and Apply actions.
class ZetaCalendar extends ZetaStatefulWidget {
  /// Creates a [ZetaCalendar].
  const ZetaCalendar({
    super.key,
    super.rounded,
    this.initialStartDate,
    this.initialEndDate,
    this.minDate,
    this.maxDate,
    this.onRangeChanged,
    this.onApply,
    this.onCancel,
    this.onReset,
  });

  /// The initial start date of the selected range.
  final DateTime? initialStartDate;

  /// The initial end date of the selected range.
  final DateTime? initialEndDate;

  /// The minimum selectable date.
  final DateTime? minDate;

  /// The maximum selectable date.
  final DateTime? maxDate;

  /// Called whenever the selected range changes.
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

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;

    final referenceDate = _startDate ?? DateTime.now();
    _leftMonth = referenceDate.month;
    _leftYear = referenceDate.year;
  }

  int get _rightMonth => _leftMonth == 12 ? 1 : _leftMonth + 1;
  int get _rightYear => _leftMonth == 12 ? _leftYear + 1 : _leftYear;

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
    final textStyles = zeta.textStyles;
    final spacing = zeta.spacing;
    final rounded = widget.rounded ?? zeta.rounded;

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Dual month view — horizontally scrollable for narrow screens
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 280,
                      child: ZetaCalendarMonth(
                        month: _leftMonth,
                        year: _leftYear,
                        startDate: _startDate,
                        endDate: _endDate,
                        minDate: widget.minDate,
                        maxDate: widget.maxDate,
                        onDayTap: _onDayTap,
                        onHeaderTap: _onHeaderTap,
                        leadingIcon: GestureDetector(
                          onTap: _goToPreviousMonth,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.all(spacing.small),
                            child: Icon(
                              ZetaIcons.chevron_left,
                              size: 20,
                              color: colors.mainDefault,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: spacing.large),
                    SizedBox(
                      width: 280,
                      child: ZetaCalendarMonth(
                        month: _rightMonth,
                        year: _rightYear,
                        startDate: _startDate,
                        endDate: _endDate,
                        minDate: widget.minDate,
                        maxDate: widget.maxDate,
                        onDayTap: _onDayTap,
                        onHeaderTap: _onHeaderTap,
                        trailingIcon: GestureDetector(
                          onTap: _goToNextMonth,
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: EdgeInsets.all(spacing.small),
                            child: Icon(
                              ZetaIcons.chevron_right,
                              size: 20,
                              color: colors.mainDefault,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spacing.large),
            // Footer
            Divider(height: 1, color: colors.borderSubtle),
            SizedBox(height: spacing.medium),
            Row(
              children: [
                GestureDetector(
                  onTap: _onReset,
                  behavior: HitTestBehavior.opaque,
                  child: Text(
                    'Reset',
                    style: textStyles.labelLarge.copyWith(color: colors.mainPrimary),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: widget.onCancel,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.large,
                      vertical: spacing.small,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(rounded ? zeta.radius.rounded : zeta.radius.none),
                      border: Border.all(color: colors.borderDefault),
                    ),
                    child: Text(
                      'Cancel',
                      style: textStyles.labelLarge.copyWith(color: colors.mainDefault),
                    ),
                  ),
                ),
                SizedBox(width: spacing.small),
                GestureDetector(
                  onTap: _onApply,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.large,
                      vertical: spacing.small,
                    ),
                    decoration: BoxDecoration(
                      color: colors.mainPrimary,
                      borderRadius: BorderRadius.all(rounded ? zeta.radius.rounded : zeta.radius.none),
                    ),
                    child: Text(
                      'Apply',
                      style: textStyles.labelLarge.copyWith(color: colors.surfaceDefault),
                    ),
                  ),
                ),
              ],
            ),
          ],
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
