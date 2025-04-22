import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class PhoneInputExample extends StatefulWidget {
  static const String name = 'PhoneInput';

  const PhoneInputExample({Key? key}) : super(key: key);

  @override
  State<PhoneInputExample> createState() => _PhoneInputExampleState();
}

class _PhoneInputExampleState extends State<PhoneInputExample> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: ExampleScaffold(
        gap: 8,
        name: PhoneInputExample.name,
        children: [
          ZetaButton(label: 'Reset', onPressed: () => key.currentState?.reset()),
          ZetaPhoneInput(
            label: 'Phone number',
            hintText: 'Enter your phone number',
            size: ZetaWidgetSize.small,
            initialValue: const PhoneNumber(dialCode: '+44', number: '1234567890'),
            onChange: (value) {},
            countries: ['US', 'GB', 'DE', 'AT', 'FR', 'IT', 'BG'],
            key: Key('docs-phone-input'),
          ),
          ZetaPhoneInput(
            label: 'Phone number',
            hintText: 'Enter your phone number',
            size: ZetaWidgetSize.medium,
            errorText: 'Error',
            onChange: (value) {
              print(value);
            },
            countries: ['US', 'GB', 'DE', 'AT', 'FR', 'IT', 'BG'],
            selectCountrySemanticLabel: 'Choose country code',
            key: Key('docs-phone-input-error'),
          ),
          Divider(color: Colors.grey[200]),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('Disabled', style: Zeta.of(context).textStyles.titleMedium),
          ),
          ZetaPhoneInput(
            label: 'Phone number',
            size: ZetaWidgetSize.large,
            hintText: 'Enter your phone number',
            disabled: true,
            key: Key('docs-phone-input-disabled'),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ZetaPhoneInput(
              label: 'Phone number',
              hintText: 'Enter your phone number',
            ),
          ),
        ],
      ),
    );
  }
}
