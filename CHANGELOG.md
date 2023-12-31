## [0.1.1+1] - 2023-12-01

- feature: Refactor theme declaration and introduce theme service

## [0.1.0+1] - 2023-11-28

- chore: Tidy, reorganise and prepare repo

docs: update changelog and documentation

feat(type): Add xSmall and conform to latest figma designs.

- "Refactored the ZetaColors class for better customization

The ZetaColors class was heavily refactored for better customization of variables such as brightness, contrast, color swatches, and additional color attributes. Several fields were made final for the overall class safety. This change improves color control on different themes for the application."

- "Updated the ZetaColor and Theme setup to use InheritedWidget

The ZetaDefaults class was updated to Zeta inheriting from InheritedWidget. This change allows easy access to the Zeta theme settings (contrast, theme mode, theme data, color set) from anywhere in the widget tree. The ZetaAppBuilder function was updated to take in ThemeData and ThemeMode. The ZetaProvider was added to provide Zeta theming and contrast data down the widget tree. The code for the color and typography examples was adjusted to use the new Zeta context extension, instead of using Theme.of(context) to get colorScheme. This change was crucial to simplify the process of adapting the application visuals to different themes."

- "Improve theme management functionality in Zeta

Removed code concerning getting a color's RGB hex code from 'color_extensions.dart', as it was seldom used. Updated 'zeta_flutter.dart' to unhide ZetaColorGetters. Adaptations in 'zeta.dart' included switching mediaBrightness to \_mediaBrightness for internal use and adding methods for accurate determination of color set and brightness settings based on the theme mode. Also, ZetaProvider was updated for 'system' theme mode support. example/lib/main.dart and example/lib/widgets.dart were updated to support these changes, including UI updates for seamless theme switching."

- "Add theme update function and extend ZetaColorGetters

Implemented a method in 'zeta.dart' to support updating the current theme data dynamically. Extended 'color_scheme.dart' by introducing \_ZetaColorProperties and updating ZetaColorGetters. These changes increase flexibility for theme management and provide a structured and accessible way to get Zeta colors through the theme context."

- Remove theme_extensions.dart and move contents to colors.dart

Theme extensions were deleted and its contents were moved to colors.dart to consolidate all color-related codes in one file for easier navigation and editing. Additional enhancements include optimizing color assignments and making ZetaColors immutable for more robust color management.

- Refactor code for color theme and add theme switcher

Refactored codebase to improve the color theme handling: relocated theme related methods to colors.dart from theme_extensions.dart for consolidated color theme data. Optimized color assignments by leveraging the 'copyWith' method, allowing more efficient color management. Introduced the immutability of ZetaColors to enhance robustness. Bumped version in pubspec.yaml to 0.0.1+13 due to these changes. Renamed theme.dart to theme_data.dart for more semantic file naming. Added 'identifier' to the ZetaThemeData for easier theme identification.
The visible application change is an added ThemeSwitcher in the example app, offering a UI to switch between different predefined themes.

- Add ZetaThemeService and theme switcher in example app

Implemented ZetaThemeService as an abstract class, providing structure for loading and saving themes within the app. Removed an obsolete comment within the contrast.dart and made necessary imports in zeta.dart. Asynchronous theme loading is added during app startup and saving is done upon theme updates. Also, for user-interaction, an exclusive ThemeSwitcher widget is added in the example app allowing users to select between available themes. This improves user experience, and optimizes theme handling and application performance.

- Refactor color swatch generation to utilize zeta

Refactored color swatch generation in color_example.dart to use Zeta instead of directly using the Theme. Now the brightness for ZetaColorSwatch is being pulled from zeta object rather than theme. This ensures consistency across different parts of the application where Zeta is used. Also changed theme.colorScheme.surface to colors.surfacePrimary for better readability, and alignment with use of zeta object.

- Add icon colors to color scheme

Extended the color scheme in colors.dart to include default, subtle, disabled, and inverse icon colors. These were added to ensure consistent icon colors across the application and support dark mode by allowing inverted color swatches.

- Refactor theme switch settings and add new features

Renamed 'theme_switch.dart' to 'theme_color_switch.dart' and added two new files 'theme_contrast_switch.dart' and 'theme_mode_switch.dart' in order to separate the theme settings logically into distinct features - Theme Color Switch, Theme Contrast Switch and Theme Mode Switch respectively. Also, the theme application feature has been refactored within 'widgets.dart' to use the newly created theme features instead of the old theme switch. This enhances modularity and the user's ability to switch theme settings easily.

- Update method naming for consistent architecture in text.dart

Changed the method name 'withColor' to 'themeWithColor' in text.dart for consistency with other part of the architecture and for better readability. This change supports the shift towards a consistently designed application architecture and helps developers easily decipher the role of the method in the code.

- Update color scheme mapping and library version in colors.dart and pubspec.lock

Refined the color mapping in ZetaColorScheme in colors.dart by replacing effectiveSurfaceTertiary with textDefault, enhancing the clarity of backdrop's color role. Concurrently, version of multiple dependencies in pubspec.lock are updated to benefit from recent fixes and improvements in those libraries.

- Change `Color` to `ZetaColorSwatch` in theme files

Adjusted the class references in colors.dart from `Color` to `ZetaColorSwatch` to provide a more consistent color swatch across the app. The swatch allows for more flexibility in using color variations. Adjustments were also made in color_scheme.dart and color_swatch.dart to include better explanatory messages and use standard dart documentation format. Changes in custom_docs/components/Color/flutter.md were made to align with these updates.

- Enhance contrast and color handling in theme files

Removed 'flutter.md' as it is no longer required due to improvements made in contrast and color handling. For better accessibility support, 'contrast.dart' was refactored for better contrast handling and 'color_extensions.dart' now includes a mechanism to generate color swatch based on contrast ratio. Also, 'zeta.dart' was updated to adapt to the system's brightness providing better user experience. Overall, these adjustments aim to enhance accessibility and user experience, apart from simplifying the codebase.

- Add LICENSE-3RD-PARTY for third-party libraries

Introduced license details for third-party libraries used in the project. MIT license applies to 'tinycolor' and SIL Open Font License applies to 'IBMPlexSans'. This ensures proper acknowledgement and licensure compliance for used third-party resources.

- Set up with ZDS Analysis

## [0.0.1+12] - 2023-09-06

### :wrench: Chores

- [`6a2834e`](https://github.com/zebratechnologies/zeta-flutter/commit/6a2834e762c238d3927d83a239490250b1687b64) - Tidy, reorganise and prepare repo _(commit by [@thelukewalton](https://github.com/thelukewalton))_

### :flying_saucer: Other Changes

- [`f91e8ef`](https://github.com/zebratechnologies/zeta-flutter/commit/f91e8ef85c0a1670227d66bd441513bc33e6242c) - Feature/color ([#21](https://github.com/zebratechnologies/zeta-flutter/pull/21))

* feat(color): Adding color defs

* feat(color): starting colorswatch util

* bug(quality): updating lint rules

* feat(color): adding widgetbook and tests

* bug(platforms): adding windows into example

* bug(type): Fixing reset height and tests failing _(commit by [@thelukewalton](https://github.com/thelukewalton))_

## 0.0.1+11 - 2023-08-09

### :sparkles: New Features

- [`193dc42`](https://github.com/zebratechnologies/zeta-flutter/commit/193dc42c8e7419d9087afdffce0eae915af12819) - Color ([#21](https://github.com/zebratechnologies/zeta-flutter/pull/21)) _(commit by [@thelukewalton](https://github.com/thelukewalton))_

  - [`a605819`](https://github.com/zebratechnologies/zeta-flutter/commit/a60581973764b5d06711fe6470f9963af934b7ad) - Adding color defs by [@thelukewalton](https://github.com/thelukewalton)
  - [`f519cd8`](https://github.com/zebratechnologies/zeta-flutter/commit/f519cd856c7b4793ea7e24dc16f3abba0cffcf66) - starting colorswatch util by [@thelukewalton](https://github.com/thelukewalton)
  - [`7445db0`](https://github.com/zebratechnologies/zeta-flutter/commit/7445db0b7da2434f5a55d3067369b3bd35df363b) - adding widgetbook and tests by [@thelukewalton](https://github.com/thelukewalton)

### :bug: Bug Fixes

- [`7529402`](https://github.com/zebratechnologies/zeta-flutter/commit/75294029f65d2a23cd41b5604165987fe434ea2e) - bug(quality): updating lint rules by [@thelukewalton](https://github.com/thelukewalton)
- [`3479adb`](https://github.com/zebratechnologies/zeta-flutter/commit/3479adb574c9ec1073552f888631f7cee12fe4cb) -bug(platforms): adding windows into example by [@thelukewalton](https://github.com/thelukewalton)
- [`70a6144`](https://github.com/zebratechnologies/zeta-flutter/commit/70a614446c4d526315eb3229478d89dbd1c031de) - bug(type): Fixing reset height and tests failing by [@thelukewalton](https://github.com/thelukewalton)

## 0.0.1+10 - 2023-07-11

### :sparkles: New Features

- [`546739c`](https://github.com/zebratechnologies/zeta-flutter/commit/546739c888e026b46546e22b3e1ea59c69e992d3) - Dimensions by [@thelukewalton](https://github.com/thelukewalton)

### :bug: Bug Fixes

- [`6638e94`](https://github.com/zebratechnologies/zeta-flutter/commit/6638e941b4027136c293c403c5c00e051fee5c97) - bug: Refactoring tokens by [@thelukewalton](https://github.com/thelukewalton)
- [`133a7ac`](https://github.com/zebratechnologies/zeta-flutter/commit/133a7acb3286af77a728479f8fafe9cef532130e) - bug: grid widgetbook hybrid example fix by [@thelukewalton](https://github.com/thelukewalton)

- [`988964e`](https://github.com/zebratechnologies/zeta-flutter/commit/988964e122128c4f9e4423fd849b70b6283ccea7) - removing unused dependency; by [@thelukewalton](https://github.com/thelukewalton)

## 0.0.1+9 - 2023-03-28

### :sparkles: New Features

- [`ffb9596`](https://github.com/zebratechnologies/zeta-flutter/commit/ffb9596ee04456147b87c2c35b3a08e8763bf7c2) - Typography _(commit by [@thelukewalton](https://github.com/thelukewalton))_

### :memo: Documentation Changes

- [`fb835a4`](https://github.com/zebratechnologies/zeta-flutter/commit/fb835a43a94945989d5b0793d61894ea807bc745) - Updated spacing and grid documentation and edge cases _(PR [#11](https://github.com/zebratechnologies/zeta-flutter/pull/11) by [@thelukewalton](https://github.com/thelukewalton))_
- [`2a1cea3`](https://github.com/zebratechnologies/zeta-flutter/commit/2a1cea32d40c324cf36517cf05b5bb705d6eadb3) - Update typography documentation _(PR [#16](https://github.com/zebratechnologies/zeta-flutter/pull/16) by [@thelukewalton](https://github.com/thelukewalton))_
- [`709f771`](https://github.com/zebratechnologies/zeta-flutter/commit/709f77185be705507475d90f044f94b2908fa5bb) - update docs _(PR [#17](https://github.com/zebratechnologies/zeta-flutter/pull/17) by [@thelukewalton](https://github.com/thelukewalton))_

- [`5a50e46`](https://github.com/zebratechnologies/zeta-flutter/commit/5a50e46f3500a9b186515305514839651576a444) - Update README.md ([#12](https://github.com/zebratechnologies/zeta-flutter/pull/12)), Update README.md, adding in tag to pass the CodeQL enablement exeption, - [automated commit] lint format and import sort. Co-authored-by: github-actions <github-actions@github.com> _(commit by [@knxp34](https://github.com/knxp34))_

### :bug: Bug Fixes

- [`591b757`](https://github.com/zebratechnologies/zeta-flutter/commit/591b7572ebf85da7510a8b6a3f9f8451dc93535a) - inject token to action; _(PR [#15](https://github.com/zebratechnologies/zeta-flutter/pull/15) by [@thelukewalton](https://github.com/thelukewalton))_
- [`d591856`](https://github.com/zebratechnologies/zeta-flutter/commit/d59185680879bf2f938c4f2a6bd2328f29a3ddd2) - test _(commit by [@thelukewalton](https://github.com/thelukewalton))_
- [`1dcbcae`](https://github.com/zebratechnologies/zeta-flutter/commit/1dcbcaec2600210efcefc80861c29aaa7e44c27e) - removing hardcoded shas _(PR [#19](https://github.com/zebratechnologies/zeta-flutter/pull/19) by [@thelukewalton](https://github.com/thelukewalton))_

## 0.0.1+6 - Spacing - 2023-03-06

### :sparkles: New Features

- [`a2ca78e`](https://github.com/zebratechnologies/zeta-flutter/commit/a2ca78e863405f70b8199a889be3bc4f9c61ab1a) - Spacing ([#9](https://github.com/zebratechnologies/zeta-flutter/pull/9))
  _(commit by [@thelukewalton](https://github.com/thelukewalton))_

### :bug: Bug Fixes

- [`e29e53b`](https://github.com/zebratechnologies/zeta-flutter/commit/e29e53ba132cd155f2d40f4cfa6f6c3060558b4e) - another attempt at fixing actions checkout _(PR [#8](https://github.com/zebratechnologies/zeta-flutter/pull/8) by [@thelukewalton](https://github.com/thelukewalton))_

### :memo: Documentation Changes

- [`1dc0e1b`](https://github.com/zebratechnologies/zeta-flutter/commit/1dc0e1b64cb870685110516c5159b20fb903f2c3) - Update README.md _(commit by [@benken](https://github.com/benken))_

## 0.0.1+5 - Grid - 2023-02-17

### :sparkles: New Features

- [`60527e8`](https://github.com/zebratechnologies/zeta-flutter/commit/60527e86da15b4a804990c7e67bae5c46d25dc7f) - Grid ([#1](https://github.com/zebratechnologies/zeta-flutter/pull/1))

### :bug: Bug Fixes

- [`f7a8d9a`](https://github.com/zebratechnologies/zeta-flutter/commit/f7a8d9a2ba078bf08fe80de07f6e9c871af9e451) - **actions**: Updated actions to push changelog to zeta. _(PR [#6](https://github.com/zebratechnologies/zeta-flutter/pull/6) by [@thelukewalton](https://github.com/thelukewalton))_ - actions _(commit by [@thelukewalton](https://github.com/thelukewalton))_

- [`0340212`](https://github.com/zebratechnologies/zeta-flutter/commit/0340212963606fbe755aa94cbb98d38d663a5854) - fixing action ([#4](https://github.com/zebratechnologies/zeta-flutter/pull/4))

- [`b0ad7f1`](https://github.com/zebratechnologies/zeta-flutter/commit/b0ad7f12b8b583fb928d225ce9d1c1f3244046e5) - No ticket/code examples ([#5](https://github.com/zebratechnologies/zeta-flutter/pull/5))- adding code example _(commit by [@thelukewalton](https://github.com/thelukewalton))_

- [`4acf3c1`](https://github.com/zebratechnologies/zeta-flutter/commit/4acf3c1134b6c8d17827d8e2c665250d6f6ead1d) - fix(actions) Fix action refs _(PR [#7](https://github.com/zebratechnologies/zeta-flutter/pull/7) by [@thelukewalton](https://github.com/thelukewalton))_
- [`83e073b`](https://github.com/zebratechnologies/zeta-flutter/commit/83e073b16808d89373a74dba35172bb7a978e765) - fix(actions) another attempt at fixing actions checkout _(PR [#8](https://github.com/zebratechnologies/zeta-flutter/pull/8) by [@thelukewalton](https://github.com/thelukewalton))_

## 0.0.1+1 - Initial setup

- Initial setup

[0.0.1+12]: https://github.com/zebratechnologies/zeta-flutter/compare/0.0.1+11...0.0.1+12
