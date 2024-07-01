# Example

## Template

To quickly set up a new project to use zeta_flutter, clone [zeta_flutter_template](https://github.com/zebradevs/zeta_flutter_template) to get started.

## ZetaProvider

The ZetaProvider class is used to encapsulate theming information and provide it to the widget tree in a Flutter application. It allows for customization of the initial theme mode, contrast, and theme data, and provides a builder function to construct the widget tree based on the provided theming information.

This provider should be the highest level widget in the application, to ensure that theme values are populated throughout the app.
//TODO: Update this

```dart
 return ZetaProvider(
    themeService: themeService,
    initialContrast: initialContrast,
    initialThemeData: initialThemeData,
    initialThemeMode: initialThemeMode,
    builder: (context, themeData, themeMode) {
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: light.surfaceTertiary,
            colorScheme: themeData.colorsLight.toScheme(),
            textTheme: zetaTextTheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: dark.surfaceTertiary,
            colorScheme: themeData.colorsDark.toScheme(),
            textTheme: zetaTextTheme,
          ),
        );
      },
    );
```
