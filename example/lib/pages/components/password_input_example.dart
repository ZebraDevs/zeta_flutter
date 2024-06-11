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
                    rounded: false,
                    footerText: 'Error state is triggered if the password contains digits',
                    footerIcon: ZetaIcons.info_round,
                    hintText: 'Password',
                    controller: _passwordController,
                    onChanged: (value) => _formKey.currentState?.validate(),
                    validator: (value) {
                      if (value != null) {
                        final regExp = RegExp(r'\d');
                        if (regExp.hasMatch(value)) return 'Password is incorrect';
                      }
                      return null;
                    },
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

List<Widget> passwordInputExampleRow(ZetaWidgetSize size, {bool rounded = true}) {
  return [
    ZetaPasswordInput(size: size, hintText: 'Password', rounded: rounded),
    SizedBox(height: 20),
    ZetaPasswordInput(rounded: rounded, size: size, hintText: 'Password', enabled: false),
    SizedBox(height: 20),
    ZetaPasswordInput(
      size: size,
      label: 'Label',
      hintText: 'Password',
      footerText: 'Default hint text',
      rounded: rounded,
      footerIcon: ZetaIcons.info_round,
    ),
  ];
}
