import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TextInputExample extends StatelessWidget {
  static const name = 'TextInput';

  const TextInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: 'Initial value');
    final key = GlobalKey<FormState>();
    return ExampleScaffold(
        name: 'Text Input',
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    ZetaTextInput(
                      size: ZetaWidgetSize.large,
                      placeholder: 'Placeholder',
                      prefixText: '£',
                      controller: controller,
                      onChange: print,
                      label: 'Label',
                      requirementLevel: ZetaFormFieldRequirement.mandatory,
                      errorText: 'Error text',
                      disabled: false,
                      hintText: 'hint text',
                      suffix: IconButton(
                        icon: ZetaIcon(ZetaIcons.add_alert),
                        onPressed: () {},
                      ),
                    ),
                    ZetaTextInput(
                      placeholder: 'Placeholder',
                      prefixText: '£',
                      initialValue: 'Initial value',
                    ),
                    ZetaTextInput(
                      size: ZetaWidgetSize.small,
                      placeholder: 'Placeholder',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                      prefix: SizedBox(
                        height: 8,
                        child: IconButton(
                          iconSize: 12,
                          splashRadius: 1,
                          icon: ZetaIcon(
                            ZetaIcons.add_alert,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ZetaButton(
                          label: 'Reset',
                          onPressed: () => key.currentState?.reset(),
                        ),
                        ZetaButton(
                          label: 'Validate',
                          onPressed: () => key.currentState?.validate(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ZetaTextInput(
                      placeholder: 'Placeholder',
                      prefix: ZetaIcon(
                        ZetaIcons.star,
                        size: 20,
                      ),
                    ),
                    ZetaTextInput(
                      size: ZetaWidgetSize.small,
                      placeholder: 'Placeholder',
                      suffixText: 'kg',
                      prefixText: '£',
                    ),
                  ].divide(const SizedBox(height: 12)).toList(),
                ),
              ),
            ),
          ),
        ));
  }
}
