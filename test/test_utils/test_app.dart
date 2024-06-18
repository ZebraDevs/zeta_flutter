import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TestApp extends StatelessWidget {
  const TestApp({
    super.key,
    required this.home,
    this.screenSize,
    this.themeMode,
    this.removeBody = true,
    this.rounded,
  });

  final Widget home;
  final Size? screenSize;
  final ThemeMode? themeMode;
  final bool removeBody;
  final bool? rounded;

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      initialThemeMode: themeMode ?? ThemeMode.system,
      initialThemeData: ZetaThemeData(rounded: rounded ?? true),
      builder: (context, themeData, themeMode) {
        return MaterialApp(
          // debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: themeData.fontFamily,
            colorScheme: themeData.colorsLight.toScheme(),
            textTheme: zetaTextTheme,
          ),
          darkTheme: ThemeData(
            fontFamily: themeData.fontFamily,
            colorScheme: themeData.colorsDark.toScheme(),
            textTheme: zetaTextTheme,
          ),
          home: Scaffold(
            body: removeBody
                ? home
                : SizedBox(
                    width: screenSize?.width,
                    height: screenSize?.height,
                    child: MediaQuery(
                      data: MediaQueryData(size: Size(screenSize?.width ?? 0, screenSize?.height ?? 0)),
                      child: SingleChildScrollView(child: home),
                    ),
                  ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Size?>('screenSize', screenSize))
      ..add(EnumProperty<ThemeMode?>('themeMode', themeMode))
      ..add(DiagnosticsProperty<bool>('removeBody', removeBody))
      ..add(DiagnosticsProperty<bool?>('rounded', rounded));
  }
}
