import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget phoneInputUseCase(BuildContext context) {
  final countries = context.knobs.string(
    label: 'ISO 3166-1 alpha-2 county codes',
    initialValue: '',
  );
  final enabled = context.knobs.boolean(label: 'Enabled', initialValue: true);
  return WidgetbookScaffold(
    builder: (context, _) => StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: const EdgeInsets.all(ZetaSpacing.xl_1),
          child: ZetaPhoneInput(
            disabled: enabled,
            label: 'Phone number',
            hintText: 'Enter your phone number',
            countries: countries.isEmpty ? null : countries.toUpperCase().split(','),
            // useRootNavigator: false,
          ),
        );
      },
    ),
  );
}
