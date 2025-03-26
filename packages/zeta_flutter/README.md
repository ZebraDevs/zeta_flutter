# Zeta Flutter

Zeta is the new, formal, standardized Zebra Design System based off the successes of ZDS (Zebra Design System).

### Prerequisites

```
dart sdk: ">=3.2.0 <4.0.0"
flutter: ">=3.16.0"
```

## Installation

To install `zeta_flutter`, follow the instructions [here](https://pub.dev/packages/zeta_flutter/install).

## Example

An example app can be found in this repo under `/example`. This shows all components in an example app, as well as a widgetbook instance.

## Previewing the components

To view examples of all the components in the library, you can pull this repo and run either the example app or widgetbook instance. To see a list of all components currently built or in progress, visit [design.zebra.com](https://design.zebra.com/docs/component-status).

You can also view the latest release at [Zeta](https://design.zebra.com/flutter/widgetbook) or the latest commits to main [here](https://zeta-flutter-main.web.app/).

## Template

If you are starting a new project using Zeta, we recommend starting with [Zeta Flutter Template](https://github.com/zebradevs/zeta_flutter_template). This template project handles the basic app setup, but these steps can also be followed [below](#Usage).

## Usage

Zeta components can simply be dropped into any flutter application. For basic applications, no set up should be required.

There are two options for setting the theme mode.

## Basic Theme

In the basic mode, a light or dark theme can be used in your application. By default, light mode will be set. To change to using dark mode, pass `Brightness` into your theme within `MaterialApp`:

```dart

/// Light mode
return MaterialApp();

/// Dark mode
return MaterialApp(
  theme: ThemeData.dark(
    ...
  ),
  // OR
  theme: ThemeData(
    brightness: Brightness.dark,
    ...
    )
)
```

## Complex theme

Zeta offers flexibility in theming through its `ZetaProvider` widget. Zeta Provider takes in some initial theme values, and produces themes that are passed into your MaterialApp. This is a fully flesehd out example. See below for details on props.

```dart
return ZetaProvider(
  customThemes: [
    ZetaCustomTheme(
      id: 'purple',
      primary: ZetaPrimitivesLight().purple,
      primaryDark: ZetaPrimitivesDark().purple,
      secondary: ZetaPrimitivesLight().green,
      secondaryDark: ZetaPrimitivesDark().green,
    ),
    ZetaCustomTheme(
      id: 'green',
      primary: ZetaPrimitivesLight().green,
      primaryDark: ZetaPrimitivesDark().green,
      secondary: ZetaPrimitivesLight().blue,
      secondaryDark: ZetaPrimitivesDark().blue,
    ),
  ],
  initialContrast: ZetaContrast.aaa,
  customLoadingWidget: CircularProgressIndicator.adaptive(),
  initialRounded: false,
  initialTheme: 'purple',
  initialThemeMode: ThemeMode.dark,
  builder: (context, lightTheme, darkTheme, themeMode) {
    return MaterialApp.router(
      routerConfig: router,
      themeMode: themeMode,
      theme: lightTheme,
    );
  },
);
```

### Setting the Initial Theme Mode

Zeta allows you to specify an initial theme mode for your app, which can be one of the following:

- `ThemeMode.system`: Adheres to the system's theme.
- `ThemeMode.light`: Uses the light theme mode.
- `ThemeMode.dark`: Uses the dark theme mode.

By default, the theme mode is set to `ThemeMode.system`.

```dart
initialThemeMode: ThemeMode.system
```

### Providing Initial Theme Data

You can provide the initial theme data for the app which contains all the theming information. If you don't specify one, it will default to a basic instance of `ZetaThemeData`.

```dart
initialThemeData: ZetaThemeData()
```

### Setting the Initial Contrast

Zeta also lets you define the initial contrast setting for your app. By default, it's set to `ZetaContrast.aa`.

```dart
initialContrast: ZetaContrast.aa
```

### Constructing the ZetaProvider

To tie everything together, use the `ZetaProvider` constructor. The `builder` argument is mandatory, while the others are optional but allow you to set initial values:

```dart
 @override
  Widget build(BuildContext context) {
    return ZetaProvider(

      builder: (context, themeData, themeMode) {
        final dark = themeData.colorsDark.toScheme();
        final light = themeData.colorsLight.toScheme();
        return MaterialApp.router(
          routerConfig: router,
          themeMode: themeMode,
          theme: ThemeData(
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: light.surfaceTertiary,
            colorScheme: light,
          ),
          darkTheme: ThemeData(
            fontFamily: themeData.fontFamily,
            scaffoldBackgroundColor: dark.surfaceTertiary,
            colorScheme: dark,
          ),
        );
      },
    );
  }
```

### Customization

#### Creating custom themes

Custom themes can be made by creating `ZetaCustomTheme` objects. `ZetaCustomTheme` can be constructed by passing in a primary or secondary color and, optionally, their dark variants:

```dart
ZetaCustomTheme(
  id: 'custom-theme-red',
  primary: Colors.red,
  primaryDark : // Dark variant here,
  secondary: Colors.blue,
  secondaryDark: // Dark variant here,
)
```

Color arguments can be of type `ZetaColorSwatch`, `MaterialColor`, or `Color`. If only a `Color` is provided, Zeta will generate a `ZetaColorSwatch`. <b>To have control over every shade of a given color, we reccomend providing either a `ZetaColorSwatch` or a `MaterialColor`.</b>

If a dark variant of a color is not provided, Zeta generate one by inverting the corresponding color swatch.

#### Adding custom themes

Once you have defined the custom themes for your app, give them to the ZetaProvider by passing them through the construtor. You can also initialize the custom theme by setting the `initialTheme` argument to the id of the desired theme.

```dart
  ZetaProvider(
    initialTheme: 'custom-theme-red'
    customThemes: [
      ZetaCustomTheme(
        id: 'custom-theme-red',
        primary: Colors.red,
        secondary: Colors.purple
      ),
      ZetaCustomTheme(
        id: 'custom-theme-purple',
        primary: Colors.purple,
        secondary: Colors.green
      ),
    ]
  )
```

You can also get and set the custom themes via the `ZetaProvider`:

`ZetaProvider.of(context).customThemes`
`ZetaProvider.of(context).setCustomThemes(newCustomThemes)`

##### Changing the custom theme

To change the custom theme, call the `updateCustomTheme` function on `ZetaProvider` with an id corresponding to a `ZetaCustomTheme` object:

`ZetaProvider.of(context).updateCustomTheme('custom-theme-purple')`

If the id provided does not correspond to a given theme, Zeta will fall back to its default theme.

You can fetch the id of the currently applied custom theme via the `Zeta` object:

`Zeta.of(context).customThemeId`

This will return null if no custom theme is in use.

With these configurations, Zeta makes it easy to achieve consistent theming throughout your Flutter application.

## Licensing

This software is licensed with the MIT license (see [LICENSE](https://github.com/zebradevs/zeta_flutter/tree/main/LICENSE) and [THIRD PARTY LICENSES](https://github.com/zebradevs/zeta_flutter//tree/main/LICENSE-3RD-PARTY)).

---
