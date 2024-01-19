import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_example/pages/theme/color_example.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

WidgetbookComponent colorWidgetBook() {
  return WidgetbookComponent(
    name: 'Colors',
    useCases: [
      WidgetbookUseCase(
        name: 'Light Mode',
        builder: (BuildContext context) {
          return ZetaProvider(
            initialThemeMode: ThemeMode.light,
            builder: (_, __, ___) => ColorBody(),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Dark Mode',
        builder: (BuildContext context) {
          return ZetaProvider(
            initialThemeMode: ThemeMode.dark,
            builder: (_, __, ___) => ColorBody(),
          );
        },
      )
    ],
  );
}

class ColorBody extends StatelessWidget {
  const ColorBody({
    super.key,
  });

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

      final Map<String, Color> alerts = {
        'positive': colors.positive,
        'negative': colors.negative,
        'warning': colors.warning,
        'info': colors.info,
      };

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.l),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: Dimensions.l),
              MyRow(children: textIcon, title: 'Text and icon styles'),
              MyRow(children: border, title: 'Border styles'),
              MyRow(children: links, title: 'Links'),
              MyRow(children: backdrop, title: 'Backdrop colors'),
              MyRow(children: alerts, title: 'Alert colors'),
              Row(children: [Text('Full color swatches', style: ZetaTextStyles.displayMedium)])
                  .paddingVertical(Dimensions.x8),
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
              const SizedBox(height: Dimensions.l),
            ],
          ),
        ),
      );
    });
  }
}
