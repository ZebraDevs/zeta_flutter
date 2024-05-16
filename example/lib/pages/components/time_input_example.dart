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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      ZetaButton(
                        label: 'Validate inputs',
                        onPressed: () => print(formKey.currentState?.validate()),
                      ),
                      ZetaTimeInput(
                        label: 'Large',
                        hint: 'Default hint text',
                        onChange: (value) => print(value),
                        errorText: 'Oops! Error hint text',
                        size: ZetaWidgetSize.large,
                      ),
                      ZetaTimeInput(
                        label: 'Medium',
                        hint: 'Default hint text',
                        onChange: (value) => print(value),
                        errorText: 'Oops! Error hint text',
                        size: ZetaWidgetSize.medium,
                      ),
                      ZetaTimeInput(
                        label: 'Small',
                        hint: 'Default hint text',
                        onChange: (value) => print(value),
                        errorText: 'Oops! Error hint text',
                        size: ZetaWidgetSize.small,
                      ),
                    ].divide(const SizedBox(height: 12)).toList(),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                ZetaTimeInput(label: '12 Hr Time Picker', use12Hr: true),
                ZetaTimeInput(label: 'Disabled Time Picker', disabled: true, hint: 'Disabled time picker'),
                ZetaTimeInput(label: 'Sharp Time Picker', rounded: false),
              ].divide(const SizedBox(height: 12)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
