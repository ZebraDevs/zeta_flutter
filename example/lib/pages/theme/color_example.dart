import 'package:flutter/material.dart';
import 'package:zeta_example/widgets.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

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
    final zeta = Zeta.of(context);
    final colors = zeta.colors;
    return LayoutBuilder(
      builder: (context, constraints) {
        final Map<String, ZetaColorSwatch> swatches = {
          // 'Blue': colors.blue,
          // 'Green': colors.green,
          // 'Red': colors.red,
          // 'Orange': colors.orange,
          // 'Purple': colors.purple,
          // 'Yellow': colors.yellow,
          // 'Teal': colors.teal,
          // 'Pink': colors.pink,
          // 'Grey Warm': colors.warm,
          // 'Grey Cool': colors.cool,
        };

        final Map<String, ZetaColorSwatch> generatedSwatches = {
          // 'Gen-Blue': ZetaColorSwatch.fromColor(
          //   colors.blue,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Blue': colors.blue,
          // 'Gen-Green': ZetaColorSwatch.fromColor(
          //   colors.green,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Green': colors.green,
          // 'Gen-Red': ZetaColorSwatch.fromColor(
          //   colors.red,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Red': colors.red,
          // 'Gen-Orange': ZetaColorSwatch.fromColor(
          //   colors.orange,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Orange': colors.orange,
          // 'Gen-Purple': ZetaColorSwatch.fromColor(
          //   colors.purple,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Purple': colors.purple,
          // 'Gen-Yellow': ZetaColorSwatch.fromColor(
          //   colors.yellow,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Yellow': colors.yellow,
          // 'Gen-Teal': ZetaColorSwatch.fromColor(
          //   colors.teal,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Teal': colors.teal,
          // 'Gen-Pink': ZetaColorSwatch.fromColor(
          //   colors.pink,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Pink': colors.pink,
          // 'Gen-Grey Warm': ZetaColorSwatch.fromColor(
          //   colors.warm,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Grey Warm': colors.warm,
          // 'Gen-Grey Cool': ZetaColorSwatch.fromColor(
          //   colors.cool,
          //   brightness: zeta.brightness,
          //   contrast: colors.contrast,
          // ),
          // 'Grey Cool': colors.cool,
        };

        final Map<String, Color> textIcon = {
          'main.defaultColor': colors.main.defaultColor,
          'main.subtle': colors.main.subtle,
          'main.disabled': colors.main.disabled,
          'main.inverse': colors.main.inverse,
        };
        final Map<String, Color> border = {
          'border.defaultColor': colors.border.defaultColor,
          'border.subtle': colors.border.subtle,
          'border.disabled': colors.border.disabled,
          'border.selected': colors.border.selected,
        };
        final Map<String, Color> backdrop = {
          'surface.primary': colors.surface.primary,
          'surface.disabled': colors.surface.disabled,
          'surface.hover': colors.surface.hover,
          'surface.secondary': colors.surface.secondary,
          // 'surfaceTertiary': colors.surfaceTertiary,
          'surface.selectedHover': colors.surface.selectedHover,
          'surface.selected': colors.surface.selected,
        };

        final Map<String, Color> primaries = {
          'primaryColor': colors.main.primary,
          'secondaryColor': colors.main.secondary,
        };

        final Map<String, Color> alerts = {
          'negative': colors.surface.negative,
          'warning': colors.surface.warning,
          'info': colors.surface.info,
        };

        return ExampleScaffold(
          name: ColorExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
            child: Column(
              children: [
                MyRow(children: textIcon, title: 'Text and icon styles'),
                MyRow(children: border, title: 'Border styles'),
                MyRow(children: backdrop, title: 'Backdrop colors'),
                MyRow(children: primaries, title: 'Primary colors'),
                MyRow(children: alerts, title: 'Alert colors'),
                Row(children: [Text('Full color swatches', style: ZetaTextStyles.displayMedium)])
                    .paddingVertical(Zeta.of(context).spacing.xl_4),
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
                                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                  DefaultTextStyle(
                                    style: ZetaTextStyles.bodyMedium
                                        .copyWith(color: calculateTextColor(value.value[e] ?? Colors.white)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('${value.key.toLowerCase().replaceAll(' ', '')}-$e'),
                                        Text(value.value[e].toString().replaceAll('Color(0xff', '#').substring(0, 7)),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => showGeneratedColors = !showGeneratedColors),
                  child: const Text('Toggle generated colors').paddingAll(Zeta.of(context).spacing.medium),
                ).paddingAll(Zeta.of(context).spacing.medium),
                if (showGeneratedColors)
                  Row(children: [Text('Generated color swatches', style: ZetaTextStyles.displayMedium)])
                      .paddingVertical(Zeta.of(context).spacing.xl_4),
                if (showGeneratedColors)
                  ...generatedSwatches.entries.map(
                    (value) => Row(
                      children: List.generate(11, (index) => 110 - (10 * index))
                          .map(
                            (e) => Expanded(
                              child: Container(
                                height: constraints.maxWidth / 10,
                                color: e == 110 ? colors.surface.primary : value.value[e],
                                child: e == 110
                                    ? Nothing()
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            DefaultTextStyle(
                                              style: ZetaTextStyles.bodyMedium
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
                Text(title, style: ZetaTextStyles.labelLarge),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: children.entries
                      .map(
                        (e) => AnimatedContainer(
                          height: 160,
                          width: 160,
                          color: e.value,
                          duration: ZetaAnimationLength.fast,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DefaultTextStyle(
                                  style: ZetaTextStyles.bodyMedium.copyWith(color: calculateTextColor(e.value)),
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

Color calculateTextColor(Color background) {
  return ThemeData.estimateBrightnessForColor(background) == Brightness.light ? Colors.black : Colors.white;
}
