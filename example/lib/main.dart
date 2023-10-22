import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() => runApp(const ZetaExample());

class ZetaExample extends StatelessWidget {
  const ZetaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      initialThemeMode: ThemeMode.system,
      builder: (context, data, themeMode) {
        final dark = data.colorsDark.toScheme();
        final light = data.colorsLight.toScheme();
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: ThemeData(
            fontFamily: data.fontFamily,
            scaffoldBackgroundColor: light.background,
            colorScheme: light,
          ),
          darkTheme: ThemeData(
            fontFamily: data.fontFamily,
            scaffoldBackgroundColor: dark.background,
            colorScheme: dark,
          ),
        );
      },
    );
  }
}
