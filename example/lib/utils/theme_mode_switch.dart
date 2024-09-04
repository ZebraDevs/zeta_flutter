import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeModeSwitch extends StatelessWidget {
  ZetaThemeModeSwitch({super.key});

  late final _themes = [
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark,
  ];

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final colors = zeta.colors;

    return DropdownButtonHideUnderline(
      child: DropdownButton<ThemeMode>(
        padding: EdgeInsets.all(8),
        value: zeta.themeMode,
        elevation: 0,
        icon: Nothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: _themes.map((e) {
          return DropdownMenuItem<ThemeMode>(
            value: e,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: colors.surfaceDefault,
              image: ZetaIcon(
                e == ThemeMode.system
                    ? Icons.system_security_update_good
                    : e == ThemeMode.light
                        ? Icons.light_mode
                        : Icons.dark_mode,
                color: colors.mainPrimary,
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) {
            ZetaProvider.of(context).updateThemeMode(value);
          }
        },
      ),
    );
  }
}
