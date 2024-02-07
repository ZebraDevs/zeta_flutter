import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../test/test_components.dart';

WidgetbookComponent passwordInputWidgetBook() {
  return WidgetbookComponent(
    name: 'Password Input',
    isInitiallyExpanded: false,
    useCases: [
      WidgetbookUseCase(
        name: 'Password Input',
        builder: (context) {
          return _Password();
        },
      ),
    ],
  );
}

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
      child: WidgetbookTestWidget(
        widget: Padding(
          padding: EdgeInsets.all(ZetaSpacing.x5),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 328),
                child: ZetaPasswordInput(
                  rounded: context.knobs.boolean(label: 'Rounded'),
                  enabled: context.knobs.boolean(label: 'Enabled', initialValue: true),
                  obscureText: context.knobs.boolean(label: 'Obscure text', initialValue: true),
                  size: context.knobs.list(label: 'Size', options: ZetaWidgetSize.values),
                  footerIcon: context.knobs.listOrNull(
                    label: 'Icon',
                    options: [
                      ZetaIcons.star_half_round,
                      ZetaIcons.add_alert_round,
                      ZetaIcons.add_box_round,
                      ZetaIcons.barcode_round,
                    ],
                    labelBuilder: (value) {
                      if (value == ZetaIcons.star_half_round) return 'ZetaIcons.star_half_round';
                      if (value == ZetaIcons.add_alert_round) return 'ZetaIcons.add_alert_round';
                      if (value == ZetaIcons.add_box_round) return 'ZetaIcons.add_box_round';
                      if (value == ZetaIcons.barcode_round) return 'ZetaIcons.barcode_round';
                      return '';
                    },
                    initialOption: null,
                  ),
                  footerText: context.knobs.string(label: 'Footer Text'),
                  hintText: context.knobs.string(label: 'Hint text'),
                  label: context.knobs.string(label: 'Label'),
                  onChanged: (_) => _formKey.currentState?.validate(),
                  validator: (_) => enableValidation ? validationString : null,
                  controller: _passwordController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
