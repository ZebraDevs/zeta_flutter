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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ZetaButton(
                            label: 'Validate form',
                            onPressed: () => formKey.currentState?.validate(),
                          ),
                          ZetaButton(
                            label: 'Reset form',
                            onPressed: () => formKey.currentState?.reset(),
                          ),
                        ],
                      ),
                      ZetaTimeInput(
                        label: 'Large',
                        hintText: 'Default hint text',
                        onChange: (value) => print(value),
                        onSaved: (value) => print(value),
                        size: ZetaWidgetSize.large,
                        initialValue: TimeOfDay.now(),
                        clearSemanticLabel: 'Clear',
                        validator: (value) {
                          if (value == null) {
                            return 'Time is required';
                          }
                          return null;
                        },
                        timePickerSemanticLabel: 'Open time picker',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      ZetaTimeInput(
                        label: 'Medium',
                        hintText: 'Default hint text',
                        requirementLevel: ZetaFormFieldRequirement.optional,
                        onChange: (value) => print(value),
                        size: ZetaWidgetSize.medium,
                      ),
                      ZetaTimeInput(
                        label: 'Small',
                        hintText: 'Default hint text',
                        requirementLevel: ZetaFormFieldRequirement.mandatory,
                        onChange: (value) => print(value),
                        errorText: 'Oops! Error hint text',
                        size: ZetaWidgetSize.small,
                      ),
                    ].divide(const SizedBox(height: 12)).toList(),
                  ),
                ),
                const SizedBox(height: 48),
                ZetaTimeInput(label: '12 Hr Time Picker', use24HourFormat: true),
                ZetaTimeInput(label: 'Disabled Time Picker', disabled: true, hintText: 'Disabled time picker'),
              ].divide(const SizedBox(height: 12)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
