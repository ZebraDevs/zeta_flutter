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
    return ExampleScaffold(
      name: 'Phone Input',
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              ZetaButton(label: 'Reset', onPressed: () => key.currentState?.reset()),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ZetaPhoneInput(
                  label: 'Phone number',
                  hintText: 'Enter your phone number',
                  initialValue: const ZetaPhoneNumber(dialCode: '+44', number: '1234567890'),
                  onChange: (value) {
                    print(value?.dialCode);
                    print(value?.number);
                  },
                  countries: ['US', 'GB', 'DE', 'AT', 'FR', 'IT', 'BG'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ZetaPhoneInput(
                  label: 'Phone number',
                  hintText: 'Enter your phone number',
                  size: ZetaWidgetSize.large,
                  errorText: 'Error',
                  onChange: (value) {
                    print(value);
                  },
                  countries: ['US', 'GB', 'DE', 'AT', 'FR', 'IT', 'BG'],
                  selectCountrySemanticLabel: 'Choose country code',
                ),
              ),
              Divider(color: Colors.grey[200]),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('Disabled', style: ZetaTextStyles.titleMedium),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ZetaPhoneInput(
                  label: 'Phone number',
                  hintText: 'Enter your phone number',
                  disabled: true,
                ),
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
        ),
      ),
    );
  }
}
