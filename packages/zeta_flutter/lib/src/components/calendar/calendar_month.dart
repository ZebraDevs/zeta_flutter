import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../zeta_flutter.dart';
import 'calendar_day.dart';

/// A single month grid displayed within the [ZetaCalendar].
///
/// Shows a month/year header and a 7-column grid of day cells.
class ZetaCalendarMonth extends StatelessWidget {
  /// Creates a [ZetaCalendarMonth].
  const ZetaCalendarMonth({
    required this.month,
    required this.year,
    this.startDate,
    this.endDate,
    this.minDate,
    this.maxDate,
    this.onDayTap,
    this.onHeaderTap,
    this.leadingIcon,
    this.trailingIcon,
    super.key,
  });

  /// The month to display (1-12).
  final int month;

  /// The year to display.
  final int year;

  /// The start date of the selected range.
  final DateTime? startDate;

  /// The end date of the selected range.
  final DateTime? endDate;

  /// The minimum selectable date.
  final DateTime? minDate;

  /// The maximum selectable date.
  final DateTime? maxDate;

  /// Called when a day is tapped with the full [DateTime].
  final ValueChanged<DateTime>? onDayTap;

  /// Called when the month/year header is tapped.
  final VoidCallback? onHeaderTap;

  /// An optional leading widget displayed before the month/year header (e.g., a back arrow).
  final Widget? leadingIcon;

  /// An optional trailing widget displayed after the month/year header (e.g., a forward arrow).
  final Widget? trailingIcon;

  static const List<String> _weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  int _firstWeekdayOfMonth(int year, int month) {
    return DateTime(year, month).weekday % 7;
  }

  ZetaCalendarDayState _stateForDay(DateTime date) {
    if (minDate != null && date.isBefore(minDate!)) {
      return ZetaCalendarDayState.disabled;
    }
    if (maxDate != null && date.isAfter(maxDate!)) {
      return ZetaCalendarDayState.disabled;
    }

    final start = startDate;
    final end = endDate;

    if (start != null && _isSameDay(date, start)) {
      return ZetaCalendarDayState.startRange;
    }
    if (end != null && _isSameDay(date, end)) {
      return ZetaCalendarDayState.endRange;
    }
    if (start != null && end != null && date.isAfter(start) && date.isBefore(end)) {
      return ZetaCalendarDayState.inRange;
    }

    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return ZetaCalendarDayState.today;
    }

    return ZetaCalendarDayState.enabled;
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;
    final textStyles = zeta.textStyles;
    final spacing = zeta.spacing;

    final daysInMonth = _daysInMonth(year, month);
    final firstWeekday = _firstWeekdayOfMonth(year, month);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Month/Year header with optional navigation icons
        Padding(
          padding: EdgeInsets.symmetric(vertical: spacing.small),
          child: Row(
            children: [
              if (leadingIcon != null) leadingIcon!,
              Expanded(
                child: GestureDetector(
                  onTap: onHeaderTap,
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: Text(
                      '${_monthName(month)} $year',
                      style: textStyles.titleSmall.copyWith(color: colors.mainDefault),
                    ),
                  ),
                ),
              ),
              if (trailingIcon != null) trailingIcon!,
            ],
          ),
        ),
        SizedBox(height: spacing.small),
        // Weekday headers
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _weekDays
              .map(
                (day) => SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      day,
                      style: textStyles.bodySmall.copyWith(color: colors.mainSubtle),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: spacing.minimum),
        // Day grid
        ..._buildWeeks(daysInMonth, firstWeekday, colors),
      ],
    );
  }

  List<Widget> _buildWeeks(int daysInMonth, int firstWeekday, ZetaColors colors) {
    final weeks = <Widget>[];
    var dayCounter = 1;

    // Previous month overflow days
    final prevMonthDays = _daysInMonth(
      month == 1 ? year - 1 : year,
      month == 1 ? 12 : month - 1,
    );

    for (var week = 0; week < 6; week++) {
      if (dayCounter > daysInMonth && week > 0) break;

      final days = <Widget>[];
      for (var weekday = 0; weekday < 7; weekday++) {
        final cellIndex = week * 7 + weekday;
        if (cellIndex < firstWeekday) {
          // Previous month overflow
          final overflowDay = prevMonthDays - (firstWeekday - cellIndex - 1);
          days.add(
            ZetaCalendarDay(
              day: overflowDay,
              state: ZetaCalendarDayState.disabled,
            ),
          );
        } else if (dayCounter > daysInMonth) {
          // Next month overflow
          final overflowDay = dayCounter - daysInMonth;
          dayCounter++;
          days.add(
            ZetaCalendarDay(
              day: overflowDay,
              state: ZetaCalendarDayState.disabled,
            ),
          );
        } else {
          final date = DateTime(year, month, dayCounter);
          final state = _stateForDay(date);
          final currentDay = dayCounter;
          days.add(
            ZetaCalendarDay(
              day: currentDay,
              state: state,
              onTap: state != ZetaCalendarDayState.disabled ? () => onDayTap?.call(date) : null,
            ),
          );
          dayCounter++;
        }
      }

      weeks.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: days,
        ),
      );
    }

    return weeks;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('month', month))
      ..add(IntProperty('year', year))
      ..add(DiagnosticsProperty<DateTime?>('startDate', startDate))
      ..add(DiagnosticsProperty<DateTime?>('endDate', endDate))
      ..add(DiagnosticsProperty<DateTime?>('minDate', minDate))
      ..add(DiagnosticsProperty<DateTime?>('maxDate', maxDate))
      ..add(ObjectFlagProperty<ValueChanged<DateTime>?>.has('onDayTap', onDayTap))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onHeaderTap', onHeaderTap))
      ..add(DiagnosticsProperty<Widget?>('leadingIcon', leadingIcon))
      ..add(DiagnosticsProperty<Widget?>('trailingIcon', trailingIcon));
  }
}
