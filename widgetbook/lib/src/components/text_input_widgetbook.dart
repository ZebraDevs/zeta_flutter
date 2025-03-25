import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Text Input',
  type: ZetaTextInput,
  path: '$componentsPath/Text Input',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23132-170489&t=eEOivHU9uV4K8qJq-4',
)
Widget textInput(BuildContext context) {
  final prefixIcon = iconKnob(context, nullable: true, name: 'Prefix Icon');
  final suffixIcon = iconKnob(context, nullable: true, name: 'Suffix Icon');

  final prefixText = context.knobs.stringOrNull(label: 'Prefix Text');
  final suffixText = context.knobs.stringOrNull(label: 'Suffix Text');

  final disabled = disabledKnob(context);

  return SmallContentWrapper(
    child: ZetaTextInput(
      size: context.knobs.list<ZetaWidgetSize>(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: (size) => size.name,
      ),
      disabled: disabled,
      onChange: disabled ? null : (value) => {},
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      hintText: context.knobs.string(label: 'Hint', initialValue: 'Default hint text'),
      errorText: context.knobs.stringOrNull(label: 'Error message'),
      prefixText: prefixText != null && prefixIcon == null ? prefixText : null,
      suffixText: suffixText != null && suffixIcon == null ? suffixText : null,
      placeholder: context.knobs.stringOrNull(label: 'Placeholder', initialValue: 'Placeholder'),
      prefix: prefixIcon != null ? Icon(prefixIcon) : null,
      suffix: suffixIcon != null ? Icon(suffixIcon) : null,
    ),
  );
}
