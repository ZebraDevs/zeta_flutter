import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

/// Only used for testing purposes.
///
/// Widget used to provide a consistent environment for testing.
class TestApp extends StatelessWidget {
  /// Default constructor for the [TestApp] widget.
  const TestApp({
    super.key,
    required this.home,
    this.screenSize,
    this.themeMode,
    this.removeBody = true,
    this.rounded,
    this.contrast,
  });

  /// The widget to be tested.
  final Widget home;

  /// The size of the screen.
  final Size? screenSize;

  /// The theme mode for the app.
  final ThemeMode? themeMode;

  /// Whether to remove the body of the scaffold.
  final bool removeBody;

  /// Whether to use rounded corners.
  final bool? rounded;

  /// The contrast for the app.
  final ZetaContrast? contrast;

  @override
  Widget build(BuildContext context) {
    return ZetaProvider(
      initialThemeMode: themeMode ?? ThemeMode.system,
      initialRounded: rounded ?? true,
      customLoadingWidget: const SizedBox(),
      initialContrast: contrast ?? ZetaContrast.aa,
      builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp(
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: Scaffold(
            backgroundColor: Zeta.of(context).colors.surfaceWarm,
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
      ..add(DiagnosticsProperty<bool?>('rounded', rounded))
      ..add(EnumProperty<ZetaContrast?>('contrast', contrast));
  }
}
