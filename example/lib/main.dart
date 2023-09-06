import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() => runApp(const ZetaExample());

class ZetaExample extends StatelessWidget {
  const ZetaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Zeta(
      builder: (context, theme, colors) {
        return MaterialApp.router(theme: theme, routerConfig: router);
      },
    );
  }
}
