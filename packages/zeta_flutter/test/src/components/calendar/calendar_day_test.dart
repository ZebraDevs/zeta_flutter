import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/src/components/calendar/calendar_day.dart';

import '../../../test_utils/test_utils.dart';

void main() {
  group('ZetaCalendarDay', () {
    group('Rendering', () {
      testWidgets('renders day number', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(day: 15, state: ZetaCalendarDayState.enabled),
          ),
        );

        expect(find.text('15'), findsOneWidget);
      });

      testWidgets('renders with 40x40 size', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(day: 1, state: ZetaCalendarDayState.enabled),
          ),
        );

        final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).last);
        expect(sizedBox.width, 40);
        expect(sizedBox.height, 40);
      });

      testWidgets('renders each state without errors', (tester) async {
        for (final state in ZetaCalendarDayState.values) {
          await tester.pumpWidget(
            TestApp(
              home: ZetaCalendarDay(day: 5, state: state),
            ),
          );

          expect(find.text('5'), findsWidgets);
        }
      });

      testWidgets('renders startRange with gradient decoration', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(day: 10, state: ZetaCalendarDayState.startRange),
          ),
        );

        expect(find.text('10'), findsWidgets);
        expect(find.byType(DecoratedBox), findsWidgets);
      });

      testWidgets('renders endRange with gradient decoration', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(day: 20, state: ZetaCalendarDayState.endRange),
          ),
        );

        expect(find.text('20'), findsWidgets);
        expect(find.byType(DecoratedBox), findsWidgets);
      });

      testWidgets('renders inRange with background color', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(day: 15, state: ZetaCalendarDayState.inRange),
          ),
        );

        expect(find.text('15'), findsOneWidget);
        expect(find.byType(ColoredBox), findsWidgets);
      });

      testWidgets('renders today with border', (tester) async {
        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(day: 21, state: ZetaCalendarDayState.today),
          ),
        );

        expect(find.text('21'), findsOneWidget);
        expect(find.byType(DecoratedBox), findsWidgets);
      });
    });

    group('Tap behavior', () {
      testWidgets('calls onTap when enabled', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 10,
              state: ZetaCalendarDayState.enabled,
              onTap: () => tapped = true,
            ),
          ),
        );

        await tester.tap(find.text('10'));
        expect(tapped, isTrue);
      });

      testWidgets('does not call onTap when disabled', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 10,
              state: ZetaCalendarDayState.disabled,
              onTap: () => tapped = true,
            ),
          ),
        );

        await tester.tap(find.text('10'));
        expect(tapped, isFalse);
      });

      testWidgets('calls onTap for startRange state', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 10,
              state: ZetaCalendarDayState.startRange,
              onTap: () => tapped = true,
            ),
          ),
        );

        await tester.tap(find.text('10').first);
        expect(tapped, isTrue);
      });

      testWidgets('calls onTap for today state', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 10,
              state: ZetaCalendarDayState.today,
              onTap: () => tapped = true,
            ),
          ),
        );

        await tester.tap(find.text('10'));
        expect(tapped, isTrue);
      });

      testWidgets('calls onTap for inRange state', (tester) async {
        bool tapped = false;

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 10,
              state: ZetaCalendarDayState.inRange,
              onTap: () => tapped = true,
            ),
          ),
        );

        await tester.tap(find.text('10'));
        expect(tapped, isTrue);
      });
    });

    group('Semantics', () {
      testWidgets('enabled day has semantic label with date', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 15,
              state: ZetaCalendarDayState.enabled,
              date: DateTime(2026, 6, 15),
            ),
          ),
        );

        expect(find.bySemanticsLabel(RegExp('June 15, 2026')), findsOneWidget);

        handle.dispose();
      });

      testWidgets('disabled day has disabled in label', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 15,
              state: ZetaCalendarDayState.disabled,
              date: DateTime(2026, 6, 15),
            ),
          ),
        );

        expect(find.bySemanticsLabel(RegExp('disabled')), findsOneWidget);

        handle.dispose();
      });

      testWidgets('startRange day label contains start of range', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 10,
              state: ZetaCalendarDayState.startRange,
              date: DateTime(2026, 6, 10),
            ),
          ),
        );

        expect(find.bySemanticsLabel(RegExp('start of range')), findsOneWidget);

        handle.dispose();
      });

      testWidgets('endRange day label contains end of range', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 20,
              state: ZetaCalendarDayState.endRange,
              date: DateTime(2026, 6, 20),
            ),
          ),
        );

        expect(find.bySemanticsLabel(RegExp('end of range')), findsOneWidget);

        handle.dispose();
      });

      testWidgets('inRange day label contains in range', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 15,
              state: ZetaCalendarDayState.inRange,
              date: DateTime(2026, 6, 15),
            ),
          ),
        );

        expect(find.bySemanticsLabel(RegExp('in range')), findsOneWidget);

        handle.dispose();
      });

      testWidgets('today day label contains today', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          TestApp(
            home: ZetaCalendarDay(
              day: 21,
              state: ZetaCalendarDayState.today,
              date: DateTime(2026, 5, 21),
            ),
          ),
        );

        expect(find.bySemanticsLabel(RegExp('today')), findsOneWidget);

        handle.dispose();
      });

      testWidgets('day without date has no semantic label', (tester) async {
        final handle = tester.ensureSemantics();

        await tester.pumpWidget(
          const TestApp(
            home: ZetaCalendarDay(
              day: 5,
              state: ZetaCalendarDayState.disabled,
            ),
          ),
        );

        // Should not find any semantics with a date label
        expect(find.bySemanticsLabel(RegExp('2026')), findsNothing);

        handle.dispose();
      });
    });

    group('debugFillProperties', () {
      debugFillPropertiesTest(
        ZetaCalendarDay(
          day: 15,
          state: ZetaCalendarDayState.startRange,
          date: DateTime(2026, 6, 15),
        ),
        {
          'day': '15',
          'state': 'startRange',
          'date': DateTime(2026, 6, 15).toString(),
        },
      );
    });
  });
}
