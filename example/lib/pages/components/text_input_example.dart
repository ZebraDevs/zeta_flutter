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
    return Form(
      key: key,
      child: ExampleScaffold(
        name: name,
        children: [
          ZetaTextInput(
            key: Key('docs-text-input-small'),
            size: ZetaWidgetSize.small,
            placeholder: 'Placeholder Small',
            prefix: Icon(ZetaIcons.star),
            suffix: Icon(ZetaIcons.star),
            hintText: 'Hint',
            label: 'Label',
          ),
          ZetaTextInput(
            key: Key('docs-text-input-medium'),
            size: ZetaWidgetSize.medium,
            placeholder: 'Placeholder Medium',
            prefixText: '£',
            suffixText: 'lbs',
            disabled: true,
          ),
          ZetaTextInput(
            size: ZetaWidgetSize.large,
            key: Key('docs-text-input-large'),
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
        ].divide(const SizedBox(height: 12)).toList(),
      ),
    );
  }
}
