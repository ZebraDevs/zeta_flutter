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
  bool isEnabled = true;
  bool useIndeterminate = false;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Checkbox',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ZetaCheckbox(
                  value: isChecked,
                  onChanged: isEnabled ? (value) => setState(() => isChecked = value) : null,
                  useIndeterminate: useIndeterminate,
                ),
                ZetaButton(
                  label: isEnabled ? 'Disable' : 'Enable',
                  onPressed: () => setState(() => isEnabled = !isEnabled),
                ),
                ZetaButton(
                  label: !useIndeterminate ? 'Use Indeterminate' : 'Don\'t use indeterminate',
                  onPressed: () => setState(() => useIndeterminate = !useIndeterminate),
                ),
              ],
            ),
            Row(children: [Text('Checkbox Enabled')]),
            getCheckBoxRow(isEnabled: true),
            Row(children: [Text('Checkbox Disabled')]),
            getCheckBoxRow(isEnabled: false),
          ],
        ),
      ),
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
