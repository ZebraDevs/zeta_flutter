import 'package:flutter/material.dart';
import 'package:zeta_example/pages/theme/color_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

Widget colorUseCase(BuildContext context) => ColorBody();

class ColorBody extends StatelessWidget {
  const ColorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      final colors = Zeta.of(context).colors;

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
      final Map<String, Color> backdrop = {
        'surfacePrimary': colors.surfacePrimary,
        'surfaceDisabled': colors.surfaceDisabled,
        'surfaceHover': colors.surfaceHover,
        'surfaceSecondary': colors.surfaceSecondary,
        'surfaceTertiary': colors.surfaceTertiary,
        'surfaceSelectedHover': colors.surfaceSelectedHover,
        'surfaceSelected': colors.surfaceSelected,
      };
      final Map<String, Color> alerts = {
        'positive': colors.surfacePositive,
        'negative': colors.surfaceNegative,
        'warning': colors.surfaceWarning,
        'info': colors.surfaceInfo,
      };

      return DefaultTextStyle(
        style: ZetaTextStyles.displayMedium.apply(
          color: Zeta.of(context).colors.cool,
          decoration: TextDecoration.none,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: ZetaSpacing.l),
          child: SingleChildScrollView(
            key: PageStorageKey(0),
            child: Column(
              children: [
                const SizedBox(height: ZetaSpacing.l),
                MyRow(children: textIcon, title: 'Text and icon styles'),
                MyRow(children: border, title: 'Border styles'),
                MyRow(children: backdrop, title: 'Backdrop colors'),
                MyRow(children: alerts, title: 'Alert colors'),
                Row(children: [Text('Full color swatches')]).paddingVertical(ZetaSpacing.x8),
                ...swatches.entries.map(
                  (value) {
                    return Row(
                      children: List.generate(10, (index) => 100 - (10 * index)).map(
                        (e) {
                          return Expanded(
                            child: Container(
                              height: constraints.maxWidth / 10,
                              color: value.value[e],
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DefaultTextStyle(
                                      style: ZetaTextStyles.bodyMedium.copyWith(
                                        color: calculateTextColor(value.value[e] ?? Colors.white),
                                      ),
                                      child: Column(
                                        children: [
                                          Text('${value.key.toLowerCase().replaceAll(' ', '')}-$e'),
                                          Text(
                                            value.value[e].toString().replaceAll('Color(0xff', '#').substring(0, 7),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
                const SizedBox(height: ZetaSpacing.l),
              ],
            ),
          ),
        ),
      );
    });
  }
}
