import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../zeta_flutter.dart';

/// The view mode for the year/month picker.
enum _PickerMode { year, month }

/// A year and month picker view used within the [ZetaCalendar].
///
/// First shows a scrollable grid of years, then after selecting a year
/// shows the 12 months to pick from.
class ZetaCalendarYearPicker extends StatefulWidget {
  /// Creates a [ZetaCalendarYearPicker].
  ZetaCalendarYearPicker({
    required this.currentYear,
    required this.currentMonth,
    required this.onMonthYearSelected,
    this.minDate,
    this.maxDate,
    super.key,
  }) : assert(
          minDate == null || maxDate == null || !minDate.isAfter(maxDate),
          'minDate must not be after maxDate',
        );

  /// The currently displayed year.
  final int currentYear;

  /// The currently displayed month (1-12).
  final int currentMonth;

  /// Called when a month/year combination is selected.
  final void Function(int year, int month) onMonthYearSelected;

  /// The minimum selectable date.
  final DateTime? minDate;

  /// The maximum selectable date.
  final DateTime? maxDate;

  @override
  State<ZetaCalendarYearPicker> createState() => _ZetaCalendarYearPickerState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('currentYear', currentYear))
      ..add(IntProperty('currentMonth', currentMonth))
      ..add(DiagnosticsProperty<DateTime?>('minDate', minDate))
      ..add(DiagnosticsProperty<DateTime?>('maxDate', maxDate))
      ..add(ObjectFlagProperty<void Function(int, int)>.has('onMonthYearSelected', onMonthYearSelected));
  }
}

class _ZetaCalendarYearPickerState extends State<ZetaCalendarYearPicker> {
  late _PickerMode _mode;
  late int _selectedYear;
  final GlobalKey _selectedYearKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _mode = _PickerMode.year;
    _selectedYear = widget.currentYear;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToCurrentYear());
  }

  Future<void> _scrollToCurrentYear() async {
    final ctx = _selectedYearKey.currentContext;
    if (ctx != null) {
      await Scrollable.ensureVisible(ctx, alignment: 0.4);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _mode == _PickerMode.year ? _buildYearGrid(context) : _buildMonthGrid(context);
  }

  Widget _buildYearGrid(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;
    final textStyles = zeta.textStyles;
    final spacing = zeta.spacing;

    final now = DateTime.now();
    final minYear = widget.minDate?.year ?? (now.year - 50);
    final maxYear = widget.maxDate?.year ?? (now.year + 50);
    final years = List.generate(maxYear - minYear + 1, (i) => minYear + i);

    return Padding(
      padding: EdgeInsets.all(spacing.small),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isSelected = year == _selectedYear;
          final isCurrent = year == now.year;

          return GestureDetector(
            key: isSelected ? _selectedYearKey : null,
            onTap: () {
              setState(() {
                _selectedYear = year;
                _mode = _PickerMode.month;
              });
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: isSelected ? colors.mainPrimary : null,
                borderRadius: BorderRadius.circular(8),
                border: isCurrent && !isSelected ? Border.all(color: colors.mainPrimary) : null,
              ),
              child: Center(
                child: Text(
                  '$year',
                  style: textStyles.bodyMedium.copyWith(
                    color: isSelected ? colors.surfaceDefault : colors.mainDefault,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMonthGrid(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;
    final textStyles = zeta.textStyles;
    final spacing = zeta.spacing;

    final monthFormat = DateFormat.MMM();
    final now = DateTime.now();

    return Padding(
      padding: EdgeInsets.all(spacing.small),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: spacing.medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _mode = _PickerMode.year),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(ZetaIcons.chevron_left, size: 16, color: colors.mainSubtle),
                      SizedBox(width: spacing.minimum),
                      Text(
                        '$_selectedYear',
                        style: textStyles.titleSmall.copyWith(color: colors.mainDefault),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final monthIndex = index + 1;
                final isSelected = _selectedYear == widget.currentYear && monthIndex == widget.currentMonth;
                final isCurrent = _selectedYear == now.year && monthIndex == now.month;

                bool isDisabled = false;
                if (widget.minDate != null) {
                  isDisabled = _selectedYear < widget.minDate!.year ||
                      (_selectedYear == widget.minDate!.year && monthIndex < widget.minDate!.month);
                }
                if (!isDisabled && widget.maxDate != null) {
                  isDisabled = _selectedYear > widget.maxDate!.year ||
                      (_selectedYear == widget.maxDate!.year && monthIndex > widget.maxDate!.month);
                }

                return GestureDetector(
                  onTap: isDisabled ? null : () => widget.onMonthYearSelected(_selectedYear, monthIndex),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: isSelected ? colors.mainPrimary : null,
                      borderRadius: BorderRadius.circular(8),
                      border: isCurrent && !isSelected ? Border.all(color: colors.mainPrimary) : null,
                    ),
                    child: Center(
                      child: Text(
                        monthFormat.format(DateTime(0, monthIndex)),
                        style: textStyles.bodyMedium.copyWith(
                          color: isDisabled
                              ? colors.mainDisabled
                              : isSelected
                                  ? colors.surfaceDefault
                                  : colors.mainDefault,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
