import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeSwitch extends StatelessWidget {
  ZetaThemeSwitch({super.key});

  late final _themes = {
    "default": ZetaThemeData(),
    "teal": ZetaThemeData(
      identifier: 'teal',
      primary: ZetaColorBase.teal,
    ),
    "yellow": ZetaThemeData(
      identifier: 'yellow',
      primary: ZetaColorBase.yellow,
    ),
    "red": ZetaThemeData(
      identifier: 'red',
      primary: ZetaColorBase.red,
    ),
    "purple": ZetaThemeData(
      identifier: 'purple',
      primary: ZetaColorBase.purple,
    ),
  };

  @override
  Widget build(BuildContext context) {
    var zeta = Zeta.of(context);

    ZetaColors primary(ZetaThemeData data) {
      if (zeta.brightness == Brightness.light) {
        return data.colorsLight;
      } else {
        return data.colorsDark;
      }
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        elevation: 0,
        value: zeta.themeData.identifier,
        icon: SizedBox(width: 8),
        dropdownColor: zeta.colors.surfaceTertiary,
        items: _themes.entries.map((e) {
          var zetaColors = primary(_themes[e.key]!);
          var color = zetaColors.primary;

          return DropdownMenuItem<String>(
            value: e.value.identifier,
            child: CircleAvatar(
              backgroundColor: color.surface,
              foregroundColor: color,
              child: Icon(Icons.color_lens, color: color),
            ),
          );
        }).toList(),
        onChanged: (value) {
          final theme = _themes[value];
          if (theme != null) {
            ZetaProvider.of(context).updateThemeData(theme);
          }
        },
      ),
    );
  }
}
