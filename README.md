# Zeta Flutter

Zeta is the new, formal, standardized Zebra Design System based off the successes of ZDS (Zebra Design System).

Note: This package is in pre-release, and so many aspects are incomplete.

# Usage

[Install zeta_flutter](https://pub.dev/packages/zeta_flutter/install)

Zeta extends the use of Flutter's built in theming tools, and so to work correctly your app needs to be wrapped with the zeta theme as such:

```dart

 @override
  Widget build(BuildContext context) {
    return Zeta(
      builder: (context, theme, colors) {
        return MaterialApp.router(theme: theme, routerConfig: router);
      },
    );
  }
```

This returns the Zeta theme and colors, which will be used across the app. Custom `ThemeData` and `ZetaColor` objects can be passed in to apply custom themes and colors.

## Viewing the components

To view examples of all the components in the library, you can run the example app in this repo or go to [Zeta](https://zeta-ds.web.app/)

## Licensing

This software is licensed with the MIT license (see [LICENSE](./LICENSE)).

---

### Pre release TODOs

[ ] TODO: update actions

[ ] TODO: Make public repo

[ ] TODO: Add to pub.dev
