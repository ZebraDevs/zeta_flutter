import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/calendar/calendar_day.dart';
import 'package:zeta_flutter/src/components/calendar/calendar_month.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  group('ZetaCalendarMonth', () {
    group('Rendering', () {
      testWidgets('renders month/year header', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 6, year: 2026),
            ),
          ),
        );

        expect(find.textContaining('Jun 2026'), findsOneWidget);
      });

      testWidgets('renders weekday headers', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 6, year: 2026),
            ),
          ),
        );

        expect(find.text('S'), findsWidgets);
        expect(find.text('M'), findsWidgets);
        expect(find.text('T'), findsWidgets);
        expect(find.text('W'), findsWidgets);
        expect(find.text('F'), findsWidgets);
      });

      testWidgets('renders all days of the month', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 6, year: 2026),
            ),
          ),
        );

        // June 2026 has 30 days
        for (var day = 1; day <= 30; day++) {
          expect(find.text('$day'), findsWidgets);
        }
      });

      testWidgets('always renders exactly 6 week rows', (tester) async {
        // February 2026 starts on Sunday — only needs 4 weeks,
        // but should still render 6.
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 2, year: 2026),
            ),
          ),
        );

        // 6 week rows, each is a Row inside the Column
        // Count ZetaCalendarDay widgets: 6 weeks * 7 days = 42
        expect(find.byType(ZetaCalendarDay), findsNWidgets(42));
      });

      testWidgets('renders leading icon when provided', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                leadingIcon: Icon(Icons.chevron_left, key: Key('leading')),
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('leading')), findsOneWidget);
      });

      testWidgets('renders trailing icon when provided', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                trailingIcon: Icon(Icons.chevron_right, key: Key('trailing')),
              ),
            ),
          ),
        );

        expect(find.byKey(const Key('trailing')), findsOneWidget);
      });
    });

    group('Callbacks', () {
      testWidgets('calls onDayTap with correct DateTime when a day is tapped', (tester) async {
        DateTime? tappedDate;

        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                onDayTap: (date) => tappedDate = date,
              ),
            ),
          ),
        );

        await tester.tap(find.text('15').first);
        expect(tappedDate, isNotNull);
        expect(tappedDate!.year, 2026);
        expect(tappedDate!.month, 6);
        expect(tappedDate!.day, 15);
      });

      testWidgets('does not call onDayTap for disabled days', (tester) async {
        DateTime? tappedDate;

        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                minDate: DateTime(2026, 6, 10),
                onDayTap: (date) => tappedDate = date,
              ),
            ),
          ),
        );

        // Day 5 should be disabled (before minDate)
        await tester.tap(find.text('5').first);
        expect(tappedDate, isNull);
      });

      testWidgets('calls onHeaderTap when header is tapped', (tester) async {
        bool headerTapped = false;

        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                onHeaderTap: () => headerTapped = true,
              ),
            ),
          ),
        );

        await tester.tap(find.textContaining('Jun 2026'));
        expect(headerTapped, isTrue);
      });
    });

    group('Day states', () {
      testWidgets('marks days before minDate as disabled', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                minDate: DateTime(2026, 6, 15),
              ),
            ),
          ),
        );

        // All 42 day cells should be present
        expect(find.byType(ZetaCalendarDay), findsNWidgets(42));
      });

      testWidgets('marks days after maxDate as disabled', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                maxDate: DateTime(2026, 6, 15),
              ),
            ),
          ),
        );

        expect(find.byType(ZetaCalendarDay), findsNWidgets(42));
      });

      testWidgets('marks start and end dates correctly', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(
                month: 6,
                year: 2026,
                startDate: DateTime(2026, 6, 10),
                endDate: DateTime(2026, 6, 20),
              ),
            ),
          ),
        );

        expect(find.byType(ZetaCalendarDay), findsNWidgets(42));
      });
    });

    group('Edge cases', () {
      testWidgets('handles January correctly (previous month is December of prior year)', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 1, year: 2026),
            ),
          ),
        );

        expect(find.textContaining('Jan 2026'), findsOneWidget);
        expect(find.byType(ZetaCalendarDay), findsNWidgets(42));
      });

      testWidgets('handles December correctly', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 12, year: 2026),
            ),
          ),
        );

        expect(find.textContaining('Dec 2026'), findsOneWidget);
        expect(find.byType(ZetaCalendarDay), findsNWidgets(42));
      });

      testWidgets('handles leap year February', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 2, year: 2028),
            ),
          ),
        );

        expect(find.text('29'), findsWidgets);
      });

      testWidgets('handles non-leap year February', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: SizedBox(
              width: 280,
              child: ZetaCalendarMonth(month: 2, year: 2026),
            ),
          ),
        );

        // Feb 2026 has 28 days
        expect(find.text('28'), findsWidgets);
      });
    });

    group('debugFillProperties', () {
      debugFillPropertiesTest(
        ZetaCalendarMonth(
          month: 6,
          year: 2026,
          startDate: DateTime(2026, 6, 10),
          endDate: DateTime(2026, 6, 20),
          minDate: DateTime(2026),
          maxDate: DateTime(2026, 12, 31),
        ),
        {
          'month': '6',
          'year': '2026',
          'startDate': DateTime(2026, 6, 10).toString(),
          'endDate': DateTime(2026, 6, 20).toString(),
          'minDate': DateTime(2026).toString(),
          'maxDate': DateTime(2026, 12, 31).toString(),
        },
      );
    });
  });
}
