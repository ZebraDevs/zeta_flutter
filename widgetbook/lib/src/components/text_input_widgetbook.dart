import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Text Input',
  type: ZetaTextInput,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23132-170489&t=6jmGZpLRLKTDIfJL-4',
)
Widget textInput(BuildContext context) {
  final label = context.knobs.string(
    label: 'Label',
    initialValue: 'Label',
  );
  final errorText = context.knobs.stringOrNull(
    label: 'Error message',
    initialValue: 'Oops! Error hint text',
  );
  final hintText = context.knobs.string(
    label: 'Hint',
    initialValue: 'Default hint text',
  );
  final disabled = disabledKnob(context);
  final size = context.knobs.list<ZetaWidgetSize>(
    label: 'Size',
    options: ZetaWidgetSize.values,
    labelBuilder: (size) => size.name,
  );

  return Padding(
    padding: EdgeInsets.all(Zeta.of(context).spacing.xl),
    child: ZetaTextInput(
      size: size,
      disabled: disabled,
      label: label,
      hintText: hintText,
      errorText: errorText,
      prefixText: '£',
      suffix: IconButton(
        icon: const ZetaIcon(ZetaIcons.star),
        onPressed: () {},
      ),
      onChange: (value) {},
    ),
  );
}
