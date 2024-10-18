import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Progress Bar',
  type: ZetaProgressBar,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=549-3936&t=9UKEEDe1Zek0JZal-4',
)
Widget bar(BuildContext context) => ZetaProgressBar(
      progress: context.knobs.double.slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5).toDouble(),
      type: context.knobs.list(label: 'Type', options: ZetaProgressBarType.values, labelBuilder: enumLabelBuilder),
      isThin: context.knobs.boolean(label: 'Thin'),
      label: context.knobs.stringOrNull(label: 'Label'),
    );

@widgetbook.UseCase(
  name: 'Progress Circle',
  type: ZetaProgressCircle,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=900-10416&t=9UKEEDe1Zek0JZal-4',
)
Widget progressCircleUseCase(BuildContext context) => ZetaProgressCircle(
      progress: context.knobs.double.slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5).toDouble(),
      size: context.knobs.list(
        initialOption: ZetaCircleSizes.xl,
        label: 'Size',
        options: ZetaCircleSizes.values,
        labelBuilder: enumLabelBuilder,
      ),
      onCancel: context.knobs.boolean(label: "Can Cancel") ? () {} : null,
    );
