import 'package:flutter/widgets.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'In Page Banner',
  type: ZetaInPageBanner,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=21156-27071&m=dev',
)
Widget inPageBanner(BuildContext context) => ZetaInPageBanner(
      content: Text(
        context.knobs.string(
          label: 'content',
          initialValue: 'Lorem ipsum dolor sit amet, conse ctetur  cididunt ut labore et do lore magna aliqua.',
        ),
      ),
      status: context.knobs.list(
        label: 'Severity',
        options: ZetaWidgetStatus.values,
        labelBuilder: enumLabelBuilder,
      ),
      onClose: context.knobs.boolean(label: 'Show Close icon') ? () {} : null,
      title: context.knobs.string(label: 'Title', initialValue: 'Title'),
      actions: () {
        final buttons = context.knobs.list(label: 'Show Buttons', options: [0, 1, 2]);
        return [
          if (buttons > 0) ZetaButton(label: 'Button 1', onPressed: () {}),
          if (buttons > 1) ZetaButton(label: 'Button 2', onPressed: () {}),
        ];
      }(),
      customIcon: iconKnob(context, nullable: true),
    );
