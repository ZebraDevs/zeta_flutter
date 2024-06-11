import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget progressBarUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth - ZetaSpacing.xl_9,
          child: ZetaProgressBar(
            progress: context.knobs.double.slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5).toDouble(),
            type: context.knobs.list(
              label: 'Type',
              options: ZetaProgressBarType.values,
              labelBuilder: enumLabelBuilder,
            ),
            isThin: context.knobs.boolean(label: 'Thin'),
            rounded: roundedKnob(context),
            label: context.knobs.stringOrNull(label: 'Label'),
          ),
        );
      }),
    );

Widget progressCircleUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaProgressCircle(
        progress: context.knobs.double.slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5).toDouble(),
        rounded: roundedKnob(context),
        size: context.knobs.list(
          initialOption: ZetaCircleSizes.xl_1,
          label: 'Size',
          options: ZetaCircleSizes.values,
          labelBuilder: enumLabelBuilder,
        ),
        onCancel: context.knobs.boolean(label: "Can Cancel") ? () {} : null,
      ),
    );
