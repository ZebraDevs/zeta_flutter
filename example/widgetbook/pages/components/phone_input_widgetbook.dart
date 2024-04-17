import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';

Widget phoneInputUseCase(BuildContext context) {
  final countries = context.knobs.string(
    label: 'ISO 3166-1 alpha-2 county codes',
    initialValue: '',
  );
  final rounded = context.knobs.boolean(label: 'Rounded', initialValue: true);
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  return WidgetbookTestWidget(
    widget: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.x5),
          child: ZetaPhoneInput(
            rounded: rounded,
            enabled: enabled,
            label: 'Phone number',
            hint: 'Enter your phone number',
            countries: countries.isEmpty ? null : countries.toUpperCase().split(','),
            useRootNavigator: false,
          ),
        );
      },
    ),
  );
}
