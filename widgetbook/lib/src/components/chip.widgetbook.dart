import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Input Chip',
  type: ZetaInputChip,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-2159&t=6jmGZpLRLKTDIfJL-4',
)
Widget inputChip(BuildContext context) {
  final trailing = iconKnob(context);

  return ZetaInputChip(
    label: context.knobs.string(label: 'Label', initialValue: 'Label'),
    leading: context.knobs.boolean(label: 'Avatar', initialValue: true)
        ? ZetaAvatar(
            initials: 'AZ',
            image:
                context.knobs.boolean(label: 'Avatar Image') ? Image.asset('assets/Omer.jpg', fit: BoxFit.cover) : null,
          )
        : null,
    trailing: trailing != null ? ZetaIcon(trailing) : null,
  );
}

@widgetbook.UseCase(
  name: 'Filter Chip',
  type: ZetaFilterChip,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-14112&t=6jmGZpLRLKTDIfJL-4',
)
Widget filterChip(BuildContext context) => ZetaFilterChip(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      selected: context.knobs.boolean(label: 'Selected', initialValue: true),
    );

@widgetbook.UseCase(
  name: 'Assist Chip',
  type: ZetaAssistChip,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21265-14215&t=6jmGZpLRLKTDIfJL-4',
)
Widget assistChip(BuildContext context) => ZetaAssistChip(
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      leading: ZetaIcon(iconKnob(context)),
    );
