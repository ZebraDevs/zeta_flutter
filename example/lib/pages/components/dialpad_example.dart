import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class DialPadExample extends StatelessWidget {
  static const String name = 'DialPad';

  const DialPadExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      name: name,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZetaDialPad(),
            ],
          ),
        ],
      ),
    );
  }
}
