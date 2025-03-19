import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class CheckBoxExample extends StatefulWidget {
  static const String name = 'Checkbox';

  const CheckBoxExample({Key? key}) : super(key: key);

  @override
  State<CheckBoxExample> createState() => _CheckBoxExampleState();
}

class _CheckBoxExampleState extends State<CheckBoxExample> {
  bool isChecked = true;
  bool useIndeterminate = false;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: CheckBoxExample.name,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          key: Key('docs-checkbox'),
          children: [
            ZetaCheckbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  if (value && !useIndeterminate) {
                    useIndeterminate = true;
                    isChecked = true;
                  } else if (!value && useIndeterminate) {
                    useIndeterminate = false;
                    isChecked = true;
                  } else {
                    isChecked = false;
                  }
                });
              },
              useIndeterminate: useIndeterminate,
              label: 'Label',
            ),
            ZetaCheckbox(
              label: 'Disabled',
            ),
          ],
        ),
        Row(children: [Text('Checkbox Enabled')]),
        getCheckBoxRow(isEnabled: true),
        Row(children: [Text('Checkbox Disabled')]),
        getCheckBoxRow(isEnabled: false),
      ],
    );
  }
}

Row getCheckBoxRow({required bool isEnabled}) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ZetaCheckbox(
          value: true,
          label: 'Label',
          onChanged: isEnabled ? (value) => {} : null,
        ),
        ZetaCheckbox(
          value: false,
          label: 'Label',
          onChanged: isEnabled ? (value) => {} : null,
        ),
        ZetaCheckbox(
          onChanged: isEnabled ? (value) => {} : null,
          value: false,
        )
      ]);
}
