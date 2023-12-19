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
                    value: isChecked, isEnabled: isEnabled, onChanged: (value) => setState(() => isChecked = value)),
                ElevatedButton(
                  child: Text(isEnabled ? 'Disable' : 'Enable'),
                  onPressed: () => setState(() => isEnabled = !isEnabled),
                )
              ],
            ),
            Row(children: [Text('Sharp Checkbox Enabled', style: ZetaText.zetaTitleLarge)]),
            getCheckBoxRow(isEnabled: true),
            Row(children: [Text('Sharp Checkbox Disabled', style: ZetaText.zetaTitleLarge)]),
            getCheckBoxRow(isEnabled: false),
            Row(children: [Text('Rounded Checkbox Enabled', style: ZetaText.zetaTitleLarge)]),
            getCheckBoxRow(isEnabled: true, isSharp: false),
            Row(children: [Text('Rounded Checkbox Disabled', style: ZetaText.zetaTitleLarge)]),
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
            label: 'Label',
            borderType: isSharp ? BorderType.sharp : BorderType.rounded,
            onChanged: (value) => {}),
        ZetaCheckbox(
            value: false,
            isEnabled: isEnabled,
            label: 'Label',
            borderType: isSharp ? BorderType.sharp : BorderType.rounded,
            onChanged: (value) => {}),
        ZetaCheckbox(
            value: null,
            borderType: isSharp ? BorderType.sharp : BorderType.rounded,
            isEnabled: isEnabled,
            onChanged: (value) => {}),
      ]);
}
