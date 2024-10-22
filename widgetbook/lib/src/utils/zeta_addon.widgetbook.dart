import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaAddonData {
  const ZetaAddonData(this.rounded, this.themeMode, this.contrast);
  final bool rounded;
  final ThemeMode themeMode;
  final ZetaContrast contrast;
}

class ZetaAddon extends WidgetbookAddon<ZetaAddonData> {
  ZetaAddon({this.data = const ZetaAddonData(false, ThemeMode.system, ZetaContrast.aa)}) : super(name: 'Theme');
  final ZetaAddonData data;

  @override
  Widget buildUseCase(BuildContext context, Widget child, ZetaAddonData setting) {
    // ZetaProvider.of(context).updateThemeMode(setting.themeMode);
    return child;
  }

  @override
  List<Field> get fields {
    return [
      ListField(
        name: 'Rounded',
        values: [true, false],
        initialValue: false,
        labelBuilder: (value) => value ? 'Rounded' : 'Sharp',
      ),
      ListField(
        name: 'Theme Mode',
        values: [ThemeMode.light, ThemeMode.dark],
        initialValue: ThemeMode.system,
        labelBuilder: (value) {
          switch (value) {
            case ThemeMode.system:
              return 'System';
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
      group['Rounded'] == 'Rounded',
      group['Theme Mode'] == 'Light'
          ? ThemeMode.light
          : group['Theme Mode'] == 'Dark'
              ? ThemeMode.dark
              : group['Theme Mode'] == 'System'
                  ? ThemeMode.system
                  : data.themeMode,
      group['Contrast'] == 'AA'
          ? ZetaContrast.aa
          : group['Contrast'] == 'AAA'
              ? ZetaContrast.aaa
              : data.contrast,
    );
  }
}
