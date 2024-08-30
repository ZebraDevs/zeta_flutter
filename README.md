# Zeta Flutter

Zeta is the new, formal, standardized Zebra Design System based off the successes of ZDS (Zebra Design System).

> 🚧 **Note**: This package is in pre-release, and so many aspects are incomplete.

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

To view examples of all the components in the library, you can pull this repo and run either the example app or widgetbook instance.

You can also view the latest release at [Zeta](https://zeta-ds.web.app/) or the latest commits to main [here](https://zeta-flutter-main.web.app/).

## Template

If you are starting a new project using Zeta, we recommend starting with [Zeta Flutter Template](https://github.com/zebradevs/zeta_flutter_template). This template project handles the basic app setup, but these steps can also be followed [below](#Usage).

## Usage

Zeta offers flexibility in theming through its `ZetaProvider` widget. Here's a breakdown of its features:

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

### Building Your App with Zeta Theming

The `builder` function is used to construct the widget tree with the provided theming information. This function is expected to receive a `BuildContext`, `ZetaThemeData`, and `ThemeMode` as arguments, and it should return a `Widget`.

```dart
builder: (context, themeData, themeMode) {
  // Your app's widget tree here
}
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

With these configurations, Zeta makes it easy to achieve consistent theming throughout your Flutter application.

## Licensing

This software is licensed with the MIT license (see [LICENSE](./LICENSE) and [THIRD PARTY LICENSES](./LICENSE-3RD-PARTY)).

---

hi
