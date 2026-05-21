import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../../test_utils/test_utils.dart';

const _screenSize = Size(800, 600);

Widget _buildTestApp(Widget child) {
  return TestApp(
    screenSize: _screenSize,
    removeBody: false,
    home: child,
  );
}

void main() {
  group('ZetaCalendar', () {
    group('Rendering', () {
      testWidgets('renders dual month view with footer actions', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(ZetaCalendar()),
        );

        expect(find.byType(ZetaCalendar), findsOneWidget);
        expect(find.text('Reset'), findsOneWidget);
        expect(find.text('Cancel'), findsOneWidget);
        expect(find.text('Apply'), findsOneWidget);
      });

      testWidgets('renders with initial range', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 5, 10),
              initialEndDate: DateTime(2026, 5, 20),
            ),
          ),
        );

        expect(find.byType(ZetaCalendar), findsOneWidget);
      });
    });

    group('Range selection', () {
      testWidgets('tapping one day gives incomplete range (null)', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? reportedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onRangeChanged: (range) => reportedRange = range,
            ),
          ),
        );

        await tester.tap(find.text('10').first);
        await tester.pump();

        expect(reportedRange, isNull);
      });

      testWidgets('tapping two days creates a complete range', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? reportedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onRangeChanged: (range) => reportedRange = range,
            ),
          ),
        );

        await tester.tap(find.text('10').first);
        await tester.pump();
        await tester.tap(find.text('15').first);
        await tester.pump();

        expect(reportedRange, isNotNull);
        expect(reportedRange!.start.day, 10);
        expect(reportedRange!.end.day, 15);
      });

      testWidgets('tapping earlier date than start swaps order', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? reportedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onRangeChanged: (range) => reportedRange = range,
            ),
          ),
        );

        // Tap 20 first (start), then 5 (earlier) — should swap
        await tester.tap(find.text('20').first);
        await tester.pump();
        await tester.tap(find.text('5').first);
        await tester.pump();

        expect(reportedRange, isNotNull);
        expect(reportedRange!.start.day, 5);
        expect(reportedRange!.end.day, 20);
      });

      testWidgets('tapping same day as start clears selection', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? reportedRange;
        bool rangeChangedCalled = false;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onRangeChanged: (range) {
                reportedRange = range;
                rangeChangedCalled = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('10').first);
        await tester.pump();

        // Tap same day again
        await tester.tap(find.text('10').first);
        await tester.pump();

        expect(rangeChangedCalled, isTrue);
        expect(reportedRange, isNull);
      });

      testWidgets('tapping after complete range starts new selection', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? reportedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onRangeChanged: (range) => reportedRange = range,
            ),
          ),
        );

        // Create a complete range
        await tester.tap(find.text('10').first);
        await tester.pump();
        await tester.tap(find.text('15').first);
        await tester.pump();

        expect(reportedRange, isNotNull);

        // Tap a third day — restarts selection, range becomes null
        await tester.tap(find.text('22').first);
        await tester.pump();

        expect(reportedRange, isNull);
      });
    });

    group('Footer actions', () {
      testWidgets('Reset clears selection and calls callbacks', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        bool resetCalled = false;
        DateTimeRange? reportedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 6, 10),
              initialEndDate: DateTime(2026, 6, 20),
              onReset: () => resetCalled = true,
              onRangeChanged: (range) => reportedRange = range,
            ),
          ),
        );

        await tester.tap(find.text('Reset'));
        await tester.pump();

        expect(resetCalled, isTrue);
        expect(reportedRange, isNull);
      });

      testWidgets('Cancel calls onCancel', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        bool cancelCalled = false;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onCancel: () => cancelCalled = true,
            ),
          ),
        );

        await tester.tap(find.text('Cancel'));
        await tester.pump();

        expect(cancelCalled, isTrue);
      });

      testWidgets('Apply calls onApply with current range', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? appliedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 6, 10),
              initialEndDate: DateTime(2026, 6, 20),
              onApply: (range) => appliedRange = range,
            ),
          ),
        );

        await tester.tap(find.text('Apply'));
        await tester.pump();

        expect(appliedRange, isNotNull);
        expect(appliedRange!.start, DateTime(2026, 6, 10));
        expect(appliedRange!.end, DateTime(2026, 6, 20));
      });

      testWidgets('Apply with no selection calls onApply with null', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        DateTimeRange? appliedRange;
        bool applyCalled = false;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              onApply: (range) {
                appliedRange = range;
                applyCalled = true;
              },
            ),
          ),
        );

        await tester.tap(find.text('Apply'));
        await tester.pump();

        expect(applyCalled, isTrue);
        expect(appliedRange, isNull);
      });
    });

    group('Month navigation', () {
      testWidgets('next month button advances the view', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 1, 15),
            ),
          ),
        );

        expect(find.textContaining('Jan 2026'), findsOneWidget);

        final nextButton = find.bySemanticsLabel('Next month');
        expect(nextButton, findsOneWidget);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.textContaining('Feb 2026'), findsOneWidget);
      });

      testWidgets('previous month button goes back', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 3, 15),
            ),
          ),
        );

        expect(find.textContaining('Mar 2026'), findsOneWidget);

        final prevButton = find.bySemanticsLabel('Previous month');
        expect(prevButton, findsOneWidget);
        await tester.tap(prevButton);
        await tester.pumpAndSettle();

        expect(find.textContaining('Feb 2026'), findsOneWidget);
      });

      testWidgets('navigating across year boundary works', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 1, 15),
            ),
          ),
        );

        expect(find.textContaining('Jan 2026'), findsOneWidget);

        final prevButton = find.bySemanticsLabel('Previous month');
        expect(prevButton, findsOneWidget);
        await tester.tap(prevButton);
        await tester.pumpAndSettle();

        expect(find.textContaining('Dec 2025'), findsOneWidget);
      });
    });

    group('didUpdateWidget', () {
      testWidgets('updates selection when initialStartDate changes', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final key = GlobalKey();

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              key: key,
              initialStartDate: DateTime(2026, 6, 10),
              initialEndDate: DateTime(2026, 6, 20),
            ),
          ),
        );

        expect(find.textContaining('Jun 2026'), findsOneWidget);

        // Rebuild with different initial dates
        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              key: key,
              initialStartDate: DateTime(2026, 9, 5),
              initialEndDate: DateTime(2026, 9, 15),
            ),
          ),
        );
        await tester.pumpAndSettle();

        // View should navigate to September
        expect(find.textContaining('Sep 2026'), findsOneWidget);
      });

      testWidgets('updates selection when initialEndDate changes', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final key = GlobalKey();
        DateTimeRange? appliedRange;

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              key: key,
              initialStartDate: DateTime(2026, 6, 10),
              initialEndDate: DateTime(2026, 6, 20),
              onApply: (range) => appliedRange = range,
            ),
          ),
        );

        // Rebuild with different end date
        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              key: key,
              initialStartDate: DateTime(2026, 6, 10),
              initialEndDate: DateTime(2026, 6, 25),
              onApply: (range) => appliedRange = range,
            ),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.text('Apply'));
        await tester.pump();

        expect(appliedRange, isNotNull);
        expect(appliedRange!.end, DateTime(2026, 6, 25));
      });

      testWidgets('does not update when props are unchanged', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        final key = GlobalKey();

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              key: key,
              initialStartDate: DateTime(2026, 6, 10),
            ),
          ),
        );

        expect(find.textContaining('Jun 2026'), findsOneWidget);

        // Navigate forward
        await tester.tap(find.bySemanticsLabel('Next month'));
        await tester.pumpAndSettle();

        expect(find.textContaining('Jul 2026'), findsOneWidget);

        // Rebuild with same props — should NOT reset navigation
        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              key: key,
              initialStartDate: DateTime(2026, 6, 10),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(find.textContaining('Jul 2026'), findsOneWidget);
      });
    });

    group('Year picker integration', () {
      testWidgets('opens year picker on header tap', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 6),
            ),
          ),
        );

        // Verify month view is displayed
        expect(find.textContaining('Jun 2026'), findsOneWidget);

        // Tap header to open year picker
        await tester.tap(find.textContaining('Jun 2026').first);
        await tester.pumpAndSettle();

        // Month header should no longer be visible (replaced by year picker)
        expect(find.textContaining('Jun 2026'), findsNothing);

        // Year picker should show a GridView
        expect(find.byType(GridView), findsOneWidget);
      });
    });

    group('Forward year boundary navigation', () {
      testWidgets('navigating forward from December crosses to next year', (tester) async {
        tester.view.physicalSize = _screenSize;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          _buildTestApp(
            ZetaCalendar(
              initialStartDate: DateTime(2026, 12, 15),
            ),
          ),
        );

        expect(find.textContaining('Dec 2026'), findsOneWidget);

        final nextButton = find.bySemanticsLabel('Next month');
        expect(nextButton, findsOneWidget);
        await tester.tap(nextButton);
        await tester.pumpAndSettle();

        expect(find.textContaining('Jan 2027'), findsOneWidget);
      });
    });

    group('Constructor asserts', () {
      test('asserts minDate is not after maxDate', () {
        expect(
          () => ZetaCalendar(
            minDate: DateTime(2026, 12),
            maxDate: DateTime(2026),
          ),
          throwsAssertionError,
        );
      });

      test('asserts initialStartDate is not after initialEndDate', () {
        expect(
          () => ZetaCalendar(
            initialStartDate: DateTime(2026, 6, 20),
            initialEndDate: DateTime(2026, 6, 10),
          ),
          throwsAssertionError,
        );
      });

      test('asserts initialStartDate is not before minDate', () {
        expect(
          () => ZetaCalendar(
            initialStartDate: DateTime(2026),
            minDate: DateTime(2026, 6),
          ),
          throwsAssertionError,
        );
      });

      test('asserts initialEndDate is not after maxDate', () {
        expect(
          () => ZetaCalendar(
            initialEndDate: DateTime(2026, 12, 31),
            maxDate: DateTime(2026, 6, 30),
          ),
          throwsAssertionError,
        );
      });

      test('valid parameters do not throw', () {
        expect(
          () => ZetaCalendar(
            initialStartDate: DateTime(2026, 6, 10),
            initialEndDate: DateTime(2026, 6, 20),
            minDate: DateTime(2026),
            maxDate: DateTime(2026, 12, 31),
          ),
          returnsNormally,
        );
      });
    });

    group('debugFillProperties', () {
      debugFillPropertiesTest(
        ZetaCalendar(
          initialStartDate: DateTime(2026, 6, 10),
          initialEndDate: DateTime(2026, 6, 20),
          minDate: DateTime(2026),
          maxDate: DateTime(2026, 12, 31),
        ),
        {
          'initialStartDate': DateTime(2026, 6, 10).toString(),
          'initialEndDate': DateTime(2026, 6, 20).toString(),
          'minDate': DateTime(2026).toString(),
          'maxDate': DateTime(2026, 12, 31).toString(),
        },
      );
    });
  });
}
