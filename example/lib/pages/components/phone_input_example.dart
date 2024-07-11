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
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Phone Input',
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ZetaPhoneInput(
                label: 'Phone number',
                hint: 'Enter your phone number',
                hasError: _errorText != null,
                errorText: _errorText,
                onChanged: (value) {
                  if (value?.isEmpty ?? true) setState(() => _errorText = null);
                  print(value);
                },
                countries: ['US', 'GB', 'DE', 'AT', 'FR', 'IT', 'BG'],
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
                hint: 'Enter your phone number',
                disabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
