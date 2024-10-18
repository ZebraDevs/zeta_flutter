import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Status Label',
  type: ZetaStatusLabel,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21836-37274&t=bHlo20F9nuMNKs9A-4',
)
Widget statusLabel(BuildContext context) => Padding(
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
    );

@widgetbook.UseCase(
  name: 'Priority Pill',
  type: ZetaPriorityPill,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-10423&t=bHlo20F9nuMNKs9A-4',
)
Widget priorityPill(BuildContext context) {
  final colors = Zeta.of(context).colors;
  return Padding(
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
  );
}

@widgetbook.UseCase(
  name: 'Label',
  type: ZetaLabel,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21926-2099&t=bHlo20F9nuMNKs9A-4',
)
Widget label(BuildContext context) => Padding(
      padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
      child: ZetaLabel(
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        status: context.knobs.list(
          label: 'Status',
          options: ZetaWidgetStatus.values,
          labelBuilder: enumLabelBuilder,
        ),
      ),
    );

@widgetbook.UseCase(
  name: 'Icon Indicator',
  type: ZetaIndicator,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-9865&t=QGJWipbvqxlvCtMR-4',
)
Widget iconIndicator(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
    child: ZetaIndicator(
      icon: iconKnob(context),
      inverse: context.knobs.boolean(label: 'Inverse Border'),
      size: context.knobs.list(
        label: 'Size',
        labelBuilder: enumLabelBuilder,
        options: ZetaWidgetSize.values,
      ),
      color: context.knobs.colorOrNull(label: 'Custom color'),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Notification Indicator',
  type: ZetaIndicator,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=24183-9734&t=QGJWipbvqxlvCtMR-4',
)
Widget notificationIndicator(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(Zeta.of(context).spacing.xl_2),
    child: ZetaIndicator(
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
  );
}

@widgetbook.UseCase(
  name: 'Tags',
  type: ZetaIndicator,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22000-13170&t=QGJWipbvqxlvCtMR-4',
)
Widget tags(BuildContext context) => Padding(
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
    );
