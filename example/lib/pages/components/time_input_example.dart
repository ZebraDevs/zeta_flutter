import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TimeInputExample extends StatelessWidget {
  static const name = 'TimeInput';

  const TimeInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: ExampleScaffold(
        name: name,
        gap: 7,
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
            key: Key('docs-time-input-small'),
            hintText: 'Default hint text',
            requirementLevel: ZetaFormFieldRequirement.mandatory,
            onChange: (value) => print(value),
            errorText: 'Oops! Error hint text',
            size: ZetaWidgetSize.small,
          ),
          ZetaTimeInput(
            label: '12 Hr Time Picker',
            use24HourFormat: true,
            size: ZetaWidgetSize.medium,
            key: Key('docs-time-input-medium'),
          ),
          ZetaTimeInput(
            hintText: 'Default hint text',
            onChange: (value) => print(value),
            onSaved: (value) => print(value),
            size: ZetaWidgetSize.large,
            initialValue: TimeOfDay.now(),
            key: Key('docs-time-input-large'),
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
            label: 'Disabled Time Picker',
            disabled: true,
            size: ZetaWidgetSize.small,
            key: Key('docs-time-input-didsabled'),
          ),
        ],
      ),
    );
  }
}
