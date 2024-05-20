import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TextInputExample extends StatelessWidget {
  static const name = 'TextInput';

  const TextInputExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
        name: 'Text Input',
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ZetaTextInput(
                  size: ZetaWidgetSize.large,
                  placeholder: 'Placeholder',
                  disabled: true,
                ),
                ZetaTextInput(placeholder: 'Placeholder'),
                ZetaTextInput(
                  size: ZetaWidgetSize.small,
                  placeholder: 'Placeholder',
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
                  placeholder: 'Placeholder',
                  suffixText: 'kg',
                  prefixText: '£',
                ),
              ].divide(const SizedBox(height: 12)).toList(),
            ),
          ),
        ));
  }
}
