import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget progressBarUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth - Zeta.of(context).spacing.xl_9,
          child: ZetaProgressBar(
            progress: context.knobs.double.slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5).toDouble(),
            type: context.knobs.list(
              label: 'Type',
              options: ZetaProgressBarType.values,
              labelBuilder: enumLabelBuilder,
            ),
            isThin: context.knobs.boolean(label: 'Thin'),
            label: context.knobs.stringOrNull(label: 'Label'),
          ),
        );
      }),
    );

Widget progressCircleUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Column(
        children: [
          // CircularProgressIndicator(),
          ZetaProgressCircle(
            // progress: context.knobs.double.slider(label: 'Progress', min: 0, max: 1, initialValue: 0.5).toDouble(),
            size: context.knobs.list(
              initialOption: ZetaCircleSizes.xl,
              label: 'Size',
              options: ZetaCircleSizes.values,
              labelBuilder: enumLabelBuilder,
            ),
            onCancel: context.knobs.boolean(label: "Can Cancel") ? () {} : null,
          ),
        ],
      ),
    );
