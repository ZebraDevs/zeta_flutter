import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class RadioButtonExample extends StatefulWidget {
  const RadioButtonExample({Key? key}) : super(key: key);

  @override
  State<RadioButtonExample> createState() => _RadioButtonExampleState();
}

class _RadioButtonExampleState extends State<RadioButtonExample> {
  String option1 = 'Label 1';
  String option2 = 'Label 2';
  String option3 = 'Disabled';
  String? groupValue;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: radioButtonRoute,
      children: [
        Column(
          children: [
            ZetaRadio<String>(
              value: option1,
              groupValue: groupValue,
              onChanged: isEnabled ? (value) => setState(() => groupValue = value) : null,
              label: Text(option1),
            ),
            ZetaRadio<String>(
              value: option2,
              groupValue: groupValue,
              onChanged: isEnabled ? (value) => setState(() => groupValue = value) : null,
              label: Text(option2),
            ),
            ZetaRadio<String>(
              value: option3,
              groupValue: groupValue,
              onChanged: !isEnabled ? (value) => setState(() => groupValue = value) : null,
              label: Text(option3),
            ),
          ],
        ),
        ZetaButton(
          label: isEnabled ? 'Disable' : 'Enable',
          onPressed: () => setState(() => isEnabled = !isEnabled),
        ),
      ],
    );
  }
}
