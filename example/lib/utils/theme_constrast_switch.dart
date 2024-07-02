import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeContrastSwitch extends StatelessWidget {
  ZetaThemeContrastSwitch({super.key});

  late final _themes = [
    ZetaContrast.aa,
    ZetaContrast.aaa,
  ];

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    ZetaColors zetaColors(ZetaContrast contrast) {
      if (zeta.brightness == Brightness.light) {
        return zeta.themeData.apply(contrast: contrast).colorsLight;
      } else {
        return zeta.themeData.apply(contrast: contrast).colorsDark;
      }
    }

    return DropdownButtonHideUnderline(
      child: DropdownButton<ZetaContrast>(
        value: zeta.contrast,
        padding: EdgeInsets.all(8),
        elevation: 0,
        icon: Nothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: _themes.map((e) {
          final colors = zetaColors(e);
          return DropdownMenuItem<ZetaContrast>(
            value: e,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: colors.primary.surface,
              initials: e == ZetaContrast.aa ? 'AA' : 'AAA',
              initialTextStyle: TextStyle(
                fontSize: 14,
                letterSpacing: ZetaSpacing.none,
                color: colors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            ZetaProvider.of(context).updateContrast(value);
          }
        },
      ),
    );
  }
}
