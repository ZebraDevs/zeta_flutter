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
      final Map<String, Color> alerts = {
        'positive': colors.surface.positive,
        'negative': colors.surface.negative,
        'warning': colors.surface.warning,
        'info': colors.surface.info,
      };

      return DefaultTextStyle(
        style: ZetaTextStyles.displayMedium.apply(
          color: Zeta.of(context).colors.main.defaultColor,
          decoration: TextDecoration.none,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Zeta.of(context).spacing.xl_4),
          child: SingleChildScrollView(
            key: PageStorageKey(0),
            child: Column(
              children: [
                SizedBox(height: Zeta.of(context).spacing.xl_4),
                MyRow(children: textIcon, title: 'Text and icon styles'),
                MyRow(children: border, title: 'Border styles'),
                MyRow(children: backdrop, title: 'Backdrop colors'),
                MyRow(children: alerts, title: 'Alert colors'),
                Row(children: [Text('Full color swatches')]).paddingVertical(Zeta.of(context).spacing.xl_4),
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
                SizedBox(height: Zeta.of(context).spacing.xl_4),
              ],
            ),
          ),
        ),
      );
    });
  }
}
