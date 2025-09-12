import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class GlobalHeaderExample extends StatelessWidget {
  static final name = "GlobalHeader";
  const GlobalHeaderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(name: "Global Header", children: [
      ZetaGlobalHeader(
        platformName: "Platform Name",
      ),
    ]);
  }
}
