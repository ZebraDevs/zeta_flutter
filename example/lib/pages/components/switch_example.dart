import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SwitchExample extends StatefulWidget {
  static const String name = 'Switch';

  const SwitchExample({Key? key}) : super(key: key);

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool? isOn = false;
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: 'Switch',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ZetaSwitch(
                  value: isOn,
                  onChanged: isEnabled ? (value) => setState(() => isOn = value) : null,
                ),
                ZetaButton(
                  label: isEnabled ? 'Disable' : 'Enable',
                  onPressed: () => setState(() => isEnabled = !isEnabled),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
