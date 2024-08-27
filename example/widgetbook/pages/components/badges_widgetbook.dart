import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
import '../../utils/utils.dart';

Widget statusLabelUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => Padding(
      padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
      child: ZetaStatusLabel(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        status: context.knobs.list(
          label: 'Status',
          labelBuilder: enumLabelBuilder,
          options: ZetaWidgetStatus.values,
        ),
        customIcon: iconKnob(context),
      ),
    ),
  );
}

Widget priorityPillUseCase(BuildContext context) {
  final colors = Zeta.of(context).colors;
  return WidgetbookScaffold(
    builder: (context, _) => Padding(
      padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
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

Widget labelUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
        child: ZetaLabel(
          label: context.knobs.string(label: 'Label', initialValue: 'Label'),
          status: context.knobs.list(
            label: 'Status',
            options: ZetaWidgetStatus.values,
            labelBuilder: enumLabelBuilder,
          ),
        ),
      ),
    );

Widget indicatorsUseCase(BuildContext context) {
  return WidgetbookScaffold(
    builder: (context, _) => Padding(
      padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
      child: ZetaIndicator(
        type: context.knobs.list(
          label: 'Type',
          options: ZetaIndicatorType.values,
          labelBuilder: enumLabelBuilder,
        ),
        icon: iconKnob(context),
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

Widget tagsUseCase(BuildContext context) => WidgetbookScaffold(
      builder: (context, _) => Padding(
        padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ZetaTag(
              label: context.knobs.string(label: 'Label', initialValue: 'Tag'),
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
