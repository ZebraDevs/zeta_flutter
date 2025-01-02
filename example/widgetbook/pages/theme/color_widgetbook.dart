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
        'blue': colors.surfaceAvatarBlue,
        'green': colors.surfaceAvatarGreen,
        'orange': colors.surfaceAvatarOrange,
        'pink': colors.surfaceAvatarPink,
        'purple': colors.surfaceAvatarPurple,
        'teal': colors.surfaceAvatarTeal,
        'yellow': colors.surfaceAvatarYellow,
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
