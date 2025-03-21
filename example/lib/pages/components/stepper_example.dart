import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  static const String name = 'Stepper';

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _step = 0;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: StepperExample.name,
      children: [
        ZetaStepper(
          currentStep: _step,
          key: Key('docs-stepper-horizontal'),
          onStepTapped: (index) => setState(() => _step = index),
          steps: [
            ZetaStep(
              title: Text("Title"),
            ),
            ZetaStep(
              title: Text("Title 2"),
            ),
            ZetaStep(
              title: Text("Title 3"),
            ),
          ],
        ),
        ZetaStepper(
          key: Key('docs-stepper-vertical'),
          type: ZetaStepperType.vertical,
          currentStep: _step,
          onStepTapped: (index) => setState(() => _step = index),
          steps: [
            ZetaStep(
              title: Text("Title"),
              subtitle: Text("Step Number"),
            ),
            ZetaStep(
              title: Text("Title 2"),
              subtitle: Text("Step Number"),
            ),
            ZetaStep(
              title: Text("Title 3"),
              disabled: true,
              subtitle: Text("Step Number"),
            ),
          ],
        ),
      ],
    );
  }
}
