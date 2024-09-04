import 'package:flutter/material.dart';
import 'package:zeta_flutter/zeta_flutter.dart';

class ZetaThemeColorSwitch extends StatefulWidget {
  ZetaThemeColorSwitch({super.key});

  @override
  State<ZetaThemeColorSwitch> createState() => _ZetaThemeColorSwitchState();
}

class _ZetaThemeColorSwitchState extends State<ZetaThemeColorSwitch> {
  String currentTheme = "default";

  final Map<String, ZetaColorSwatch> appThemes = {
    "default": ZetaPrimitivesLight().blue,
    "teal": ZetaPrimitivesLight().teal,
    "yellow": ZetaPrimitivesLight().yellow,
    "red": ZetaPrimitivesLight().red,
    "purple": ZetaPrimitivesLight().purple,
  };

  @override
  Widget build(BuildContext context) {
    final zeta = Zeta.of(context);

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: currentTheme,
        elevation: 0,
        padding: EdgeInsets.all(8),
        icon: Nothing(),
        dropdownColor: zeta.colors.borderDisabled,
        items: appThemes.entries.map((e) {
          final color = e.value;
          final name = e.key;
          return DropdownMenuItem<String>(
            value: name,
            alignment: Alignment.center,
            child: ZetaAvatar(
              size: ZetaAvatarSize.xxs,
              backgroundColor: color,
              image: ZetaIcon(Icons.color_lens, color: color),
            ),
          );
        }).toList(),
        onChanged: (value) {
          final theme = appThemes[value];
          if (theme != null && value != null) {
            ZetaProvider.of(context).updateThemeData(primary: theme);
            setState(() {
              currentTheme = value;
            });
          }
        },
      ),
    );
  }
}
