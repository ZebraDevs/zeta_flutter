import 'package:flutter/material.dart';
import 'package:zeta_example/pages/theme/color_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

import '../../utils/scaffold.dart';

Widget colorUseCase(BuildContext context) => ColorBody();

class ColorBody extends StatelessWidget {
  const ColorBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Zeta.of(context).colors;

    return WidgetbookScaffold(builder: (context, constraints) {
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

      return SingleChildScrollView(
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
          ],
        ),
      );
    });
  }
}
