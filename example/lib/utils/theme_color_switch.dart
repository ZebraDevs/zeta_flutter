import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

late final appThemes = {
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

class ZetaThemeColorSwitch extends StatelessWidget {
  ZetaThemeColorSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    ZetaColors primary(ZetaThemeData data) {
      if (zeta.brightness == Brightness.light) {
        return data.colorsLight;
      } else {
        return data.colorsDark;
      }
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: zeta.themeData.identifier,
        elevation: 0,
        alignment: Alignment.center,
        padding: EdgeInsets.all(8),
        icon: Nothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: appThemes.entries.map((e) {
          final zetaColors = primary(appThemes[e.key]!);
          final color = zetaColors.primary;
          return DropdownMenuItem<String>(
            value: e.value.identifier,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: color.surface,
              image: Icon(Icons.color_lens, color: color),
            ),
          );
        }).toList(),
        onChanged: (value) {
          final theme = appThemes[value];
          if (theme != null) {
            ZetaProvider.of(context).updateThemeData(theme);
          }
        },
      ),
    );
  }
}
