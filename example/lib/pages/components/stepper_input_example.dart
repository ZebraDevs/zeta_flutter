import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class StepperInputExample extends StatefulWidget {
  static const name = 'StepperInput';

  const StepperInputExample({super.key});

  @override
  State<StepperInputExample> createState() => _StepperInputExampleState();
}

class _StepperInputExampleState extends State<StepperInputExample> {
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: StepperInputExample.name,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZetaStepperInput(
              min: 0,
              max: 10,
              initialValue: 5,
              onChange: (_) {},
            ),
            ZetaStepperInput(rounded: false),
            ZetaStepperInput(
              size: ZetaStepperInputSize.large,
              onChange: (_) {},
            ),
          ].divide(const SizedBox(height: 16)).toList(),
        ),
      ),
    );
  }
}
