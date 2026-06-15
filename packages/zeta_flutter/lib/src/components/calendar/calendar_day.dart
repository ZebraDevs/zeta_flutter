import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../zeta_flutter.dart';

/// The visual state of a day cell in the calendar.
enum ZetaCalendarDayState {
  /// Default state — the day is selectable.
  enabled,

  /// The day is the start of a selected range.
  startRange,

  /// The day is the end of a selected range.
  endRange,

  /// The day falls between the start and end of the range.
  inRange,

  /// The day cannot be selected (outside min/max bounds or overflow day).
  disabled,

  /// The day is today but not selected.
  today,
}

/// A single day cell in the [ZetaCalendar] grid.
class ZetaCalendarDay extends StatelessWidget {
  /// Creates a [ZetaCalendarDay].
  const ZetaCalendarDay({
    required this.day,
    required this.state,
    this.date,
    this.onTap,
    super.key,
  });

  /// The day number to display.
  final int day;

  /// The visual state of this day cell.
  final ZetaCalendarDayState state;

  /// The full date this cell represents, used for accessibility labels.
  final DateTime? date;

  /// Called when this day is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;
    final textStyles = zeta.textStyles;

    final isDisabled = state == ZetaCalendarDayState.disabled;
    final isStart = state == ZetaCalendarDayState.startRange;
    final isEnd = state == ZetaCalendarDayState.endRange;
    final isInRange = state == ZetaCalendarDayState.inRange;
    final isToday = state == ZetaCalendarDayState.today;
    final isSelected = isStart || isEnd;

    Color textColor;
    Color? circleColor;
    Color? backgroundColor;
    BoxDecoration? rowDecoration;

    if (isDisabled) {
      textColor = colors.mainDisabled;
    } else if (isSelected) {
      textColor = colors.surfaceDefault;
      circleColor = colors.mainPrimary;
    } else if (isInRange) {
      textColor = colors.mainDefault;
      backgroundColor = colors.surfaceSelected;
    } else if (isToday) {
      textColor = colors.mainPrimary;
    } else {
      textColor = colors.mainDefault;
    }

    if (isStart) {
      rowDecoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, colors.surfaceSelected],
          stops: const [0.5, 0.5],
        ),
      );
    } else if (isEnd) {
      rowDecoration = BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.surfaceSelected, Colors.transparent],
          stops: const [0.5, 0.5],
        ),
      );
    }

    Widget dayWidget = Center(
      child: Text(
        '$day',
        style: textStyles.bodySmall.copyWith(color: textColor),
      ),
    );

    if (circleColor != null) {
      dayWidget = DecoratedBox(
        decoration: BoxDecoration(
          color: circleColor,
          shape: BoxShape.circle,
        ),
        child: dayWidget,
      );
    } else if (isToday) {
      dayWidget = DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colors.mainPrimary),
        ),
        child: dayWidget,
      );
    } else if (backgroundColor != null) {
      dayWidget = ColoredBox(
        color: backgroundColor,
        child: dayWidget,
      );
    }

    if (rowDecoration != null) {
      dayWidget = DecoratedBox(
        decoration: rowDecoration,
        child: DecoratedBox(
          decoration:
              circleColor != null ? BoxDecoration(color: circleColor, shape: BoxShape.circle) : const BoxDecoration(),
          child: Center(
            child: Text(
              '$day',
              style: textStyles.bodySmall.copyWith(color: textColor),
            ),
          ),
        ),
      );
    }

    String? semanticLabel;
    if (date != null) {
      final formattedDate = DateFormat.yMMMMd().format(date!);
      final stateDesc = switch (state) {
        ZetaCalendarDayState.startRange => ', start of range',
        ZetaCalendarDayState.endRange => ', end of range',
        ZetaCalendarDayState.inRange => ', in range',
        ZetaCalendarDayState.today => ', today',
        ZetaCalendarDayState.disabled => ', disabled',
        ZetaCalendarDayState.enabled => '',
      };
      semanticLabel = '$formattedDate$stateDesc';
    }

    return Semantics(
      button: !isDisabled,
      enabled: !isDisabled,
      selected: isSelected,
      label: semanticLabel,
      excludeSemantics: true,
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          width: 40,
          height: 40,
          child: dayWidget,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('day', day))
      ..add(EnumProperty<ZetaCalendarDayState>('state', state))
      ..add(DiagnosticsProperty<DateTime?>('date', date))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
  }
}
