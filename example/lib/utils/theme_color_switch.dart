import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeColorSwitch extends StatefulWidget {
  ZetaThemeColorSwitch({super.key});

  @override
  State<ZetaThemeColorSwitch> createState() => _ZetaThemeColorSwitchState();
}

class _ZetaThemeColorSwitchState extends State<ZetaThemeColorSwitch> {
  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);
    final zetaProvider = ZetaProvider.of(context);

    final Map<String?, Widget> items = {};
    items.putIfAbsent(null, () => ZetaIcon(ZetaIcons.block));

    zetaProvider.customThemes.forEach((e) {
      final color = e.primary;
      final name = e.id;
      items.putIfAbsent(
        name,
        () => ZetaAvatar(
          size: ZetaAvatarSize.xxs,
          backgroundColor: zeta.colors.surfaceDefault,
          image: ZetaIcon(
            Icons.color_lens,
            color: color ??
                (Zeta.of(context).brightness == Brightness.light
                    ? ZetaPrimitivesLight().blue
                    : ZetaPrimitivesDark().blue),
          ),
        ),
      );
    });

    return DropdownButtonHideUnderline(
      child: DropdownButton<String?>(
        value: zeta.customThemeId,
        elevation: 0,
        padding: EdgeInsets.all(8),
        icon: ZetaNothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: items.entries
            .map((e) => DropdownMenuItem<String?>(
                  value: e.key,
                  alignment: Alignment.center,
                  child: e.value,
                ))
            .toList(),
        onChanged: (value) {
          ZetaProvider.of(context).updateCustomTheme(themeId: value);
        },
      ),
    );
  }
}
