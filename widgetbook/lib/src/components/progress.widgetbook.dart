import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const String progressPath = '$componentsPath/Progress';

@widgetbook.UseCase(
  name: 'Progress Bar',
  type: ZetaProgressBar,
  path: progressPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1358-31337&t=AZEbv7Mm0mjIx0Or-4',
)
Widget bar(BuildContext context) => ZetaProgressBar(
      progress: context.knobs.double.slider(label: 'Progress', max: 1, initialValue: 0.5),
      type: context.knobs.list(label: 'Type', options: ZetaProgressBarType.values, labelBuilder: enumLabelBuilder),
      isThin: context.knobs.boolean(label: 'Thin'),
      label: context.knobs.stringOrNull(label: 'Label'),
    ).paddingHorizontal(16);

@widgetbook.UseCase(
  name: 'Progress Circle',
  type: ZetaProgressCircle,
  path: progressPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=900-10416&t=AZEbv7Mm0mjIx0Or-4',
)
Widget progressCircleUseCase(BuildContext context) => ZetaProgressCircle(
      progress: context.knobs.double.slider(label: 'Progress', max: 1, initialValue: 0.5),
      size: context.knobs.list(
        initialOption: ZetaCircleSizes.xl,
        label: 'Size',
        options: ZetaCircleSizes.values,
        labelBuilder: enumLabelBuilder,
      ),
    );
@widgetbook.UseCase(
  name: 'Upload Progress Circle',
  type: ZetaProgressCircle,
  path: progressPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=1330-30588&t=AZEbv7Mm0mjIx0Or-4',
)
Widget uploadProgressCircleUseCase(BuildContext context) => ZetaProgressCircle(
      progress: context.knobs.double.slider(label: 'Progress', max: 1, initialValue: 0.5),
      size: context.knobs.list(
        initialOption: ZetaCircleSizes.xl,
        label: 'Size',
        options: ZetaCircleSizes.values,
        labelBuilder: enumLabelBuilder,
      ),
      onCancel: () {},
      label: context.knobs.stringOrNull(label: 'Label'),
    );
