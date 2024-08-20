import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ZetaExample());
}

class ZetaExample extends StatelessWidget {
  const ZetaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ZetaProvider.base(
      builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
        );
      },
    );
  }
}
