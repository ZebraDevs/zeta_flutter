import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../widgets.dart';

class PasswordInputExample extends StatefulWidget {
  static const String name = 'PasswordInput';

  const PasswordInputExample({Key? key}) : super(key: key);

  @override
  State<PasswordInputExample> createState() => _PasswordInputExampleState();
}

class _PasswordInputExampleState extends State<PasswordInputExample> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: ExampleScaffold(
          name: PasswordInputExample.name,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(top: 20)),
                  ZetaPasswordInput(
                    size: ZetaWidgetSize.medium,
                    hintText: 'Password',
                    controller: _passwordController,
                    validator: (value) {
                      print('validating');
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ZetaButton(
                        label: 'Reset',
                        onPressed: () => _formKey.currentState?.reset(),
                      ),
                      ZetaButton(
                        label: 'Validate',
                        onPressed: () => _formKey.currentState?.validate(),
                      ),
                    ],
                  ),
                  SizedBox(height: ZetaSpacing.xl_6),
                  ...passwordInputExampleRow(ZetaWidgetSize.large),
                  Divider(height: ZetaSpacing.xl_10),
                  ...passwordInputExampleRow(ZetaWidgetSize.medium),
                  Divider(height: ZetaSpacing.xl_10),
                  ...passwordInputExampleRow(ZetaWidgetSize.small),
                ],
              ),
            ),
          ),
        ));
  }
}

List<Widget> passwordInputExampleRow(ZetaWidgetSize size) {
  return [
    ZetaPasswordInput(
      size: size,
      semanticLabel: 'Enter password',
      showSemanticLabel: 'Show password',
      obscureSemanticLabel: 'Hide password',
    ),
    SizedBox(height: 20),
    ZetaPasswordInput(
      size: size,
      placeholder: 'Password',
      disabled: true,
    ),
    SizedBox(height: 20),
    ZetaPasswordInput(
      size: size,
      placeholder: 'Password',
      hintText: 'Default hint text',
    ),
  ];
}
