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
      paddingAll: 40,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              spacing: 40,
              children: [
                ZetaStepperInput(
                  min: 0,
                  max: 10,
                  value: 5,
                  onChange: (_) {},
                ),
                ZetaStepperInput(
                  min: 0,
                  max: 10,
                  value: 5,
                  size: ZetaStepperInputSize.large,
                  onChange: (_) {},
                ),
              ],
            ),
            Column(
              spacing: 40,
              children: [
                ZetaStepperInput(
                  min: 0,
                  max: 10,
                  value: 5,
                ),
                ZetaStepperInput(
                  size: ZetaStepperInputSize.large,
                ),
              ],
            ),
          ],
        )
      ].divide(const SizedBox(height: 16)).toList(),
    );
  }
}
