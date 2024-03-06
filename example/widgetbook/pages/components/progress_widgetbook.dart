import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget progressBarUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth - ZetaSpacing.xl,
          child: ZetaProgressBar(
            progress: context.knobs.double
                .slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5)
                .toDouble(),
            type: context.knobs.list(
                label: 'Type',
                options: ZetaProgressBarType.values,
                labelBuilder: (value) => value.name),
            isThin: context.knobs.boolean(label: 'Thin'),
            rounded: context.knobs.boolean(label: 'Rounded'),
            label: context.knobs.stringOrNull(label: 'Label'),
          ),
        );
      }),
    );

Widget progressCircleUseCase(BuildContext context) =>
    WidgetbookTestWidget(widget: LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: constraints.maxWidth - ZetaSpacing.xl,
        height: constraints.maxHeight,
        child: Center(
          child: ZetaProgressCircle(
            progress: context.knobs.double
                .slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5)
                .toDouble(),
            rounded: context.knobs.boolean(label: 'Rounded'),
            size: context.knobs.list(
                initialOption: ZetaCircleSizes.xl,
                label: 'Size',
                options: ZetaCircleSizes.values,
                labelBuilder: (value) => value.name),
          ),
        ),
      );
    }));
