import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Comms Buttons',
  type: ZetaCommsButton,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=20816-11402&t=6jmGZpLRLKTDIfJL-4',
)
Widget commsButton(BuildContext context) => ZetaCommsButton(
      label: context.knobs.string(label: 'Text', initialValue: 'Answer'),
      size: context.knobs.list(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
        initialOption: ZetaWidgetSize.medium,
      ),
      type: context.knobs.list(
        label: 'Type',
        options: ZetaCommsButtonType.values,
        labelBuilder: enumLabelBuilder,
        initialOption: ZetaCommsButtonType.positive,
      ),
      icon: iconKnob(context, nullable: false, name: "Icon", initial: ZetaIcons.phone),
    );
