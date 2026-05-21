import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CalendarExample extends StatefulWidget {
  const CalendarExample({Key? key}) : super(key: key);

  @override
  State<CalendarExample> createState() => _CalendarExampleState();
}

class _CalendarExampleState extends State<CalendarExample> {
  DateTimeRange? _selectedRange;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: calendarRoute,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selectedRange != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Selected: ${_formatDate(_selectedRange!.start)} – ${_formatDate(_selectedRange!.end)}',
                  style: Zeta.of(context).textStyles.bodyMedium,
                ),
              ),
            ZetaCalendar(
              key: const Key('docs-calendar'),
              initialStartDate: DateTime(2028, 7, 3),
              initialEndDate: DateTime(2028, 8, 18),
              minDate: DateTime(2020),
              maxDate: DateTime(2035),
              onRangeChanged: (range) {
                setState(() => _selectedRange = range);
              },
              onApply: (range) {
                if (range != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Applied: ${_formatDate(range.start)} – ${_formatDate(range.end)}',
                      ),
                    ),
                  );
                }
              },
              onCancel: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cancelled')),
                );
              },
              onReset: () {
                setState(() => _selectedRange = null);
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) => DateFormat.yMMMd().format(date);
}
