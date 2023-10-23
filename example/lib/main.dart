import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() => runApp(const ZetaExample());

class ZetaExample extends StatelessWidget {
  const ZetaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      builder: (context, themeData, themeMode) {
        final dark = themeData.colorsDark.toScheme();
        final light = themeData.colorsLight.toScheme();
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: ThemeData(
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: light.background,
            colorScheme: light,
          ),
          darkTheme: ThemeData(
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: dark.background,
            colorScheme: dark,
          ),
        );
      },
    );
  }
}
