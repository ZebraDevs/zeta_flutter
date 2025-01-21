## Template

To quickly set up a new project to use zeta_flutter, clone [zeta_flutter_template](https://github.com/zebradevs/zeta_flutter_template) to get started.

## Set up

To use Zeta components in you app, first the whole app must be wrapped with `ZetaProvider`. The easiest way to do this is with the custom builder `ZetaProvider.custom`.
You can provide initial values for `ThemeData`, `ThemeMode`, `contrast` and `ZetaThemeData`.

* `initialThemeData` (optional) allows you to extend an existing Flutter themeData to use alongside the `Zeta` theme.
* `initialThemeMode` (optional) sets whether the app starts in light or dark mode, or uses the device default.
* `initialContrast` (optional) sets whether the app starts with standard (WCAG AA) contrast, or if it attempts to use the more accessible contrast (WCAG AAA).
* `initialZetaThemeData` (optional) allows you to override the Zeta theme with a custom theme.
*  `initialLightThemeData` and `initialDarkThemeData` (optional) allows you to use existing ThemeData objects withing zeta
* `builder` (required) is used to construct the app with all Zeta themes injected.


```dart
return ZetaProvider.base(
    initialThemeData: initialThemeData,
    initialThemeMode: initialThemeMode,
    initialContrast: initialContrast,
    initialZetaThemeData: initialZetaThemeData,
    initialRounded: initialRounded,
    builder: (context, lightTheme, darkTheme, themeMode) {
        return MaterialApp.router(
            routerConfig: router,
            themeMode: themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
        );
    },
);
```

## Using the components

Once Zeta is configured, Zeta components can be used as any other componenent, and will inherit theme and other information from `Zeta`.

```dart
Column(
    children:[
        ZetaButton(label: 'Button', onPressed: (){}),
        ZetaAvatar(),
        ZetaStatusLabel(),
        // etc...
    ]
)
```