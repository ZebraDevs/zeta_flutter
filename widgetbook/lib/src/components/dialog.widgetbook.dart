import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Dialog',
  type: ZetaDialog,
  path: '$componentsPath/Dialog',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23954-93036&t=6jmGZpLRLKTDIfJL-4',
)
Widget dialog(BuildContext context) {
  final buttonsCount = context.knobs.int.slider(label: 'Buttons count', initialValue: 1, min: 1, max: 3);

  return DecoratedBox(
    decoration: BoxDecoration(
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 2))],
    ),
    child: ZetaDialog(
      message: context.knobs.string(
        label: 'Dialog message',
        initialValue:
            'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusm od tempor incididunt ut labore et do lore magna aliqua.',
      ),
      title: context.knobs.string(label: 'Dialog title', initialValue: 'Dialog Title'),
      icon: Icon(
        iconKnob(context, initial: Icons.warning),
        color: context.knobs.color(
          label: 'Icon Color',
          initialValue: Zeta.of(context).colors.mainWarning,
        ),
      ),
      headerAlignment: context.knobs.list<ZetaDialogHeaderAlignment>(
        label: 'Header alignment',
        options: ZetaDialogHeaderAlignment.values,
        labelBuilder: (value) => value.name,
      ),
      onPrimaryButtonPressed: buttonsCount > 0 ? () {} : null,
      onSecondaryButtonPressed: buttonsCount > 1 ? () {} : null,
      onTertiaryButtonPressed: buttonsCount > 2 ? () {} : null,
      primaryButtonLabel: buttonsCount > 0 ? 'Button' : null,
      secondaryButtonLabel: buttonsCount > 1 ? 'Button' : null,
      tertiaryButtonLabel: buttonsCount > 2 ? 'Button' : null,
    ),
  );
}
