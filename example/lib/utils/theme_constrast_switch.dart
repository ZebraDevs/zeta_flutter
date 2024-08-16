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
        icon: Nothing(),
        dropdownColor: zeta.colors.border.disabled,
        items: _themes.map((e) {
          final colors = e == ZetaContrast.aa
              ? ZetaSemanticColorsAA(primitives: Zeta.of(context).colors.primitives)
              : ZetaSemanticColorsAAA(primitives: Zeta.of(context).colors.primitives);
          return DropdownMenuItem<ZetaContrast>(
            value: e,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: colors.surface.defaultColor,
              initials: e.name.toUpperCase(),
              initialTextStyle: TextStyle(
                fontSize: 14,
                letterSpacing: Zeta.of(context).spacing.none,
                color: colors.main.primary,
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
