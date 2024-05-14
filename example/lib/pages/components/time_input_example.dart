import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TimeInputExample extends StatelessWidget {
  static const name = 'TimeInput';

  const TimeInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Time Input',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ZetaTimeInput(
                label: 'Large',
                hintText: 'Default hint text',
                errorText: 'Oops! Error hint text',
                size: ZetaWidgetSize.large,
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
              ZetaTimeInput(disabled: true),
            ].divide(const SizedBox(height: 12)).toList(),
          ),
        ),
      ),
    );
  }
}
