import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget statusLabelUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);

  return WidgetbookTestWidget(
    widget: Padding(
      padding: const EdgeInsets.all(ZetaSpacing.xL2),
      child: ZetaStatusLabel(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        rounded: rounded,
        status: context.knobs.list(
          label: 'Status',
          labelBuilder: enumLabelBuilder,
          options: ZetaWidgetStatus.values,
        ),
        customIcon: iconKnob(context, rounded: rounded),
      ),
    ),
  );
}

Widget priorityPillUseCase(BuildContext context) {
  final colors = Zeta.of(context).colors;
  return WidgetbookTestWidget(
    widget: Padding(
      padding: const EdgeInsets.all(ZetaSpacing.xL2),
      child: ZetaPriorityPill(
        index: context.knobs.string(label: 'Index', initialValue: 'U'),
        label: context.knobs.string(label: 'Label', initialValue: 'Urgent'),
        size: context.knobs.list<ZetaPriorityPillSize>(
          label: 'Size',
          options: ZetaPriorityPillSize.values,
          labelBuilder: (value) => value.name.capitalize(),
        ),
        type: context.knobs.list<ZetaPriorityPillType>(
          label: 'Priority',
          options: ZetaPriorityPillType.values,
          labelBuilder: (value) => value.name.capitalize(),
        ),
        rounded: context.knobs.boolean(label: 'Rounded', initialValue: true),
        isBadge: context.knobs.boolean(label: 'Badge'),
        customColor: context.knobs.listOrNull(
          label: 'Custom color',
          options: colors.rainbow,
          labelBuilder: (value) {
            return colors.rainbowMap.entries.firstWhere((v) => v.value == value).key.capitalize();
          },
        ),
      ),
    ),
  );
}

Widget labelUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: const EdgeInsets.all(ZetaSpacing.xL2),
        child: ZetaLabel(
          label: context.knobs.string(label: 'Label', initialValue: 'Label'),
          rounded: roundedKnob(context),
          status: context.knobs.list(
            label: 'Status',
            options: ZetaWidgetStatus.values,
            labelBuilder: enumLabelBuilder,
          ),
        ),
      ),
    );

Widget indicatorsUseCase(BuildContext context) {
  final bool rounded = roundedKnob(context);

  return WidgetbookTestWidget(
    widget: Padding(
      padding: const EdgeInsets.all(ZetaSpacing.xL2),
      child: ZetaIndicator(
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
        color: context.knobs.colorOrNull(label: 'Custom color'),
      ),
    ),
  );
}

Widget tagsUseCase(BuildContext context) => WidgetbookTestWidget(
      widget: Padding(
        padding: const EdgeInsets.all(ZetaSpacing.xL2),
        child: Row(
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
      ),
    );
