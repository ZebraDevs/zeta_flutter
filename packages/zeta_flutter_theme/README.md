# Zeta Flutter Theme

Theme resources for zeta_flutter form Zebra Technologies.

These resources are a part of the Zeta Design System, and can be used either on their own or with [Zeta Flutter](https://pub.dev/packages/zeta_flutter)

## Template

To quickly set up a new project to use zeta_flutter, clone [zeta_flutter_template](https://github.com/zebradevs/zeta_flutter_template) to get started.

## Set up

To use Zeta theme in you app, first the whole app must be wrapped with `ZetaProvider`. The easiest way to do this is with the `ZetaProvider`.

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

### Colors

This package contains the color resources used by Zeta. These files are automatically generated from our [Zeta Foundations Figma](https://www.figma.com/design/REjc5TauZb2EXYouaEKTYa/Zeta-Foundations), ensuring that the token names match with any designs that use Zeta.
Custom colors can be passed into `ZetaProvider`. These must follow the same pattern as is defined in the interface for ZetaColors.

### Contrast

Apps using Zeta for theming can use either `ZetaContrast.AA` or `ZetaContrast.AAA`. AA is regular contrast and AAA is high contrast according to [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html). This affects most colors in [ZetaColors] object.

### Typography

This package contains the typography styles from [Zeta Foundations Figma](https://www.figma.com/design/REjc5TauZb2EXYouaEKTYa/Zeta-Foundations), and this library provides access to [IBM Plex Sans](https://github.com/IBM/plex), Copyright © 2017 IBM Corp, see [LICENSE-3RD-PARTY](https://github.com/ZebraDevs/zeta_flutter/tree/develop/packages/zeta_flutter_theme/LICENSE-3RD-PARTY)

### Rounded

Zeta includes a rounded boolean that can be used to toggle the app between using round and sharp variants of components
