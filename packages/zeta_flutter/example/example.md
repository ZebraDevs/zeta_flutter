# zeta_flutter_theme

Theme resources for zeta_flutter.

## Template

To quickly set up a new project to use zeta_flutter, clone [zeta_flutter_template](https://github.com/zebradevs/zeta_flutter_template) to get started.

## Set up

To use Zeta components in you app, first the whole app must be wrapped with `ZetaProvider`. The easiest way to do this is with the `ZetaProvider`.

There are various values that can be passed in; the most commonly used are:

- `initialThemeMode` (optional) sets whether the app starts in light or dark mode, or uses the device default.
- `initialContrast` (optional) sets whether the app starts with standard (WCAG AA) contrast, or if it attempts to use the more accessible contrast (WCAG AAA).
- `builder` (required) is used to construct the app with all Zeta themes injected.

```dart
return ZetaProvider(
    initialThemeMode: initialThemeMode,
    initialContrast: initialContrast,
    builder: (context, lightTheme, darkTheme, themeMode) {
        /// The following is just an example of how you can use the theme in your app.
        return MaterialApp.router(
            routerConfig: router,
            themeMode: themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
        );
    },
);
```
