import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class _ZetaAddon {
  final bool rounded;
  final ThemeMode themeMode;
  final ZetaContrast contrast;

  const _ZetaAddon(this.rounded, this.themeMode, this.contrast);
}

class ZetaAddon extends WidgetbookAddon<_ZetaAddon> {
  final _ZetaAddon data;

  ZetaAddon({this.data = const _ZetaAddon(false, ThemeMode.system, ZetaContrast.aa)}) : super(name: 'Theme');

  @override
  Widget buildUseCase(BuildContext context, Widget child, _ZetaAddon data) {
    return ZetaProvider.base(
      initialRounded: data.rounded,
      initialThemeMode: data.themeMode,
      initialContrast: data.contrast,
      builder: (context, light, dark, mode) {
        return MaterialApp(
          theme: light,
          darkTheme: dark,
          themeMode: mode,
          home: child,
          debugShowCheckedModeBanner: false,
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
  _ZetaAddon valueFromQueryGroup(Map<String, String> group) {
    return _ZetaAddon(
      group['Rounded'] == 'Rounded'
          ? true
          : group['Rounded'] == 'Sharp'
              ? false
              : data.rounded,
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
