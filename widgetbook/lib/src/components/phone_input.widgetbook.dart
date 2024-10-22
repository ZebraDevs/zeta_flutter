import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:zeta_flutter/zeta_flutter.dart';

@widgetbook.UseCase(
  name: 'Phone Input',
  type: ZetaPhoneInput,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=22731-90569&t=9UKEEDe1Zek0JZal-4',
)
Widget phoneInputUseCase(BuildContext context) {
  final countries = context.knobs.string(
    label: 'ISO 3166-1 alpha-2 county codes',
  );

  return ZetaPhoneInput(
    disabled: context.knobs.boolean(label: 'Disabled', initialValue: true),
    label: 'Phone number',
    hintText: 'Enter your phone number',
    countries: countries.isEmpty ? null : countries.toUpperCase().split(','),
  );
}
