import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget statusLabelUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);

  return WidgetbookTestWidget(
    widget: ZetaStatusLabel(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      rounded: rounded,
      status: context.knobs.list(
        label: 'Status',
        labelBuilder: enumLabelBuilder,
        options: ZetaWidgetStatus.values,
      ),
      customIcon: iconKnob(context, rounded: rounded),
    ),
  );
}

Widget priorityPillUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaPriorityPill(
        index: context.knobs.int.slider(label: 'Index'),
        priority: context.knobs.string(label: 'Priority', initialValue: 'Priority'),
        rounded: roundedKnob(context),
      ),
    );

Widget badgeUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: ZetaBadge(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: roundedKnob(context),
        status: context.knobs.list(
          label: 'Status',
          options: ZetaWidgetStatus.values,
          labelBuilder: enumLabelBuilder,
        ),
      ),
    );

Widget indicatorsUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);

  return WidgetbookTestWidget(
    widget: ZetaIndicator(
      type: context.knobs.list(
        label: 'Type',
        options: ZetaIndicatorType.values,
        labelBuilder: enumLabelBuilder,
      ),
      icon: iconKnob(context, rounded: rounded),
      inverse: context.knobs.boolean(label: 'Inverse Border'),
      size: context.knobs.list(
        label: 'Size',
        labelBuilder: enumLabelBuilder,
        options: ZetaWidgetSize.values,
      ),
      value: context.knobs.int.slider(label: 'Value'),
    ),
  );
}

Widget tagsUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ZetaTag(
            label: context.knobs.string(label: 'Label', initialValue: 'Tag'),
            rounded: roundedKnob(context),
            direction: context.knobs.list(
              label: 'Direction',
              options: ZetaTagDirection.values,
              labelBuilder: enumLabelBuilder,
            ),
          ),
        ],
      ),
    );

Widget workcloudIndicatorsUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);

  return WidgetbookTestWidget(
    widget: ZetaWorkcloudIndicator(
      index: context.knobs.string(label: 'Index', initialValue: '1'),
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      prioritySize: context.knobs.list(
        label: 'Size',
        labelBuilder: enumLabelBuilder,
        options: ZetaWidgetSize.values,
      ),
      priorityType: context.knobs.list(
        label: 'Type',
        labelBuilder: enumLabelBuilder,
        options: ZetaWorkcloudIndicatorType.values,
      ),
      icon: iconKnob(context, rounded: rounded, nullable: true),
    ),
  );
}
