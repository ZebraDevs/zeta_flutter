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

### Design tokens

All design tokens are generated from the [Zebra Design System Figma](https://www.figma.com/design/hvRmnZZOZrmTW0wf8hbrt5) by the [zeta repository](https://github.com/ZebraDevs/zeta) (`scripts/token_generators`), and are available on `Zeta.of(context).tokens`, or the `context.zetaTokens` shortcut:

```dart
final tokens = context.zetaTokens;

ColoredBox(color: tokens.surface.page);
Padding(padding: EdgeInsets.all(tokens.space.md));
DecoratedBox(decoration: BoxDecoration(borderRadius: tokens.radius.mdAll, boxShadow: tokens.shadow.smallSoft));
Text('Hello', style: tokens.text.bodyMedium.copyWith(color: tokens.foreground.primary));
```

- **Semantic colors**: `surface`, `foreground`, `border`, `interactive`, `feedback`, `focus`, `overlay`, `selection`, `chart`.
- **Sizes**: `space`, `radius` (plus `*All` `BorderRadius` helpers), `control`, `container`, `stroke`.
- **Typography**: `text` (`TextStyle`s). **Shadows**: `shadow` (`List<BoxShadow>`). Raw layers: `palette` and `primitives`.
- `rounded` follows the `size.shape` token unless `ZetaProvider.initialRounded` / `ZetaThemeOverride.rounded` is set.

Tokens are organised in layers that can each use their own theme: `primitivesTheme`, `paletteTheme`, `sizeTheme` and `typographyTheme`, where `zeta` is the default theme. On top of that, `colorMode` selects `light`, `dark` or `aaa`; when it is null, it follows the theme mode. `aaa` currently uses the light palette until it exists in Figma. The `breakpoint` (`mobile`, `tablet`, `desktopCompact`, `desktop`) follows the window width.

- Set them for the whole app with the `initial*` parameters on `ZetaProvider`. Change them at runtime with `ZetaProvider.of(context).updatePaletteTheme(...)` and the other `update*` methods. They are saved by the theme service.
- Override them for part of the tree, for example one frame, with `ZetaThemeOverride(paletteTheme: ZetaPaletteTheme.companion, breakpoint: ZetaBreakpoint.tablet, builder: ...)`.

`Zeta.of(context).colors`, `.spacing`, `.radius`, `.textStyles`, `.primitives` and `.semantics` are deprecated and will be removed in the next major release.

### Colors (deprecated)

This package contains the color resources used by Zeta. These files are automatically generated from our [Zeta Foundations Figma](https://www.figma.com/design/REjc5TauZb2EXYouaEKTYa/Zeta-Foundations), ensuring that the token names match with any designs that use Zeta.
Custom colors can be passed into `ZetaProvider`. These must follow the same pattern as is defined in the interface for ZetaColors.

### Contrast

Apps using Zeta for theming can use either `ZetaContrast.AA` or `ZetaContrast.AAA`. AA is regular contrast and AAA is high contrast according to [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/Understanding/contrast-minimum.html). This affects most colors in [ZetaColors] object.

### Typography

Typography tokens are available as `tokens.text`. This library bundles [IBM Plex Sans](https://github.com/IBM/plex), Copyright © 2017 IBM Corp, see [LICENSE-3RD-PARTY](https://github.com/ZebraDevs/zeta_flutter/tree/develop/packages/zeta_flutter_theme/LICENSE-3RD-PARTY)

### Rounded

Zeta includes a rounded boolean that can be used to toggle the app between using round and sharp variants of components. When it isn't set, `tokens.rounded` follows the `size.shape` token (sharp on mobile, for example) and the legacy `Zeta.rounded` is `true`.
