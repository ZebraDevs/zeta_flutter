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
              child: Text('Large', style: ZetaTextStyles.titleMedium),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaDateInput(
                label: 'Birthdate',
                hintText: 'Enter birthdate',
                errorText: _errorText ?? 'Invalid date',
                initialValue: DateTime.now(),
                size: ZetaWidgetSize.large,
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
                hintText: 'Default hint text',
                errorText: 'Oops! Error hint text',
                size: ZetaWidgetSize.medium,
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
                hintText: 'Default hint text',
                errorText: 'Oops! Error hint text',
                size: ZetaWidgetSize.small,
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
                hintText: 'Default hint text',
                disabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
