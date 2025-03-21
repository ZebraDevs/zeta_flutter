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
  String? errorText = null;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: PasswordInputExample.name,
      children: [
        ZetaPasswordInput(
          size: ZetaWidgetSize.small,
          key: Key('docs-password-input-0'),
          hintText: 'Small',
          controller: _passwordController,
          onSubmit: (val) {
            (val?.length ?? 0) > 5 ? errorText = null : errorText = 'Password must be at least 6 characters';
            setState(() {});
          },
          placeholder: 'Password',
        ),
        ZetaPasswordInput(
          size: ZetaWidgetSize.medium,
          hintText: 'Password (at least 6 characters)',
          key: Key('docs-password-input-1'),
          controller: _passwordController,
          onSubmit: (val) {
            (val?.length ?? 0) > 5 ? errorText = null : errorText = 'Password must be at least 6 characters';
            setState(() {});
          },
          validator: (value) {
            print('validating');
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          placeholder: 'Password',
          errorText: errorText,
        ),
        ZetaPasswordInput(
          size: ZetaWidgetSize.large,
          key: Key('docs-password-input-2'),
          disabled: true,
          hintText: 'Disabled',
          controller: _passwordController,
          onSubmit: (val) {
            (val?.length ?? 0) > 5 ? errorText = null : errorText = 'Password must be at least 6 characters';
            setState(() {});
          },
          validator: (value) {
            print('validating');
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            return null;
          },
          errorText: errorText,
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
        SizedBox(height: Zeta.of(context).spacing.xl_6),
        ...passwordInputExampleRow(ZetaWidgetSize.large),
        Divider(height: Zeta.of(context).spacing.xl_10),
        ...passwordInputExampleRow(ZetaWidgetSize.medium),
        Divider(height: Zeta.of(context).spacing.xl_10),
        ...passwordInputExampleRow(ZetaWidgetSize.small),
      ],
    );
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
