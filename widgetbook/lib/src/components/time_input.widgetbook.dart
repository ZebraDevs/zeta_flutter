import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Time Input',
  type: ZetaTimeInput,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22751-9848&t=6jmGZpLRLKTDIfJL-4',
)
Widget timeInput(BuildContext context) => ZetaTimeInput(
      size: context.knobs.list<ZetaWidgetSize>(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: (size) => size.name,
      ),
      disabled: disabledKnob(context),
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      hintText: context.knobs.stringOrNull(label: 'Hint', initialValue: 'Default hint text'),
      errorText: context.knobs.stringOrNull(label: 'Error message', initialValue: 'Error message'),
      onChange: (value) {},
    );
