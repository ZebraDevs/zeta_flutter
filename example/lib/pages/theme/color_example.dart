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
    final colors = Zeta.of(context).colors;
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
          'defaultColor': colors.mainDefault,
          'subtle': colors.mainSubtle,
          'light': colors.mainLight,
          'inverse': colors.mainInverse,
          'disabled': colors.mainDisabled,
          'primary': colors.mainPrimary,
          'secondary': colors.mainSecondary,
          'positive': colors.mainPositive,
          'warning': colors.mainWarning,
          'negative': colors.mainNegative,
          'info': colors.mainInfo,
        };
        final Map<String, Color> borderColors = {
          'defaultColor': colors.borderDefault,
          'subtle': colors.borderSubtle,
          'hover': colors.borderHover,
          'selected': colors.borderSelected,
          'disabled': colors.borderDisabled,
          'pure': colors.borderPure,
          'primaryMain': colors.borderPrimaryMain,
          'primary': colors.borderPrimary,
          'secondary': colors.borderSecondary,
          'positive': colors.borderPositive,
          'warning': colors.borderWarning,
          'negative': colors.borderNegative,
          'info': colors.borderInfo,
        };
        final Map<String, Color> surfaceColors = {
          'defaultColor': colors.surfaceDefault,
          'defaultInverse': colors.surfaceDefaultInverse,
          'hover': colors.surfaceHover,
          'selected': colors.surfaceSelected,
          'selectedHover': colors.surfaceSelectedHover,
          'disabled': colors.surfaceDisabled,
          'cool': colors.surfaceCool,
          'warm': colors.surfaceWarm,
          'primary': colors.surfacePrimary,
          'primarySubtle': colors.surfacePrimarySubtle,
          'secondary': colors.surfaceSecondary,
          'secondarySubtle': colors.surfaceSecondarySubtle,
          'positive': colors.surfacePositive,
          'positiveSubtle': colors.surfacePositiveSubtle,
          'warning': colors.surfaceWarning,
          'warningSubtle': colors.surfaceWarningSubtle,
          'negative': colors.surfaceNegative,
          'negativeSubtle': colors.surfaceNegativeSubtle,
          'info': colors.surfaceInfo,
          'infoSubtle': colors.surfaceInfoSubtle,
        };
        final Map<String, Color> avatarColors = {
          'blue': colors.avatarBlue,
          'green': colors.avatarGreen,
          'orange': colors.avatarOrange,
          'pink': colors.avatarPink,
          'purple': colors.avatarPurple,
          'teal': colors.avatarTeal,
          'yellow': colors.avatarYellow,
        };
        final Map<String, Color> disabled = {
          'disabled': colors.stateDisabledDisabled,
        };
        final Map<String, Color> defaultColors = {
          'enabled': colors.stateDefaultEnabled,
          'hover': colors.stateDefaultHover,
          'selected': colors.stateDefaultSelected,
          'focus': colors.stateDefaultFocus,
        };
        final Map<String, Color> primary = {
          'enabled': colors.statePrimaryEnabled,
          'hover': colors.statePrimaryHover,
          'selected': colors.statePrimarySelected,
          'focus': colors.statePrimaryFocus,
        };
        final Map<String, Color> secondary = {
          'enabled': colors.stateSecondaryEnabled,
          'hover': colors.stateSecondaryHover,
          'selected': colors.stateSecondarySelected,
          'focus': colors.stateSecondaryFocus,
        };
        final Map<String, Color> positive = {
          'enabled': colors.statePositiveEnabled,
          'hover': colors.statePositiveHover,
          'selected': colors.statePositiveSelected,
          'focus': colors.statePositiveFocus,
        };
        final Map<String, Color> negative = {
          'enabled': colors.stateNegativeEnabled,
          'hover': colors.stateNegativeHover,
          'selected': colors.stateNegativeSelected,
          'focus': colors.stateNegativeFocus,
        };
        final Map<String, Color> info = {
          'enabled': colors.stateInfoEnabled,
          'hover': colors.stateInfoHover,
          'selected': colors.stateInfoSelected,
          'focus': colors.stateInfoFocus,
        };
        final Map<String, Color> inverse = {
          'enabled': colors.stateInverseEnabled,
          'hover': colors.stateInverseHover,
          'selected': colors.stateInverseSelected,
          'focus': colors.stateInverseFocus,
        };
        final Map<String, Color> chart = {
          'chart1Primary': colors.chart1Primary,
          'chart1Secondary': colors.chart1Secondary,
          'chart2Primary': colors.chart2Primary,
          'chart2Secondary': colors.chart2Secondary,
          'chart3Primary': colors.chart3Primary,
          'chart3Secondary': colors.chart3Secondary,
          'chart4Primary': colors.chart4Primary,
          'chart4Secondary': colors.chart4Secondary,
          'chart5Primary': colors.chart5Primary,
          'chart5Secondary': colors.chart5Secondary,
          'chart6Primary': colors.chart6Primary,
          'chart6Secondary': colors.chart6Secondary,
          'chart7Primary': colors.chart7Primary,
          'chart7Secondary': colors.chart7Secondary,
          'chart8Primary': colors.chart8Primary,
          'chart8Secondary': colors.chart8Secondary,
        };

        return ExampleScaffold(
          name: ColorExample.name,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Zeta.of(context).spacing.medium),
            child: Column(
              children: [
                Text('Semantic colors', style: Zeta.of(context).textStyles.displaySmall),
                MyRow(children: mainColors, title: 'Main Colors'),
                MyRow(children: borderColors, title: 'Main Colors'),
                MyRow(children: surfaceColors, title: 'Surface Colors'),
                MyRow(children: disabled, title: 'State / disabled  Colors'),
                MyRow(children: defaultColors, title: 'State / default  Colors'),
                MyRow(children: primary, title: 'State / primary  Colors'),
                MyRow(children: secondary, title: 'State / secondary  Colors'),
                MyRow(children: positive, title: 'State / positive  Colors'),
                MyRow(children: negative, title: 'State / negative  Colors'),
                MyRow(children: info, title: 'State / info  Colors'),
                MyRow(children: inverse, title: 'State / inverse  Colors'),
                MyRow(children: avatarColors, title: 'Avatar Colors'),
                MyRow(children: chart, title: 'Chart Colors'),
                Row(children: [
                  Text('Primitive colors', style: Zeta.of(context).textStyles.displayMedium),
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
            style: Zeta.of(context).textStyles.bodyMedium.copyWith(color: calculateTextColor(color)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${name.toLowerCase().replaceAll(' ', '')}-$value'),
                Text(
                  ''
                          '#' +
                      color.hexCode.substring(2),
                ),
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
                Text(title, style: Zeta.of(context).textStyles.labelLarge),
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
                                  style: Zeta.of(context)
                                      .textStyles
                                      .bodyMedium
                                      .copyWith(color: calculateTextColor(e.value)),
                                  child: Column(
                                    children: [
                                      Text(e.key),
                                      Text(
                                        '#' + e.value.hexCode.substring(2),
                                        maxLines: 10,
                                      )
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
