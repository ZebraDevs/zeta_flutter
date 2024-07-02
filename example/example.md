## Set up

To use Zeta components in you app, first the whole app must be wrapped with `ZetaProvider`. The easiest way to do this is with the custom builder `ZetaProvider.custom`.
You can provide initial values for `ThemeData`, `ThemeMode`, `contrast` and `ZetaThemeData`.

* `initialThemeData` allows you to extend an existing Flutter themeData to use alongside the `Zeta` theme.
* `initialThemeMode` sets whether the app starts in light or dark mode, or uses the device default.
* `initialContrast` sets whether the app starts with standard (WCAG AA) contrast, or if it attempts to use the more accessible contrast (WCAG AAA).
* `initialZetaThemeData` allows you to override the Zeta theme with a custom theme.

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