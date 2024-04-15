import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class DateInputExample extends StatefulWidget {
  static const String name = 'DateInput';

  const DateInputExample({Key? key}) : super(key: key);

  @override
  State<DateInputExample> createState() => _DateInputExampleState();
}

class _DateInputExampleState extends State<DateInputExample> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Date Input',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Rounded', style: ZetaTextStyles.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaDateInput(
                label: 'Birthdate',
                hint: 'Enter birthdate',
                hasError: _errorText != null,
                errorText: _errorText ?? 'Invalid date',
                onChanged: (value) {
                  if (value == null) return setState(() => _errorText = null);
                  final now = DateTime.now();
                  setState(
                    () => _errorText = value.difference(DateTime(now.year, now.month, now.day)).inDays > 0
                        ? 'Birthdate cannot be in the future'
                        : null,
                  );
                },
              ),
            ),
            Divider(color: Colors.grey[200]),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Sharp', style: ZetaTextStyles.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaDateInput(
                label: 'Label',
                hint: 'Default hint text',
                errorText: 'Oops! Error hint text',
                rounded: false,
                datePattern: 'yyyy-MM-dd',
              ),
            ),
            Divider(color: Colors.grey[200]),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Disabled', style: ZetaTextStyles.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaDateInput(
                label: 'Label',
                hint: 'Default hint text',
                enabled: false,
              ),
            ),
            Divider(color: Colors.grey[200]),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Medium', style: ZetaTextStyles.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaDateInput(
                label: 'Label',
                hint: 'Default hint text',
                errorText: 'Oops! Error hint text',
                size: ZetaDateInputSize.medium,
              ),
            ),
            Divider(color: Colors.grey[200]),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text('Small', style: ZetaTextStyles.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaDateInput(
                label: 'Label',
                hint: 'Default hint text',
                errorText: 'Oops! Error hint text',
                size: ZetaDateInputSize.small,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
