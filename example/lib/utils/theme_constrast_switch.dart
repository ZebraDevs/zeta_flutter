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

    return DropdownButtonHideUnderline(
      child: DropdownButton<ZetaContrast>(
        value: zeta.contrast,
        padding: EdgeInsets.all(8),
        elevation: 0,
        icon: ZetaNothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: _themes.map((e) {
          final ZetaColors colors = (e == ZetaContrast.aa
              ? ZetaColorsAA(primitives: Zeta.of(context).colors.primitives)
              : ZetaColorsAAA(primitives: Zeta.of(context).colors.primitives)) as ZetaColors;
          return DropdownMenuItem<ZetaContrast>(
            value: e,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: colors.surfaceDefault,
              initials: e.name.toUpperCase(),
              initialTextStyle: TextStyle(
                fontSize: 14,
                letterSpacing: Zeta.of(context).spacing.none,
                color: colors.mainPrimary,
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
