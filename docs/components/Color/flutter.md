## ZetaColors Usage

To import ZetaColors into a Dart file:

```dart
import 'package:zeta_flutter/zeta_flutter.dart';
```

### Example

ZetaColors should be an app-wide parameter, to ensure colors throughout an app stay consistent. As such, it should be created at the highest level of an app, from where it can be distributed.

```dart
import 'package:zeta_flutter/zeta_flutter.dart';

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /// Build colors object with custom colors.
    final ZetaColors colors = ZetaColors(
        /// Add custom colors here.
    );

    /// Wrap whole app with [Zeta] to provide theming.
    return Zeta(
        colors: colors,
        builder: (BuildContext context, ThemeData theme, ZetaColors colors) => ZetaColorExample(),
    );
  }
}

class ZetaColorExample extends StatelessWidget{
  const ZetaColorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final ZetaColors colors = ZetaColors.of(context);

    return Container(
        color: colors.red,
    );
  }
}

```

### ZetaColors

ZetaColors provides a full range of colors to be used, with various modifiers to return colors based on function.

The following colors are provided as `ZetaColorSwatch`:

- primary
- secondary
- cool (grey)
- warm (grey)
- blue
- red
- green
- orange
- purple
- yellow
- teal
- pink

When creating a custom ZetaColors object, colors should be provided as a full `ZetaColorSwatch`, unless you want to use the default values, which are described in `ZetaColorBase`.

ZetaColors has the following modifiers:

- primary, onPrimary
- secondary, onSecondary
- positive, onPositive, negative, onNegative, warning, onWarning, info, onInfo
- surface, onSurface, surfaceDisabled, surfaceHovered, surfaceSecondary, surfaceTertiary, surfaceSelectedHovered, surfaceSelected
- background, onBackground
- textDefault, textSubtle, textDisabled, textInverse,
- borderDefault, borderSubtle, borderDisabled, borderSelected,
- white, black
- link, linkVisited,
- textLightMode, textDarkMode

Commonly, `ZetaColors.toColorScheme` should be used to create a color scheme for use with `MaterialApp`.

### ZetaColorSwatch

ZetaColorSwatch returns a swatch of colors with shades at 10, 20, 30, 40, 50, 60, 70, 80, 90 and 100 where the higher the value, the darker the color.

ZetaColorSwatch has the following modifiers:

- primary
- icon
- border, borderSubtle
- surface
- subtle
- on
- disabled

ZetaColorSwatch can be generated from a single color, but this is not recommended as results may not look as expected, and will probably not conform to any accessability requirements.
