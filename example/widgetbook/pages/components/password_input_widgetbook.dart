import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';
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

    return Form(
      key: _formKey,
      child: WidgetbookScaffold(
        builder: (context, _) => Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 328),
              child: ZetaPasswordInput(
                disabled: disabledKnob(context),
                size: context.knobs.list(
                  label: 'Size',
                  options: ZetaWidgetSize.values,
                  labelBuilder: enumLabelBuilder,
                ),
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
