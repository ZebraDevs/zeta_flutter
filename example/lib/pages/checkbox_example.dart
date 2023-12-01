import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class CheckBoxExample extends StatefulWidget {
  static const String name = 'Checkbox';

  const CheckBoxExample({Key? key}) : super(key: key);

  @override
  State<CheckBoxExample> createState() => _CheckBoxExampleState();
}

class _CheckBoxExampleState extends State<CheckBoxExample> {
  bool? isChecked = true;
  bool isEnabled = true;

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
                    isEnabled: isEnabled,
                    onChanged: (value) => setState(() => isChecked = value)),
                ElevatedButton(
                  child: const Text('Disable'),
                  onPressed: () => setState(() => isEnabled = !isEnabled),
                )
              ],
            ),
            Row(children: [const Text('Sharp Checkbox Enabled')]),
            getCheckBoxRow(isEnabled: true),
            Row(children: [const Text('Sharp Checkbox Disabled')]),
            getCheckBoxRow(isEnabled: false),
            Row(children: [const Text('Rounded Checkbox Enabled')]),
            getCheckBoxRow(isEnabled: true, isSharp: false),
            Row(children: [const Text('Rounded Checkbox Disabled')]),
            getCheckBoxRow(isEnabled: false, isSharp: false),
          ],
        ),
      ),
    );
  }
}

Row getCheckBoxRow({required bool isEnabled, bool isSharp = true}) {
  return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ZetaCheckbox(
            value: true,
            isEnabled: isEnabled,
            label: 'Selected',
            borderType: isSharp ? BorderType.sharp : BorderType.rounded,
            onChanged: (value) => {}),
        ZetaCheckbox(
            value: false,
            isEnabled: isEnabled,
            label: 'Indeterminate',
            borderType: isSharp ? BorderType.sharp : BorderType.rounded,
            onChanged: (value) => {}),
        ZetaCheckbox(
            value: null,
            borderType: isSharp ? BorderType.sharp : BorderType.rounded,
            isEnabled: isEnabled,
            onChanged: (value) => {}),
      ]);
}
