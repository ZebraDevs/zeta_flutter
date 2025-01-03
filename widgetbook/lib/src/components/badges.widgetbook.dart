import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

const badgesPath = '$componentsPath/Badges';

@widgetbook.UseCase(
  name: 'Icon Indicator',
  type: ZetaIndicator,
  path: badgesPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-9865&t=N8coJ9AFu6DS3mOF-4',
)
Widget iconIndicator(BuildContext context) {
  return ZetaIndicator.icon(
    icon: iconKnob(context),
    inverse: context.knobs.boolean(label: 'Inverse Border'),
    size: context.knobs.list(label: 'Size', labelBuilder: enumLabelBuilder, options: ZetaWidgetSize.values),
    color: context.knobs.colorOrNull(label: 'Custom color'),
  );
}

@widgetbook.UseCase(
  name: 'Notification Indicator',
  type: ZetaIndicator,
  path: badgesPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-9734&t=N8coJ9AFu6DS3mOF-4',
)
Widget notificationIndicator(BuildContext context) {
  return ZetaIndicator.notification(
    inverse: context.knobs.boolean(label: 'Inverse Border'),
    size: context.knobs.list(label: 'Size', labelBuilder: enumLabelBuilder, options: ZetaWidgetSize.values),
    value: context.knobs.int.slider(label: 'Value'),
    color: context.knobs.colorOrNull(label: 'Custom color'),
  );
}

@widgetbook.UseCase(
  name: 'Label',
  type: ZetaLabel,
  path: badgesPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21926-2099&t=N8coJ9AFu6DS3mOF-4',
)
Widget label(BuildContext context) => ZetaLabel(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      status: context.knobs.list(label: 'Status', options: ZetaWidgetStatus.values, labelBuilder: enumLabelBuilder),
    );

@widgetbook.UseCase(
  name: 'Priority Pill',
  type: ZetaPriorityPill,
  path: badgesPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-10423&t=bHlo20F9nuMNKs9A-4',
)
Widget priorityPill(BuildContext context) {
  final colors = Zeta.of(context).colors;
  return ZetaPriorityPill(
    index: context.knobs.string(label: 'Index', initialValue: ''),
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
      labelBuilder: (value) => colors.rainbowMap.entries.firstWhere((v) => v.value == value).key.capitalize(),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Status Label',
  type: ZetaStatusLabel,
  path: badgesPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21836-37274&t=N8coJ9AFu6DS3mOF-4',
)
Widget statusLabel(BuildContext context) => ZetaStatusLabel(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      status: context.knobs.list(label: 'Status', labelBuilder: enumLabelBuilder, options: ZetaWidgetStatus.values),
      customIcon: iconKnob(context),
    );

typedef Tag = ZetaTag;

@widgetbook.UseCase(
  name: 'Tag',
  type: Tag,
  path: badgesPath,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22000-13170&t=N8coJ9AFu6DS3mOF-4',
)
Widget tags(BuildContext context) => ZetaTag(
      label: context.knobs.string(label: 'Label', initialValue: 'Tag'),
      direction: context.knobs.list(
        label: 'Direction',
        options: ZetaTagDirection.values,
        labelBuilder: enumLabelBuilder,
      ),
    );
