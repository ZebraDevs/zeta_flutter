import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TimeInputExample extends StatelessWidget {
  static const name = 'TimeInput';

  const TimeInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return ExampleScaffold(
      name: 'Time Input',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: ZetaTimeInput(
                  label: 'Large',
                  hintText: 'Default hint text',
                  onChange: (value) => print(value),
                  // errorText: 'Oops! Error hint text',
                  size: ZetaWidgetSize.large,
                ),
              ),
              ZetaButton(
                label: 'Validate input',
                onPressed: () {
                  print(formKey.currentState?.validate());
                },
              ),
              ZetaTimeInput(
                label: 'Medium',
                hintText: 'Default hint text',
                errorText: 'Oops! Error hint text',
              ),
              ZetaTimeInput(
                label: 'Small',
                hintText: 'Default hint text',
                errorText: 'Oops! Error hint text',
                size: ZetaWidgetSize.small,
              ),
              ZetaTimeInput(label: '12 Hr Time Picker', use12Hr: true),
              ZetaTimeInput(label: 'Disabled Time Picker', disabled: true, hintText: 'Disabled time picker'),
            ].divide(const SizedBox(height: 12)).toList(),
          ),
        ),
      ),
    );
  }
}
