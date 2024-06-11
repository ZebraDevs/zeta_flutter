import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TextInputExample extends StatelessWidget {
  static const name = 'TextInput';

  const TextInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ZetaTextInputState> key = GlobalKey<ZetaTextInputState>();
    return ExampleScaffold(
        name: 'Text Input',
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  ZetaTextInput(
                    size: ZetaWidgetSize.large,
                    key: key,
                    placeholder: 'Placeholder',
                    prefixText: '£',
                    label: 'Label',
                    requirementLevel: ZetaFormFieldRequirement.mandatory,
                    errorText: 'Error text',
                    disabled: false,
                    hintText: 'hint text',
                    suffix: IconButton(
                      icon: Icon(ZetaIcons.add_alert_round),
                      onPressed: () {},
                    ),
                  ),
                  ZetaButton(
                    label: 'Clear',
                    onPressed: () => key.currentState?.reset(),
                  ),
                  ZetaTextInput(
                    placeholder: 'Placeholder',
                    prefixText: '£',
                  ),
                  ZetaTextInput(
                    size: ZetaWidgetSize.small,
                    placeholder: 'Placeholder',
                    prefix: SizedBox(
                      height: 8,
                      child: IconButton(
                        iconSize: 12,
                        splashRadius: 1,
                        icon: Icon(
                          ZetaIcons.add_alert_round,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ZetaTextInput(
                    placeholder: 'Placeholder',
                    prefix: Icon(
                      ZetaIcons.star_round,
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
        ));
  }
}
