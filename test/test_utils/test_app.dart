import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TestApp extends StatelessWidget {
  const TestApp({super.key, required this.home});
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      builder: (context, themeData, themeMode) {
        return MaterialApp(
          home: Builder(
            builder: (context) {
              return home;
            },
          ),
        );
      },
    );
  }
}
