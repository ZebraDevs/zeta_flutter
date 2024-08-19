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
        final blockSize = constraints.maxWidth / 11;
        final Map<String, ZetaColorSwatch> primitives = {
          'cool': colors.primitives.cool,
          'warm': colors.primitives.warm,
          'blue': colors.primitives.blue,
          'green': colors.primitives.green,
          'red': colors.primitives.red,
          'orange': colors.primitives.orange,
          'purple': colors.primitives.purple,
          'yellow': colors.primitives.yellow,
          'teal': colors.primitives.teal,
          'pink': colors.primitives.pink,
        };
        final Map<String, Color> primitivesPure = {
          'white': colors.primitives.pure.shade0,
          'mid': colors.primitives.pure.shade500,
          'black': colors.primitives.pure.shade1000,
        };

        final Map<String, Color> mainColors = {
          'defaultColor': colors.main.defaultColor,
          'subtle': colors.main.subtle,
          'light': colors.main.light,
          'inverse': colors.main.inverse,
          'disabled': colors.main.disabled,
          'primary': colors.main.primary,
          'secondary': colors.main.secondary,
          'positive': colors.main.positive,
          'warning': colors.main.warning,
          'negative': colors.main.negative,
          'info': colors.main.info,
        };
        final Map<String, Color> borderColors = {
          'defaultColor': colors.border.defaultColor,
          'subtle': colors.border.subtle,
          'hover': colors.border.hover,
          'selected': colors.border.selected,
          'disabled': colors.border.disabled,
          'pure': colors.border.pure,
          'primaryMain': colors.border.primaryMain,
          'primary': colors.border.primary,
          'secondary': colors.border.secondary,
          'positive': colors.border.positive,
          'warning': colors.border.warning,
          'negative': colors.border.negative,
          'info': colors.border.info,
        };
        final Map<String, Color> surfaceColors = {
          'defaultColor': colors.surface.defaultColor,
          'defaultInverse': colors.surface.defaultInverse,
          'hover': colors.surface.hover,
          'selected': colors.surface.selected,
          'selectedHover': colors.surface.selectedHover,
          'disabled': colors.surface.disabled,
          'cool': colors.surface.cool,
          'warm': colors.surface.warm,
          'primary': colors.surface.primary,
          'primarySubtle': colors.surface.primarySubtle,
          'secondary': colors.surface.secondary,
          'secondarySubtle': colors.surface.secondarySubtle,
          'positive': colors.surface.positive,
          'positiveSubtle': colors.surface.positiveSubtle,
          'warning': colors.surface.warning,
          'warningSubtle': colors.surface.warningSubtle,
          'negative': colors.surface.negative,
          'negativeSubtle': colors.surface.negativeSubtle,
          'info': colors.surface.info,
          'infoSubtle': colors.surface.infoSubtle,
        };
        final Map<String, Color> avatarColors = {
          'blue': colors.surface.avatar.blue,
          'green': colors.surface.avatar.green,
          'orange': colors.surface.avatar.orange,
          'pink': colors.surface.avatar.pink,
          'purple': colors.surface.avatar.purple,
          'teal': colors.surface.avatar.teal,
          'yellow': colors.surface.avatar.yellow,
        };
        final Map<String, Color> disabled = {
          'disabled': colors.state.disabled.disabled,
        };
        final Map<String, Color> defaultColors = {
          'enabled': colors.state.defaultColor.enabled,
          'hover': colors.state.defaultColor.hover,
          'selected': colors.state.defaultColor.selected,
          'focus': colors.state.defaultColor.focus,
        };
        final Map<String, Color> primary = {
          'enabled': colors.state.primary.enabled,
          'hover': colors.state.primary.hover,
          'selected': colors.state.primary.selected,
          'focus': colors.state.primary.focus,
        };
        final Map<String, Color> secondary = {
          'enabled': colors.state.secondary.enabled,
          'hover': colors.state.secondary.hover,
          'selected': colors.state.secondary.selected,
          'focus': colors.state.secondary.focus,
        };
        final Map<String, Color> positive = {
          'enabled': colors.state.positive.enabled,
          'hover': colors.state.positive.hover,
          'selected': colors.state.positive.selected,
          'focus': colors.state.positive.focus,
        };
        final Map<String, Color> negative = {
          'enabled': colors.state.negative.enabled,
          'hover': colors.state.negative.hover,
          'selected': colors.state.negative.selected,
          'focus': colors.state.negative.focus,
        };
        final Map<String, Color> info = {
          'enabled': colors.state.info.enabled,
          'hover': colors.state.info.hover,
          'selected': colors.state.info.selected,
          'focus': colors.state.info.focus,
        };
        final Map<String, Color> inverse = {
          'enabled': colors.state.inverse.enabled,
          'hover': colors.state.inverse.hover,
          'selected': colors.state.inverse.selected,
          'focus': colors.state.inverse.focus,
        };

        return ExampleScaffold(
          name: ColorExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
            child: Column(
              children: [
                Text('Semantic colors', style: ZetaTextStyles.displaySmall),
                MyRow(children: mainColors, title: 'Main Colors'),
                MyRow(children: borderColors, title: 'Main Colors'),
                MyRow(children: surfaceColors, title: 'Surface Colors'),
                MyRow(children: avatarColors, title: 'Surface / Avatar  Colors'),
                MyRow(children: disabled, title: 'State / disabled  Colors'),
                MyRow(children: defaultColors, title: 'State / default  Colors'),
                MyRow(children: primary, title: 'State / primary  Colors'),
                MyRow(children: secondary, title: 'State / secondary  Colors'),
                MyRow(children: positive, title: 'State / positive  Colors'),
                MyRow(children: negative, title: 'State / negative  Colors'),
                MyRow(children: info, title: 'State / info  Colors'),
                MyRow(children: inverse, title: 'State / inverse  Colors'),

                Row(children: [
                  Text('Full color swatches', style: ZetaTextStyles.displayMedium),
                ]).paddingVertical(Zeta.of(context).spacing.xl_4),
                Row(
                  children: primitivesPure.entries
                      .map(
                        (value) => SwatchBox(
                          color: value.value,
                          name: 'pure',
                          blockSize: blockSize,
                          value: value.key == 'mid'
                              ? 500
                              : value.key == 'white'
                                  ? 0
                                  : 1000,
                        ),
                      )
                      .toList(),
                ),
                ...primitives.entries
                    .map(
                      (value) => Row(
                          children: List.generate(10, (index) => 100 - (10 * index))
                              .map(
                                (e) => SwatchBox(
                                  color: value.value[e] ?? Colors.white,
                                  name: value.key,
                                  blockSize: blockSize,
                                  value: e,
                                ),
                              )
                              .toList()),
                    )
                    .toList(),

                //       ElevatedButton(
                //         onPressed: () => setState(() => showGeneratedColors = !showGeneratedColors),
                //         child: const Text('Toggle generated colors').paddingAll(Zeta.of(context).spacing.medium),
                //       ).paddingAll(Zeta.of(context).spacing.medium),
                //       if (showGeneratedColors)
                //         Row(children: [Text('Generated color swatches', style: ZetaTextStyles.displayMedium)])
                //             .paddingVertical(Zeta.of(context).spacing.xl_4),
                //       if (showGeneratedColors)
                //         ...generatedSwatches.entries.map(
                //           (value) => Row(
                //             children: List.generate(11, (index) => 110 - (10 * index))
                //                 .map(
                //                   (e) => Expanded(
                //                     child: Container(
                //                       height: constraints.maxWidth / 10,
                //                       color: e == 110 ? colors.surface.primary : value.value[e],
                //                       child: e == 110
                //                           ? Nothing()
                //                           : FittedBox(
                //                               fit: BoxFit.scaleDown,
                //                               child: Column(
                //                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                                 children: [
                //                                   DefaultTextStyle(
                //                                     style: ZetaTextStyles.bodyMedium
                //                                         .copyWith(color: calculateTextColor(value.value[e] ?? Colors.white)),
                //                                     child: Column(
                //                                       children: [
                //                                         Text('${value.key.toLowerCase().replaceAll(' ', '')}-$e'),
                //                                         Text(
                //                                           value.value[e]
                //                                               .toString()
                //                                               .replaceAll('Color(0xff', '#')
                //                                               .substring(0, 7),
                //                                         ),
                //                                       ],
                //                                     ),
                //                                   ),
                //                                 ],
                //                               ),
                //                             ),
                //                     ),
                //                   ),
                //                 )
                // .toList(),
                // ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SwatchBox extends StatelessWidget {
  const SwatchBox({super.key, required this.color, required this.name, required this.blockSize, required this.value});

  final Color color;
  final int value;
  final String name;
  final double blockSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: blockSize,
      width: blockSize,
      color: color,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          DefaultTextStyle(
            style: ZetaTextStyles.bodyMedium.copyWith(color: calculateTextColor(color)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${name.toLowerCase().replaceAll(' ', '')}-$value'),
                Text(color.toString().replaceAll('Color(0xff', '#').substring(0, 7)),
              ],
            ),
          ),
        ]),
      ),
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
