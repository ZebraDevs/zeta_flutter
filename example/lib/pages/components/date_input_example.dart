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
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Date Input',
      gap: 7,
      children: [
        ZetaDateInput(
          label: 'Label',
          hintText: 'Default hint text',
          errorText: 'Oops! Error hint text',
          size: ZetaWidgetSize.small,
          key: Key('docs-date-input-small'),
        ),
        ZetaDateInput(
          size: ZetaWidgetSize.medium,
          key: Key('docs-date-input-medium'),
        ),
        ZetaDateInput(
          onChange: (DateTime? _) {},
          initialValue: DateTime.now(),
          size: ZetaWidgetSize.large,
          key: Key('docs-date-input-large'),
        ),
        ZetaDateInput(
          label: 'Label',
          key: Key('docs-date-input-disabled'),
          hintText: 'Default hint text',
          disabled: true,
        ),
      ],
    );
  }
}
