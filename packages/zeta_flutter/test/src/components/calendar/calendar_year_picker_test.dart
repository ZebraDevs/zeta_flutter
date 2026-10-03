import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/calendar/calendar_year_picker.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  group('ZetaCalendarYearPicker', () {
    group('Year grid', () {
      testWidgets('renders year grid initially', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2024),
                maxDate: DateTime(2028, 12, 31),
                onMonthYearSelected: (_, __) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(GridView), findsOneWidget);
        expect(find.text('2026'), findsOneWidget);
      });

      testWidgets('renders all years within min/max bounds', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2024),
                maxDate: DateTime(2028, 12, 31),
                onMonthYearSelected: (_, __) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.text('2024'), findsOneWidget);
        expect(find.text('2025'), findsOneWidget);
        expect(find.text('2026'), findsOneWidget);
        expect(find.text('2027'), findsOneWidget);
        expect(find.text('2028'), findsOneWidget);
      });

      testWidgets('renders without min/max (defaults to wide range)', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                onMonthYearSelected: (_, __) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.byType(GridView), findsOneWidget);
      });
    });

    group('Year to month transition', () {
      testWidgets('tapping a year shows month grid', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2024),
                maxDate: DateTime(2028, 12, 31),
                onMonthYearSelected: (_, __) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('2026'));
        await tester.pumpAndSettle();

        expect(find.text('Jan'), findsOneWidget);
        expect(find.text('Jun'), findsOneWidget);
        expect(find.text('Dec'), findsOneWidget);
      });

      testWidgets("tapping a different year switches to that year's months", (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2024),
                maxDate: DateTime(2028, 12, 31),
                onMonthYearSelected: (_, __) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('2027'));
        await tester.pumpAndSettle();

        expect(find.text('2027'), findsOneWidget);
        expect(find.text('Jan'), findsOneWidget);
      });
    });

    group('Month selection', () {
      testWidgets('tapping a month calls onMonthYearSelected', (tester) async {
        int? selectedYear;
        int? selectedMonth;

        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2024),
                maxDate: DateTime(2028, 12, 31),
                onMonthYearSelected: (year, month) {
                  selectedYear = year;
                  selectedMonth = month;
                },
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('2026'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Mar'));
        await tester.pumpAndSettle();

        expect(selectedYear, 2026);
        expect(selectedMonth, 3);
      });
    });

    group('Back navigation', () {
      testWidgets('back arrow in month view returns to year grid', (tester) async {
        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2024),
                maxDate: DateTime(2028, 12, 31),
                onMonthYearSelected: (_, __) {},
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // Go to month grid
        await tester.tap(find.text('2026'));
        await tester.pumpAndSettle();

        expect(find.text('Jan'), findsOneWidget);

        // Tap back (the chevron+year header acts as back button)
        await tester.tap(find.byIcon(ZetaIcons.chevron_left));
        await tester.pumpAndSettle();

        // Should be back in year grid
        expect(find.text('Jan'), findsNothing);
        expect(find.byType(GridView), findsOneWidget);
      });
    });

    group('Min/max month constraints', () {
      testWidgets('months before minDate are disabled', (tester) async {
        int? selectedMonth;

        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2026, 4),
                maxDate: DateTime(2026, 9, 30),
                onMonthYearSelected: (_, month) => selectedMonth = month,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('2026'));
        await tester.pumpAndSettle();

        // Tap Jan (disabled, before minDate month 4)
        await tester.tap(find.text('Jan'));
        await tester.pumpAndSettle();

        expect(selectedMonth, isNull);

        // Tap May (enabled)
        await tester.tap(find.text('May'));
        await tester.pumpAndSettle();

        expect(selectedMonth, 5);
      });

      testWidgets('months after maxDate are disabled', (tester) async {
        int? selectedMonth;

        await tester.pumpWidget(
          TestApp(
            home: SizedBox(
              height: 360,
              child: ZetaCalendarYearPicker(
                currentYear: 2026,
                currentMonth: 6,
                minDate: DateTime(2026, 4),
                maxDate: DateTime(2026, 9, 30),
                onMonthYearSelected: (_, month) => selectedMonth = month,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('2026'));
        await tester.pumpAndSettle();

        // Tap Nov (disabled, after maxDate month 9)
        await tester.tap(find.text('Nov'));
        await tester.pumpAndSettle();

        expect(selectedMonth, isNull);
      });
    });

    group('Constructor assert', () {
      test('asserts minDate is not after maxDate', () {
        expect(
          () => ZetaCalendarYearPicker(
            currentYear: 2026,
            currentMonth: 6,
            minDate: DateTime(2028),
            maxDate: DateTime(2024, 12, 31),
            onMonthYearSelected: (_, __) {},
          ),
          throwsAssertionError,
        );
      });

      test('valid min/max does not throw', () {
        expect(
          () => ZetaCalendarYearPicker(
            currentYear: 2026,
            currentMonth: 6,
            minDate: DateTime(2024),
            maxDate: DateTime(2028, 12, 31),
            onMonthYearSelected: (_, __) {},
          ),
          returnsNormally,
        );
      });
    });

    group('debugFillProperties', () {
      debugFillPropertiesTest(
        ZetaCalendarYearPicker(
          currentYear: 2026,
          currentMonth: 6,
          minDate: DateTime(2024),
          maxDate: DateTime(2028, 12, 31),
          onMonthYearSelected: (_, __) {},
        ),
        {
          'currentYear': '2026',
          'currentMonth': '6',
          'minDate': DateTime(2024).toString(),
          'maxDate': DateTime(2028, 12, 31).toString(),
        },
      );
    });
  });
}
