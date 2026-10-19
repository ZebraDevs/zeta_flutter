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
    this.colorMode,
    this.primitivesTheme = ZetaPrimitivesTheme.zeta,
    this.paletteTheme = ZetaPaletteTheme.zeta,
    this.sizeTheme = ZetaSizeTheme.zeta,
    this.typographyTheme = ZetaTypographyTheme.zeta,
    this.breakpoint,
  });
  final bool rounded;
  final ThemeMode themeMode;
  final ZetaContrast contrast;
  final String fontFamily;

  /// null follows [themeMode].
  final ZetaColorMode? colorMode;
  final ZetaPrimitivesTheme primitivesTheme;
  final ZetaPaletteTheme paletteTheme;
  final ZetaSizeTheme sizeTheme;
  final ZetaTypographyTheme typographyTheme;

  /// null follows the window width.
  final ZetaBreakpoint? breakpoint;
}

const _auto = 'Auto';

/// Dropdown over an enum's values, labelled by name; [nullable] adds an 'Auto' (null) option.
ObjectDropdownField<T?> _enumField<T extends Enum>(String name, List<T> values, {bool nullable = false}) =>
    ObjectDropdownField<T?>(
      name: name,
      values: [if (nullable) null, ...values],
      initialValue: nullable ? null : values.first,
      labelBuilder: (value) => value?.name ?? _auto,
    );

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
      initialColorMode: setting.colorMode,
      initialPrimitivesTheme: setting.primitivesTheme,
      initialPaletteTheme: setting.paletteTheme,
      initialSizeTheme: setting.sizeTheme,
      initialTypographyTheme: setting.typographyTheme,
      breakpoint: setting.breakpoint,
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
      ObjectDropdownField(
        name: 'Rounded',
        values: [true, false],
        initialValue: true,
        labelBuilder: (value) => value ? 'Rounded' : 'Sharp',
      ),
      ObjectDropdownField(
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
      ObjectDropdownField(
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
      ObjectDropdownField<String>(
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
      ),
      _enumField('Color mode', ZetaColorMode.values, nullable: true),
      _enumField('Primitives theme', ZetaPrimitivesTheme.values),
      _enumField('Palette theme', ZetaPaletteTheme.values),
      _enumField('Size theme', ZetaSizeTheme.values),
      _enumField('Typography theme', ZetaTypographyTheme.values),
      _enumField('Breakpoint', ZetaBreakpoint.values, nullable: true),
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
      colorMode: ZetaColorMode.values.asNameMap()[group['Color mode']],
      primitivesTheme: ZetaPrimitivesTheme.values.asNameMap()[group['Primitives theme']] ?? data.primitivesTheme,
      paletteTheme: ZetaPaletteTheme.values.asNameMap()[group['Palette theme']] ?? data.paletteTheme,
      sizeTheme: ZetaSizeTheme.values.asNameMap()[group['Size theme']] ?? data.sizeTheme,
      typographyTheme: ZetaTypographyTheme.values.asNameMap()[group['Typography theme']] ?? data.typographyTheme,
      breakpoint: ZetaBreakpoint.values.asNameMap()[group['Breakpoint']],
    );
  }
}
