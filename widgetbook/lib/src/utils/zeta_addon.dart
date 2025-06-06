import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaAddonData {
  const ZetaAddonData({
    this.rounded = true,
    this.themeMode = ThemeMode.light,
    this.contrast = ZetaContrast.aa,
    this.fontFamily = kZetaFontFamily,
  });
  final bool rounded;
  final ThemeMode themeMode;
  final ZetaContrast contrast;
  final String fontFamily;
}

enum BackgroundType {
  standard,
  introduction,
  dialog;

  Color color(BuildContext context) {
    switch (this) {
      case BackgroundType.standard:
        return Zeta.of(context).colors.surfaceDefault;
      case BackgroundType.introduction:
        return Colors.black;
      case BackgroundType.dialog:
        return Zeta.of(context).colors.mainLight;
    }
  }
}

class ZetaAddon extends WidgetbookAddon<ZetaAddonData> {
  ZetaAddon(this.data) : super(name: 'Theme');
  final ZetaAddonData data;

  @override
  Widget buildUseCase(BuildContext context, Widget child, ZetaAddonData setting) {
    late final BackgroundType backgroundType;
    try {
      final String path = ((context.findAncestorStateOfType<State<Widgetbook>>() as dynamic).state.path).toLowerCase();

      if (path == 'introduction') {
        backgroundType = BackgroundType.introduction;
      } else if (path.contains('dialog') || path.contains('sheet')) {
        backgroundType = BackgroundType.dialog;
      } else {
        backgroundType = BackgroundType.standard;
      }
    } catch (e) {
      debugPrint(e.toString());
      backgroundType = BackgroundType.standard;
    }

    return ZetaProvider(
      initialRounded: setting.rounded,
      initialThemeMode: setting.themeMode,
      initialContrast: setting.contrast,
      fontFamily: setting.fontFamily,
      builder: (_, light, dark, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeMode == ThemeMode.light ? light : dark,
          home: Scaffold(
            body: Builder(
              builder: (c2) {
                return ColoredBox(
                  color: backgroundType.color(c2),
                  child: Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              child,
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
        );
      },
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
      ListField<String>(
        name: 'Font family',
        values: [
          kZetaFontFamily,
          GoogleFonts.comingSoon().fontFamily ?? '',
          GoogleFonts.yrsa().fontFamily ?? '',
          GoogleFonts.oxygen().fontFamily ?? '',
          GoogleFonts.bebasNeue().fontFamily ?? '',
          GoogleFonts.dancingScript().fontFamily ?? '',
          GoogleFonts.flavors().fontFamily ?? '',
        ],
        initialValue: kZetaFontFamily,
        labelBuilder: (value) {
          if (value == kZetaFontFamily) {
            return 'Default (IBM Plex Sans)';
          } else {
            return value.split('_').join(' ');
          }
        },
      )
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
              : data.contrast,
      fontFamily: () {
        if (group['Font family'] == 'Default (IBM Plex Sans)') {
          return kZetaFontFamily;
        } else {
          try {
            return group['Font family']!.split(' ').join('_');
          } catch (e) {
            debugPrint(e.toString());
            return kZetaFontFamily;
          }
        }
      }(),
    );
  }
}
