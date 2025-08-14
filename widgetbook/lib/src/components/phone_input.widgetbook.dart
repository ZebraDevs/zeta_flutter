import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:zeta_flutter/zeta_flutter.dart';
import 'package:zeta_widgetbook/main.dart';
import 'package:zeta_widgetbook/src/utils/utils.dart';

@widgetbook.UseCase(
  name: 'Phone Input',
  type: ZetaPhoneInput,
  path: '$componentsPath/Phone Input',
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22731-90569&t=AZEbv7Mm0mjIx0Or-4',
)
Widget phoneInputUseCase(BuildContext context) {
  final countries = context.knobs.string(label: 'ISO 3166-1 alpha-2 county codes');

  return SmallContentWrapper(
    child: ZetaPhoneInput(
      disabled: context.knobs.boolean(label: 'Disabled'),
      label: context.knobs.string(label: 'Label', initialValue: 'Phone Number'),
      hintText: context.knobs.string(label: 'Hint Text', initialValue: 'Enter phone number'),
      size:
          context.knobs.object.dropdown(label: 'Size', options: ZetaWidgetSize.values, labelBuilder: enumLabelBuilder),
      errorText: context.knobs.stringOrNull(label: 'Error Text'),
      countries: countries.isEmpty ? null : countries.toUpperCase().split(','),
    ),
  );
}
