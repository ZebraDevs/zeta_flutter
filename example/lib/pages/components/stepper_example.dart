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
  int _horistonalStep = 0;
  int _verticalStep = 0;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: StepperExample.name,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ZetaStepper(
                currentStep: _horistonalStep,
                onStepTapped: (index) => setState(() => _horistonalStep = index),
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.xl_4),
              child: ZetaStepper(
                type: ZetaStepperType.vertical,
                currentStep: _verticalStep,
                onStepTapped: (index) => setState(() => _verticalStep = index),
                steps: [
                  ZetaStep(
                    title: Text("Title"),
                    subtitle: Text("Step Number"),
                  ),
                  ZetaStep(
                    title: Text("Title 2"),
                    subtitle: Text("Step Number"),
                    disabled: true,
                  ),
                  ZetaStep(
                    title: Text("Title 3"),
                    subtitle: Text("Step Number"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
