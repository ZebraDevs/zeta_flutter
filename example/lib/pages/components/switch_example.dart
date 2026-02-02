import 'package:flutter/material.dart';
import 'package:zeta_example/config/components_config.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class SwitchExample extends StatefulWidget {
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
      name: switchRoute,
      children: [
        Column(
          spacing: 40,
          children: [
            SizedBox(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Text('Android')),
                Expanded(
                  child: ZetaSwitch(
                    value: isOn,
                    onChanged: isEnabled ? (value) => setState(() => isOn = value) : null,
                    variant: ZetaSwitchType.android,
                  ),
                ),
                Expanded(child: ZetaSwitch(variant: ZetaSwitchType.android)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('iOS')),
                Expanded(
                  child: ZetaSwitch(
                    value: isOn,
                    onChanged: isEnabled ? (value) => setState(() => isOn = value) : null,
                    variant: ZetaSwitchType.ios,
                  ),
                ),
                Expanded(child: ZetaSwitch(variant: ZetaSwitchType.ios)),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text('Web')),
                Expanded(
                  child: ZetaSwitch(
                    value: isOn,
                    onChanged: isEnabled ? (value) => setState(() => isOn = value) : null,
                    variant: ZetaSwitchType.web,
                  ),
                ),
                Expanded(child: ZetaSwitch(variant: ZetaSwitchType.web)),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
