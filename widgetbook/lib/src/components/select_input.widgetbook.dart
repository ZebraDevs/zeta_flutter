import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Select Input',
  type: ZetaSelectInput,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=23954-90316&t=9UKEEDe1Zek0JZal-4',
)
Widget selectInputUseCase(BuildContext context) => ZetaSelectInput(
      disabled: disabledKnob(context),
      size: context.knobs.list<ZetaWidgetSize>(
        label: 'Size',
        options: ZetaWidgetSize.values,
        labelBuilder: enumLabelBuilder,
      ),
      items: [
        ZetaDropdownItem(value: 'Item 1', icon: const ZetaIcon(ZetaIcons.star)),
        ZetaDropdownItem(value: 'Item 2', icon: const ZetaIcon(ZetaIcons.star_half)),
        ZetaDropdownItem(value: 'Item 3'),
      ],
      label: context.knobs.string(label: 'Label', initialValue: 'Label'),
      hintText: context.knobs.string(label: 'Hint', initialValue: 'Default hint text'),
      requirementLevel: context.knobs.list<ZetaFormFieldRequirement>(
        label: 'Requirement Level',
        options: ZetaFormFieldRequirement.values,
        labelBuilder: enumLabelBuilder,
      ),
      errorText: context.knobs.stringOrNull(label: 'Error message', initialValue: 'Oops! Error hint text'),
    );
