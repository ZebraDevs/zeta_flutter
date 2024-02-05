import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class TestWidget extends StatelessWidget {
  final Size? screenSize;
  final Widget widget;
  final ThemeMode? themeMode;
  final bool removeBody;

  const TestWidget({
    required this.widget,
    this.screenSize,
    super.key,
    this.themeMode,
    this.removeBody = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = screenSize ?? const Size(1280, 720);

    return ZetaProvider(
      initialThemeMode: themeMode ?? ThemeMode.system,
      builder: (context, theme, __) {
        return Builder(
          builder: (context) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: theme.fontFamily,
                colorScheme: theme.colorsLight.toScheme(),
                textTheme: zetaTextTheme,
              ),
              darkTheme: ThemeData(
                fontFamily: theme.fontFamily,
                colorScheme: theme.colorsDark.toScheme(),
                textTheme: zetaTextTheme,
              ),
              home: Scaffold(
                body: removeBody
                    ? widget
                    : SizedBox(
                        width: size.width,
                        height: size.height,
                        child: MediaQuery(
                          data: MediaQueryData(size: Size(size.width, size.height)),
                          child: SingleChildScrollView(child: widget),
                        ),
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
