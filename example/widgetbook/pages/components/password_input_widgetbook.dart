import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../test/test_components.dart';
import '../../utils/utils.dart';

Widget passwordInputUseCase(BuildContext context) => _Password();

class _Password extends StatefulWidget {
  const _Password();

  @override
  State<_Password> createState() => _PasswordState();
}

class _PasswordState extends State<_Password> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext _) {
    final enableValidation = context.knobs.boolean(label: 'Enable validation', initialValue: false);
    final validationString = context.knobs.string(label: 'Error label', initialValue: 'Incorrect');

    final bool rounded = roundedKnob(context);

    return Form(
      key: _formKey,
      child: WidgetbookTestWidget(
        widget: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 328),
              child: ZetaPasswordInput(
                disabled: disabledKnob(context),
                obscureText: context.knobs.boolean(label: 'Obscure text', initialValue: true),
                size: context.knobs.list(
                  label: 'Size',
                  options: ZetaWidgetSize.values,
                  labelBuilder: enumLabelBuilder,
                ),
                rounded: rounded,
                hintText: context.knobs.string(label: 'Hint Text'),
                placeholder: context.knobs.string(label: 'Placeholder'),
                label: context.knobs.string(label: 'Label'),
                onChange: (_) => _formKey.currentState?.validate(),
                validator: (_) => enableValidation ? validationString : null,
                controller: _passwordController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
