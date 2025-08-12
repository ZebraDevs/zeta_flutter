import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Select Input',
  type: ZetaSelectInput,
  path: '$componentsPath/Select Input',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23954-90316&t=sHwT9f9HuPjkpi1x-4',
)
Widget selectInputUseCase(BuildContext context) => SmallContentWrapper(
      child: ZetaSelectInput(
        disabled: disabledKnob(context),
        size: context.knobs.object.dropdown<ZetaWidgetSize>(
          label: 'Size',
          options: ZetaWidgetSize.values,
          labelBuilder: enumLabelBuilder,
        ),
        items: List.generate(
          context.knobs.int.slider(label: 'Dropdown items', min: 1, max: 20, initialValue: 3),
          (e) => ZetaDropdownItem(value: 'Item $e', icon: const Icon(ZetaIcons.star)),
        ),
        label: context.knobs.string(label: 'Label', initialValue: 'Label'),
        hintText: context.knobs.string(label: 'Hint', initialValue: 'Default hint text'),
        requirementLevel: context.knobs.object.dropdown<ZetaFormFieldRequirement>(
          label: 'Requirement Level',
          options: ZetaFormFieldRequirement.values,
          labelBuilder: enumLabelBuilder,
        ),
        errorText: context.knobs.stringOrNull(label: 'Error message'),
        placeholder: context.knobs.string(label: 'Placeholder', initialValue: 'Placeholder'),
      ),
    );
