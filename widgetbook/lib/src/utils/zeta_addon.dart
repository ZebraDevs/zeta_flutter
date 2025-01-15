import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaAddonData {
  const ZetaAddonData({this.rounded = true, this.themeMode = ThemeMode.light, this.contrast = ZetaContrast.aa});
  final bool rounded;
  final ThemeMode themeMode;
  final ZetaContrast contrast;
}

class ZetaAddon extends WidgetbookAddon<ZetaAddonData> {
  ZetaAddon(this.data) : super(name: 'Theme');
  final ZetaAddonData data;

  @override
  Widget buildUseCase(BuildContext context, Widget child, ZetaAddonData setting) {
    bool isIntroduction = false;
    try {
      isIntroduction = (context.findAncestorStateOfType<State<Widgetbook>>() as dynamic).state.path == 'introduction';
    } catch (e) {
      debugPrint(e.toString());
    }

    return ZetaProvider(
      initialRounded: setting.rounded,
      initialThemeMode: setting.themeMode,
      initialContrast: setting.contrast,
      builder: (_, light, dark, themeMode) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeMode == ThemeMode.light ? light : dark,
        home: Scaffold(
          body: Builder(
            builder: (c2) {
              return ColoredBox(
                color: isIntroduction ? Colors.black : Zeta.of(c2).colors.surfaceDefault,
                child: Padding(
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(Zeta.of(c2).spacing.medium),
                                  child: child,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  List<Field> get fields {
    return [
      ListField(
        name: 'Rounded',
        values: [true, false],
        initialValue: true,
        labelBuilder: (value) => value ? 'Rounded' : 'Sharp',
      ),
      ListField(
        name: 'Theme Mode',
        values: [ThemeMode.light, ThemeMode.dark],
        initialValue: ThemeMode.light,
        labelBuilder: (value) {
          switch (value) {
            case ThemeMode.light:
              return 'Light';
            case ThemeMode.dark:
              return 'Dark';
          }
          return 'ThemeMode';
        },
      ),
      ListField(
        name: 'Contrast',
        values: [ZetaContrast.aa, ZetaContrast.aaa],
        initialValue: ZetaContrast.aa,
        labelBuilder: (value) {
          switch (value) {
            case ZetaContrast.aa:
              return 'AA';
            case ZetaContrast.aaa:
              return 'AAA';
          }
          return 'Contrast';
        },
      ),
    ];
  }

  @override
  ZetaAddonData valueFromQueryGroup(Map<String, String> group) {
    return ZetaAddonData(
        rounded: group['Rounded'] == 'Rounded'
            ? true
            : group['Rounded'] == 'Sharp'
                ? false
                : data.rounded,
        themeMode: group['Theme Mode'] == 'Dark'
            ? ThemeMode.dark
            : group['Theme Mode'] == 'Light'
                ? ThemeMode.light
                : data.themeMode,
        contrast: group['Contrast'] == 'AAA'
            ? ZetaContrast.aaa
            : group['Contrast'] == 'AA'
                ? ZetaContrast.aa
                : data.contrast);
  }
}
