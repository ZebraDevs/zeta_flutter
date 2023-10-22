import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../widgets.dart';

class ColorExample extends StatefulWidget {
  static const String name = 'Color';

  const ColorExample({super.key});

  @override
  State<ColorExample> createState() => _ColorExampleState();
}

class _ColorExampleState extends State<ColorExample> {
  bool showGeneratedColors = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final Map<String, ZetaColorSwatch> swatches = {
          'Blue': colors.blue,
          'Green': colors.green,
          'Red': colors.red,
          'Orange': colors.orange,
          'Purple': colors.purple,
          'Yellow': colors.yellow,
          'Teal': colors.teal,
          'Pink': colors.pink,
          'Grey Warm': colors.warm,
          'Grey Cool': colors.cool,
        };

        final Map<String, ZetaColorSwatch> generatedSwatches = {
          'Gen-Blue': ZetaColorSwatch.fromColor(
            colors.blue,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Blue': colors.blue,
          'Gen-Green': ZetaColorSwatch.fromColor(
            colors.green,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Green': colors.green,
          'Gen-Red': ZetaColorSwatch.fromColor(
            colors.red,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Red': colors.red,
          'Gen-Orange': ZetaColorSwatch.fromColor(
            colors.orange,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Orange': colors.orange,
          'Gen-Purple': ZetaColorSwatch.fromColor(
            colors.purple,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Purple': colors.purple,
          'Gen-Yellow': ZetaColorSwatch.fromColor(
            colors.yellow,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Yellow': colors.yellow,
          'Gen-Teal': ZetaColorSwatch.fromColor(
            colors.teal,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Teal': colors.teal,
          'Gen-Pink': ZetaColorSwatch.fromColor(
            colors.pink,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Pink': colors.pink,
          'Gen-Grey Warm': ZetaColorSwatch.fromColor(
            colors.warm,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Grey Warm': colors.warm,
          'Gen-Grey Cool': ZetaColorSwatch.fromColor(
            colors.cool,
            brightness: theme.brightness,
            contrast: colors.contrast,
          ),
          'Grey Cool': colors.cool,
        };

        final Map<String, Color> textIcon = {
          'textDefault': colors.textDefault,
          'textSubtle': colors.textSubtle,
          'textDisabled': colors.textDisabled,
          'textInverse': colors.textInverse,
        };
        final Map<String, Color> border = {
          'borderDefault': colors.borderDefault,
          'borderSubtle': colors.borderSubtle,
          'borderDisabled': colors.borderDisabled,
          'borderSelected': colors.borderSelected,
        };
        final Map<String, Color> links = {
          'linkDefault': colors.link,
          'linkVisited': colors.linkVisited,
        };
        final Map<String, Color> backdrop = {
          'surfacePrimary': colors.surfacePrimary,
          'surfaceDisabled': colors.surfaceDisabled,
          'surfaceHovered': colors.surfaceHovered,
          'surfaceSecondary': colors.surfaceSecondary,
          'surfaceTertiary': colors.surfaceTertiary,
          'surfaceSelectedHovered': colors.surfaceSelectedHovered,
          'surfaceSelected': colors.surfaceSelected,
        };

        final Map<String, Color> primaries = {
          'primaryColor': colors.primary,
          'secondaryColor': colors.secondary,
        };

        final Map<String, Color> alerts = {
          'positive': colors.positive,
          'negative': colors.negative,
          'warning': colors.warning,
          'info': colors.info,
        };

        return ExampleScaffold(
          name: ColorExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Dimensions.s),
            child: Column(
              children: [
                MyRow(children: textIcon, title: 'Text and icon styles'),
                MyRow(children: border, title: 'Border styles'),
                MyRow(children: links, title: 'Links'),
                MyRow(children: backdrop, title: 'Backdrop colors'),
                MyRow(children: primaries, title: 'Primary colors'),
                MyRow(children: alerts, title: 'Alert colors'),
                Row(children: [ZetaText.displayMedium('Full color swatches')]).squish(Dimensions.x8),
                ...swatches.entries.map(
                  (value) => Row(
                    children: List.generate(10, (index) => 100 - (10 * index))
                        .map(
                          (e) => Expanded(
                            child: Container(
                              height: constraints.maxWidth / 10,
                              color: value.value[e],
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultTextStyle(
                                      style: ZetaText.zetaBodyMedium
                                          .copyWith(color: calculateTextColor(value.value[e] ?? Colors.white)),
                                      child: Column(
                                        children: [
                                          Text('${value.key.toLowerCase().replaceAll(' ', '')}-$e'),
                                          Text(value.value[e].toString().replaceAll('Color(0xff', '#').substring(0, 7)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => showGeneratedColors = !showGeneratedColors),
                  child: const Text('Toggle generated colors').square(Dimensions.s),
                ).square(Dimensions.s),
                if (showGeneratedColors)
                  Row(children: [ZetaText.displayMedium('Generated color swatches')]).squish(Dimensions.x8),
                if (showGeneratedColors)
                  ...generatedSwatches.entries.map(
                    (value) => Row(
                      children: List.generate(11, (index) => 110 - (10 * index))
                          .map(
                            (e) => Expanded(
                              child: Container(
                                height: constraints.maxWidth / 10,
                                color: e == 110 ? colors.surface : value.value[e],
                                child: e == 110
                                    ? SizedBox()
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            DefaultTextStyle(
                                              style: ZetaText.zetaBodyMedium
                                                  .copyWith(color: calculateTextColor(value.value[e] ?? Colors.white)),
                                              child: Column(
                                                children: [
                                                  Text('${value.key.toLowerCase().replaceAll(' ', '')}-$e'),
                                                  Text(
                                                    value.value[e]
                                                        .toString()
                                                        .replaceAll('Color(0xff', '#')
                                                        .substring(0, 7),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyRow extends StatelessWidget {
  final Map<String, Color> children;
  final String title;

  const MyRow({super.key, required this.children, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ZetaText.labelLarge(title, textColor: Theme.of(context).colorScheme.textDefault),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: children.entries
                      .map(
                        (e) => AnimatedContainer(
                          height: 160,
                          width: 160,
                          color: e.value,
                          duration: const Duration(milliseconds: 250),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DefaultTextStyle(
                                  style: ZetaText.zetaBodyMedium.copyWith(color: calculateTextColor(e.value)),
                                  child: Column(
                                    children: [
                                      Text(e.key),
                                      Text(e.value.toString().replaceAll('Color(0xff', '#').substring(0, 7)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

extension StringExtension on Color {
  String get toHexString {
    return toString().substring(10, 16).toUpperCase();
  }
}

Color calculateTextColor(Color background) {
  return ThemeData.estimateBrightnessForColor(background) == Brightness.light ? Colors.black : Colors.white;
}
