import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget stepperUseCase(BuildContext context) {
  int currentStep = 0;

  ZetaStepType getForStepIndex(int stepIndex) {
    if (currentStep == stepIndex) return ZetaStepType.enabled;
    if (currentStep > stepIndex) return ZetaStepType.complete;

    return ZetaStepType.disabled;
  }

  final type = context.knobs.list(
    label: "Type",
    options: [
      ZetaStepperType.horizontal,
      ZetaStepperType.vertical,
    ],
    initialOption: ZetaStepperType.horizontal,
    labelBuilder: (type) => type.name,
  );

  final rounded = roundedKnob(context);

  final enabledContent = context.knobs.boolean(label: 'Enabled Content', initialValue: true);

  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: type == ZetaStepperType.horizontal ? 300 : null,
          padding: EdgeInsets.all(
            type == ZetaStepperType.horizontal ? 0.0 : ZetaSpacing.xl_4,
          ),
          child: ZetaStepper(
            currentStep: currentStep,
            onStepTapped: (index) => setState(() => currentStep = index),
            rounded: type == ZetaStepperType.horizontal ? rounded : true,
            type: type,
            steps: [
              ZetaStep(
                type: getForStepIndex(0),
                title: Text("Title"),
                content: enabledContent ? Text("Content") : null,
              ),
              ZetaStep(
                type: getForStepIndex(1),
                title: Text("Title 2"),
                content: enabledContent ? Text("Content 2") : null,
              ),
              ZetaStep(
                type: getForStepIndex(2),
                title: Text("Title 3"),
                content: enabledContent ? Text("Content 3") : null,
              ),
            ],
          ),
        );
      },
    ),
  );
}
