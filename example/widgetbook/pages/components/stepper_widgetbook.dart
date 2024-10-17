import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget stepperUseCase(BuildContext context) {
  int currentStep = 0;

  final type = context.knobs.list(
    label: "Type",
    options: [
      ZetaStepperType.horizontal,
      ZetaStepperType.vertical,
    ],
    initialOption: ZetaStepperType.horizontal,
    labelBuilder: (type) => type.name,
  );

  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: type == ZetaStepperType.horizontal ? 300 : null,
          padding: EdgeInsets.all(
            type == ZetaStepperType.horizontal ? 0.0 : Zeta.of(context).spacing.xl_4,
          ),
          child: ZetaStepper(
            currentStep: currentStep,
            onStepTapped: (index) => setState(() => currentStep = index),
            type: type,
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
        );
      },
    ),
  );
}
