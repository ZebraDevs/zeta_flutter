import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:zeta_flutter/zeta_flutter.dart';

import 'package:zeta_widgetbook/src/utils/utils.dart';

// TODO(luke): Test this
@widgetbook.UseCase(
  name: 'Password',
  type: ZetaPasswordInput,
  designLink:
      'https://www.figma.com/design/JesXQFLaPJLc1BdBM4sisI/%F0%9F%A6%93-ZDS---Components?node-id=948-13632&t=6jmGZpLRLKTDIfJL-4',
)
Widget passwordInputUseCase(BuildContext context) {
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return StatefulBuilder(builder: (context, setState) {
    final enableValidation = context.knobs.boolean(label: 'Enable validation');
    final validationString = context.knobs.string(label: 'Error label', initialValue: 'Incorrect');

    return Form(
      key: formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 328),
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
          onChange: (_) => formKey.currentState?.validate(),
          validator: (_) => enableValidation ? validationString : null,
          controller: passwordController,
        ),
      ),
    );
  },);
}
