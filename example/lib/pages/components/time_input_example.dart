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
              ZetaTimeInput(),
              ZetaTimeInput(use12Hr: true),
              ZetaTimeInput(disabled: true),
            ].divide(const SizedBox(height: 12)).toList(),
          ),
        ),
      ),
    );
  }
}
