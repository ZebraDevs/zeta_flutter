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
  int _roundedHorizontalStep = 0;
  int _sharpHorizontalStep = 0;
  int _verticalStep = 0;

  ZetaStepType _getForStepIndex({
    required int currentStep,
    required int stepIndex,
  }) {
    if (currentStep == stepIndex) return ZetaStepType.enabled;
    if (currentStep > stepIndex) return ZetaStepType.complete;

    return ZetaStepType.disabled;
  }

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
                currentStep: _roundedHorizontalStep,
                onStepTapped: (index) => setState(() => _roundedHorizontalStep = index),
                steps: [
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _roundedHorizontalStep,
                      stepIndex: 0,
                    ),
                    title: Text("Title"),
                    content: Text("Content"),
                  ),
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _roundedHorizontalStep,
                      stepIndex: 1,
                    ),
                    title: Text("Title 2"),
                  ),
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _roundedHorizontalStep,
                      stepIndex: 2,
                    ),
                    title: Text("Title 3"),
                    content: Text("Content 3"),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 150,
              child: ZetaStepper(
                rounded: false,
                currentStep: _sharpHorizontalStep,
                onStepTapped: (index) => setState(() => _sharpHorizontalStep = index),
                steps: [
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _sharpHorizontalStep,
                      stepIndex: 0,
                    ),
                    title: Text("Title"),
                    content: Text("Content"),
                  ),
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _sharpHorizontalStep,
                      stepIndex: 1,
                    ),
                    title: Text("Title 2"),
                    content: Text("Content 2"),
                  ),
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _sharpHorizontalStep,
                      stepIndex: 2,
                    ),
                    title: Text("Title 3"),
                    content: Text("Content 3"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.l),
              child: ZetaStepper(
                type: ZetaStepperType.vertical,
                currentStep: _verticalStep,
                onStepTapped: (index) => setState(() => _verticalStep = index),
                steps: [
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _verticalStep,
                      stepIndex: 0,
                    ),
                    title: Text("Title"),
                    subtitle: Text("Step Number"),
                    content: Text("Content"),
                  ),
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _verticalStep,
                      stepIndex: 1,
                    ),
                    title: Text("Title 2"),
                    subtitle: Text("Step Number"),
                    content: Text("Content 2"),
                  ),
                  ZetaStep(
                    type: _getForStepIndex(
                      currentStep: _verticalStep,
                      stepIndex: 2,
                    ),
                    title: Text("Title 3"),
                    subtitle: Text("Step Number"),
                    content: Text("Content 3"),
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
